//
//  NetworkingManager.swift
//  Base Talk Project
//
//  Created by Tunde on 25/11/2021.
//

import Foundation

// MARK: - Errors

public protocol CustomError: LocalizedError, Equatable {}

public enum NetworkingError {
    case requestFailed(reason: Error)
    case invalidStatusCode
    case failedToDecode
}

extension NetworkingError: CustomError {
    
    public static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidStatusCode, .invalidStatusCode):
            return true
        case (.failedToDecode, .failedToDecode):
            return true
        case (.requestFailed(let lhsType), .requestFailed(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default:
             return false
        }
    }

    public var errorDescription: String? {
        switch self {
        case .requestFailed:
            return "Error Occurred"
        case .invalidStatusCode:
            return "Request failed"
        case .failedToDecode:
            return "Failed to decode"
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .requestFailed(let reason):
            return reason.localizedDescription
        case .invalidStatusCode:
            return "Request didn't fall into the 200 status code"
        case .failedToDecode:
            return "Response failed to decode due to mismatch"
        }
    }
}

// MARK: - Protocol Implementations

public protocol NetworkingManagerImpl {
    func execute<T: Codable>(request: URLRequest,
                             responseType: T.Type) async throws -> T
}

// MARK: - Networking Manager

public struct NetworkingManager: NetworkingManagerImpl {
    
    public init() {}
    
    public func execute<T>(request: URLRequest,
                    responseType: T.Type) async throws -> T where T : Decodable, T : Encodable {
        
        let (data, response) = try await URLSession(configuration: .default).data(for: request)
        
        guard let urlResponse = response as? HTTPURLResponse,
              urlResponse.statusCode == 200 else {
            throw NetworkingError.invalidStatusCode
        }

        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw NetworkingError.failedToDecode
        }

        return decodedData
    }
}
