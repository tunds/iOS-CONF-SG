//
//  FormManager.swift
//  Base Talk Project
//
//  Created by Tunde on 12/12/2021.
//

import Foundation

class FormManager: ObservableObject {
    
    @Published var sections: [FormSection]
    
    var isValid: Bool {
        sections
            .flatMap(\.inputs)
            .first(where: { $0.regex != nil && $0.state != .valid }) == nil
    }
    
    init(builder: FormBuilder) {
        self.sections = builder.build()
    }
    
    func validate() {
        for sectionIndex in 0..<sections.count {
            for inputIndex in 0..<sections[sectionIndex].inputs.count {
                sections[sectionIndex].inputs[inputIndex].validate()
            }
        }
    }
}
