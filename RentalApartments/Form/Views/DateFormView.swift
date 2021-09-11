//
//  DateFormView.swift
//  RentalApartments
//
//  Created by Nam Vu on 07/09/2021.
//

import SwiftUI

struct DateFormView: View {
    
    @EnvironmentObject var contentBuilder: FormContentBuilderImpl
    @State private var selectedDate = Date()
//    @State private var error: ValidationError?

    let component : DateFormComponent
    
    var body: some View {
        VStack(alignment: .leading) {
            DatePicker("",
                       selection: $selectedDate,
                       displayedComponents: [component.mode])
                .labelsHidden()
                .frame(maxWidth: .infinity,
                       alignment: .leading)
                .disabled(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
//            Text("Error here") .font(.system(size: 12, weight: .semibold)) .foregroundColor(.red)
    }
}
}

struct DateFormView_Previews: PreviewProvider {
    static var previews: some View {
        DateFormView(component: .init(id:.date, mode: .date))
            .environmentObject(FormContentBuilderImpl())
            .previewLayout(.sizeThatFits)
            .padding(.horizontal)
    }
}
