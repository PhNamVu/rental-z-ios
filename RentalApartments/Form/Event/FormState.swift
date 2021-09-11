//
//  FormState.swift
//  RentalApartments
//
//  Created by Nam Vu on 08/09/2021.
//

import Foundation

struct Property: Equatable {
    let type: String
    let reporter: String
    let date: Date
    let price: Int
    let bedroom: Int
    let note: String
    let furniture: String
}

enum FormState {
    case valid(property: Property)
    case fail(error: ValidationError)
}

extension FormState: Equatable {
    static func == (lhs: FormState, rhs: FormState) -> Bool {
        switch (lhs, rhs) {
        case (.valid(property: let lhsType),
              .valid(property: let rhsType)):
            return lhsType == rhsType
        case (.fail(error: let lhsType),
              .fail(error: let rhsType)):
            return lhsType.errorDescription == rhsType.errorDescription
        default:
            return false
        }
    }
}
