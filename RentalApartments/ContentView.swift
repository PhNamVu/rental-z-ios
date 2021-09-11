//
//  ContentView.swift
//  RentalApartments
//
//  Created by Nam Vu on 07/09/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var contentBuilder = FormContentBuilderImpl()
    
    var body: some View {
        ScrollView {
            Text("Register")
                .padding(.top, 20)
                .font(.system(size: 40, weight: .medium))
            LazyVGrid(columns: [GridItem(.flexible(minimum: 40))],
                      spacing: 20) {
                        ForEach(contentBuilder.content) { component in
                            switch component {
                            case is TextFormComponent:
                                TextFieldFormView(component: component as! TextFormComponent)
                                    .environmentObject(contentBuilder)
                            case is DateFormComponent:
                                DateFormView(component: component as! DateFormComponent)
                                    .environmentObject(contentBuilder)
                            case is ButtonFormComponent:
                                ButtonFormView(component: component as! ButtonFormComponent) {
                                    id in
                                    switch id {
                                        case .submit:
                                            contentBuilder.validate()
                                        default:
                                            break
                                    }
                                }
                            default: EmptyView() }
                        }
                    } .padding(.top, 100)
            
        }
            .padding(.horizontal)
        .onChange(of: contentBuilder.state,
                  perform: { state in
                    switch state {
                        
                        case .valid(let property):
                            print("Form is valid with property: \(property)")
                        case .fail(let error):
                            print("Failed: \(error.errorDescription)")
                        case .none:
                            break
                    }
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
