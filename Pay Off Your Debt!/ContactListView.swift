//
//  ContactListView.swift
//  Pay Off Your Debt!
//
//  Created by Muhammad Afif Maruf on 10/04/23.
//

import SwiftUI
import Contacts

struct ContactListView: View {
    @State private var contacts: [CNContact] = []
        
        var body: some View {
            NavigationView {
                List {
                    ForEach(contacts, id: \.self) { contact in
                        Text("\(contact.givenName) \(contact.familyName)")
                        ForEach(contact.phoneNumbers, id: \.self) { number in
                            Text("\(number.value.stringValue)")
                        }
                    }
                }
                .navigationBarTitle("Contacts")
            }
            .onAppear {
                Task.init {
                    await fetchContacts()
                }
            }
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

//struct ContactListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactListView()
//    }
//}
