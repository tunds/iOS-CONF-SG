//
//  FormModels.swift
//  Base Talk Project
//
//  Created by Tunde on 12/12/2021.
//

import Foundation

struct FormInput: Identifiable {

    struct Config {
        let title: String
        let prompt: String
        
        init(title: String = "",
             prompt: String = "") {
            self.title = title
            self.prompt = prompt
        }
    }
    
    let id = UUID()
    let config: Config
    let regex: RegexValidator?
    var text: String = ""
    var state: RegexValidator.State?
    
    init(config: FormInput.Config,
         regex: RegexValidator? = nil,
         text: String = "",
         state: RegexValidator.State? = nil) {
        self.config = config
        self.regex = regex
        self.text = text
        self.state = state
    }
    
    mutating func validate() {
        self.state = regex?.validate(val: text)
    }
}

struct FormSection: Identifiable {

    struct Config {
        let title: String
        let footer: String
        
        init(title: String = "",
             footer: String = "") {
            self.title = title
            self.footer = footer
        }
    }
    
    let id = UUID()
    let config: Config
    var inputs: [FormInput]
    
    init(config: Config,
         items: [FormInput]) {
        self.config = config
        self.inputs = items
    }
}

