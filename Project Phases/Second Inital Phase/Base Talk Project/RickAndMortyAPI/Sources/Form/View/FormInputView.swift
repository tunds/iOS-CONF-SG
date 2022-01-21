//
//  FormInputView.swift
//  Base Talk Project
//
//  Created by Tunde on 12/12/2021.
//

import SwiftUI

struct FormInputView: View {
    
    @Binding var input: FormInput
    
    var body: some View {
        VStack(alignment: .leading) {
            
            inputField

            if case let .invalid(error) = input.state,
               let suggestion = error.recoverySuggestion {
                Text(suggestion)
                    .font(.footnote)
                    .bold()
                    .transition(.opacity)
                    .foregroundColor(.red)
            }
        }
    }
}

private extension FormInputView {
    
    var inputField: some View {
        TextField(input.config.title,
                  text: $input.text,
                  prompt: Text(input.config.prompt))
            .onChange(of: input.text, perform: validate(_:))
    }
}

private extension FormInputView {
    
    func validate(_ val: String) {
        withAnimation {
            input.validate()
        }
    }
}

struct FormInputView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            FormInputView(input: .constant(.init(config: .init(title: "Form Input",
                                                           prompt: "Form Input"))))
        }
    }
}
