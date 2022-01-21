//
//  FormBuilder.swift
//  Base Talk Project
//
//  Created by Tunde on 12/12/2021.
//

import Foundation
import RegexValidator

class FormBuilder {
    
    func build() -> [FormSection] {
     
        let generalFieldRegexValidators = RegexValidator(configs: [
            .init(pattern:  #"^.{0}$"#,
                  error: FormError.emptyField)
        ])
        
        let issueTxtField = FormInput(config: .init(title: "Issue Title",
                                                        prompt: "Give your issue a title"),
                                      regex: generalFieldRegexValidators)
        let issueSection = FormSection(config: .init(title: "Title"),
                                       items: [issueTxtField])
        
        let descriptionTxtField = FormInput(config: .init(title: "Issue Description",
                                                        prompt: "Give your issue a brief description"),
                                            regex: generalFieldRegexValidators)
        let descriptionSection = FormSection(config: .init(title: "Description"),
                                       items: [descriptionTxtField])
        
        let deviceModelTxtField = FormInput(config: .init(title: "Device Model (Optional)",
                                                        prompt: "Specify your device"))
        let deviceModelSection = FormSection(config: .init(title: "Device (Optional)"),
                                       items: [deviceModelTxtField])
        
        let osTxtField = FormInput(config: .init(title: "OS (Optional)",
                                                        prompt: "Specify your OS i.e. 15.1"))
        let osSection = FormSection(config: .init(title: "OS (Optional)"),
                                       items: [osTxtField])
        
        return [issueSection,
                descriptionSection,
                deviceModelSection,
                osSection]
    }
}
