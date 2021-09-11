//
//  ValidationError.swift
//  RentalApartments
//
//  Created by Nam Vu on 08/09/2021.
//

import Foundation

enum ValidationError: Error {
    case custom(message: String)
}

extension ValidationError {
    var errorDescription: String {
        switch self {
        case .custom(let message):
            return message
        }
        }
}
