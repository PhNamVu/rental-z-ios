//
//  FormContentBuilder.swift
//  RentalApartments
//
//  Created by Nam Vu on 07/09/2021.
//

import Foundation

protocol FormContentBuilder {
    var content: [FormComponent] { get }
    var state: FormState? { get }
    func update(_ val: Any, in component: FormComponent)
    func validate()
    
}

final class FormContentBuilderImpl: ObservableObject , FormContentBuilder {
    
    @Published private(set) var state: FormState?
    
    
    private(set) var content: [FormComponent] = [
        TextFormComponent(id: .reporter,
                          placeholder: "Reporter name",
                          validations: [
                            RegexValidationManagerImpl(
                                [
                                    RegexFormItem(pattern: RegexPatterns.name,
                                                  error: .custom(message: "Invalid reporter name entered") )
                                ]
                            )
                          ]
        ),
        TextFormComponent(id: .type,
                          placeholder: "Property type",
                          validations: [
                            RegexValidationManagerImpl(
                                [
                                    RegexFormItem(pattern: RegexPatterns.name,
                                                  error: .custom(message: "Invalid type entered") )
                                ]
                            )
                          ]
        ),
        TextFormComponent(id: .bedroom,
                          placeholder: "Bed room",

                          validations: [
                            RegexValidationManagerImpl(
                                [
                                    RegexFormItem(pattern: RegexPatterns.number,
                                                  error: .custom(message: "Enter number of room") ),
                                    RegexFormItem(pattern: RegexPatterns.require,
                                                  error: .custom(message: "Please enter room amount") )
                                ]
                            )
                          ]
        ),
        TextFormComponent(id: .price,
                          placeholder: "Price",

                          validations: [
                            RegexValidationManagerImpl(
                                [
                                    RegexFormItem(pattern: RegexPatterns.number,
                                                  error: .custom(message: "Please enter price in number") ),
                                    RegexFormItem(pattern: RegexPatterns.require,
                                                  error: .custom(message: "Please enter price") )
                                ]
                            )
                          ]
 ),
        TextFormComponent(id: .note, placeholder: "Note"),
        TextFormComponent(id: .furniture, placeholder: "Furniture"),

        DateFormComponent(id: .date, mode: .date),
        ButtonFormComponent(id: .submit, title: "Confirm")
    ]
    func update(_ val: Any, in component: FormComponent) {
        guard let index = content.firstIndex(where: { $0.id == component.id }) else { return }
        content[index].val = val

    }
    
    func validate() {
        let formComponents = content
            .filter{ $0.formId != .submit }
        for component in formComponents {
            for  validator in component.validations {
                if let error = validator.validate(component.val as Any) {
                    self.state = .fail(error: error)
                    return
                }
            }
            
        }
        
        if let reporter = formComponents.first(where: { $0.formId == .reporter})?.val as? String,
           let note = formComponents.first(where: { $0.formId == .note})?.val as? String,
           let type = formComponents.first(where: { $0.formId == .type})?.val as? String,
           let furniture = formComponents.first(where: { $0.formId == .furniture})?.val as? String,
           let bedroom = formComponents.first(where: { $0.formId == .bedroom})?.val as? Int,
           let price = formComponents.first(where: { $0.formId == .price})?.val as? Int,
           let date = formComponents.first(where: { $0.formId == .reporter})?.val as? Date {
                let newProperty = Property(
                        type: type,
                        reporter: reporter,
                        date: date,
                        price: price,
                        bedroom: bedroom,
                        note: note,
                        furniture: furniture
                    )
            self.state = .valid(property: newProperty)
            
           }
           
    }
    
}
