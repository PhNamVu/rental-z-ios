//
//  RegexPatterns.swift
//  RentalApartments
//
//  Created by Nam Vu on 08/09/2021.
//

import Foundation

enum RegexPatterns {
    static let name = "^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"
    static let number = "^[0-9]*$"
    static let require = ".*\\S.*"
}
