//
//  ContactFormView.swift
//  Base Talk Project
//
//  Created by Tunde on 11/12/2021.
//

import SwiftUI

struct ContactFormView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = FormManager(
        builder: FormBuilder()
    )
    @State private var successAlert = false
    
    var body: some View {
        
        Form {
            
            ForEach($vm.sections) { $section in
                
                Section(header: Text(section.config.title)) {
                    
                    ForEach($section.inputs) { $input in
                        FormInputView(input: $input)
                    }
                }
            }
            
            Button(action: validate) {
                Text("Submit")
            }
        }
        .navigationTitle("Contact Us")
        .alert("Successfully Sent",
               isPresented: $successAlert) {
            Button("OK", role: .cancel) {}
        }
    }
}

private extension ContactFormView {
    
    func validate() {
        withAnimation {
            vm.validate()
            if vm.isValid {
                dismiss()
                successAlert.toggle()
            }
        }
    }
}

struct ContactFormView_Previews: PreviewProvider {
    static var previews: some View {
        ContactFormView()
            .embedInNavigationView()
    }
}
