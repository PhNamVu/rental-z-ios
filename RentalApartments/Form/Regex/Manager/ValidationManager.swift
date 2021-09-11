//
//  ValidationManager.swift
//  RentalApartments
//
//  Created by Nam Vu on 08/09/2021.
//

import Foundation

protocol ValidationManager {
    func validate(_ val: Any) -> ValidationError?
}

//Regular validate

struct RegexValidationManagerImpl: ValidationManager {
    private let items: [RegexFormItem]
    
    init(_ items: [RegexFormItem]) {
        self.items = items
    }
    
    func validate(_ val: Any) -> ValidationError? {
        let val = (val as? String) ?? ""
        
        for regexItem in items {
            let regex = try? NSRegularExpression(pattern: regexItem.pattern)
            let range = NSRange(location: 0, length: val.count)
            if regex?.firstMatch(in: val, options: [], range: range) == nil {
                return regexItem.error
            }
        }
        return nil
    }
}
