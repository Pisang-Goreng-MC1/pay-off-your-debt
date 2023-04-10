//
//  ContactView.swift
//  Pay Off Your Debt!
//
//  Created by Ziady Mubaraq on 03/04/23.
//

import SwiftUI

struct ContactView: View {
    // Status
    @Binding var showingContact: Bool
    @Binding var contact: String
    
    var body: some View {
        NavigationView {
            NavigationStack {
                List {
                    HStack {
                        Image(systemName: "person.fill")
                            .frame(width: 32, height: 32)
                            .background(Color(UIColor.systemGroupedBackground))
                            .clipShape(Circle())
                            .foregroundColor(Color.accentColor)
                        VStack {
                            Text("Person 1")
                        }
                    }
                    .onTapGesture {
                        contact = "Person 1"
                        showingContact = false
                    }
                    HStack {
                        Image(systemName: "person.fill")
                            .frame(width: 32, height: 32)
                            .background(Color(UIColor.systemGroupedBackground))
                            .clipShape(Circle())
                            .foregroundColor(Color.accentColor)
                        VStack {
                            Text("Person 2")
                        }
                    }
                    .onTapGesture {
                        contact = "Person 2"
                        showingContact = false
                    }
                    HStack {
                        Image(systemName: "person.fill")
                            .frame(width: 32, height: 32)
                            .background(Color(UIColor.systemGroupedBackground))
                            .clipShape(Circle())
                            .foregroundColor(Color.accentColor)
                        VStack {
                            Text("Person 3")
                        }
                    }
                    .onTapGesture {
                        contact = "Person 3"
                        showingContact = false
                    }
                    HStack {
                        Image(systemName: "person.fill")
                            .frame(width: 32, height: 32)
                            .background(Color(UIColor.systemGroupedBackground))
                            .clipShape(Circle())
                            .foregroundColor(Color.accentColor)
                        VStack {
                            Text("Person 4")
                        }
                    }
                    .onTapGesture {
                        contact = "Person 4"
                        showingContact = false
                    }
                    HStack {
                        Image(systemName: "person.fill")
                            .frame(width: 32, height: 32)
                            .background(Color(UIColor.systemGroupedBackground))
                            .clipShape(Circle())
                            .foregroundColor(Color.accentColor)
                        VStack {
                            Text("Person 5")
                        }
                    }
                    .onTapGesture {
                        contact = "Person 5"
                        showingContact = false
                    }
                }
                .listStyle(.plain)
            }
            .navigationBarTitle("Contacts",displayMode: .automatic)
            .navigationBarItems(
                leading:Button("Back", action: {
                    print("Button Clicked")
                    showingContact = false
                })
            )
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
    }
    
    struct roundedCorner: Shape {
        var radius: CGFloat = .infinity
        var corners: UIRectCorner = .allCorners
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            
            return Path(path.cgPath)
        }
    }
}

//struct ContactView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactView()
//    }
//}
