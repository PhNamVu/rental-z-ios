//
//  FormItem.swift
//  RentalApartments
//
//  Created by Nam Vu on 07/09/2021.
//

import Foundation
import UIKit
import SwiftUI


protocol FormItem {
    var id: UUID { get }
    var formId: FormField { get }
    var validations: [ValidationManager]  { get }
    var val: Any? { get }
}

enum FormField {
    case type
    case reporter
    case bedroom
    case date
    case price
    case furniture
    case note
    case submit
}


class FormComponent: FormItem, Identifiable {
    let id = UUID()
    let formId: FormField
    var validations: [ValidationManager]
    var val: Any?
    init(_ id: FormField,
         validations: [ValidationManager] = []) {
        self.formId = id
        self.validations = validations
    }
}


/**
    Text Component
 */

final class TextFormComponent: FormComponent {
    
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    init(id: FormField,
         placeholder: String,
         keyboardType: UIKeyboardType = .default,
         validations: [ValidationManager] = []) {
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        super.init(id, validations: validations)
    }
}

/**
    Date Component
 */

final class DateFormComponent: FormComponent {
    let mode: DatePickerComponents
    
    init(id: FormField, mode: DatePickerComponents) {
        self.mode = mode
        super.init(id)
    }
}


/**
 Button Component
 */

final class ButtonFormComponent: FormComponent {
    let title: String
    
    init(id: FormField, title: String) {
        self.title = title
        super.init(id)
    }
}
