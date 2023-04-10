//
//  ContactView.swift
//  Pay Off Your Debt!
//
//  Created by Ziady Mubaraq on 03/04/23.
//

import SwiftUI
import Contacts

struct ContactView: View {
    // Status
    @Binding var showingContact: Bool
    @Binding var contact: String
    @State var selectionContact: String = "Person 1"
    @State private var contacts: [CNContact] = []
    
    var body: some View {
        NavigationStack {
            //contact get name
            List {
                ForEach(contacts, id: \.self){ singleContact in
                    ExtractedView(contact: $contact, showingContact: $showingContact, name: singleContact.givenName)
                }
            }
            .onAppear{
                Task.init{
                    await fetchContacts()
                }
            }
            .listStyle(.plain)
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
    
    func fetchContacts() async{
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        
        do {
            try CNContactStore().enumerateContacts(with: request) { contact, stop in
                self.contacts.append(contact)
            }
        } catch {
            print("Error fetching contacts: \(error.localizedDescription)")
        }
    }
}

//struct ContactView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactView(showingContact: .constant(false), contact: .constant("nama"))
//    }
//}

struct ExtractedView: View {
    @Binding var contact: String
    @Binding var showingContact: Bool
    var name: String
    var body: some View {
        HStack {
            Image(systemName: "person.fill")
                .frame(width: 32, height: 32)
                .background(Color(UIColor.systemGroupedBackground))
                .clipShape(Circle())
                .foregroundColor(Color.accentColor)
            VStack {
                Text(name)
            }
        }
        .onTapGesture {
            contact = name
            showingContact = false
        }
    }
}
