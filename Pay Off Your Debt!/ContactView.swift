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
            //contact get name and grouping by alphabet + show in 
            List {
                ForEach(groupedContacts, id: \.key) { key, values in
                                    Section(header: Text(key).font(.system(size: 12))) {
                                        ForEach(values, id: \.self) { singleContact in
                                            ExtractedView(contact: $contact, showingContact: $showingContact, name: singleContact.givenName)
                                        }
                    }
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
    
    var groupedContacts: [(key: String, values: [CNContact])] {
            Dictionary(grouping: contacts, by: { String($0.givenName.prefix(1)).uppercased() })
                .sorted(by: { $0.key < $1.key })
                .map { key, values in
                                (key: key, values: values)
                            }
        }
    
    func fetchContacts() async{
        let keys = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey]
        let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
        
        do {
            try CNContactStore().enumerateContacts(with: request) { contact, stop in
                self.contacts.append(contact)
                self.contacts.sort { $0.givenName.lowercased() < $1.givenName.lowercased() }
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
            VStack {
                Text(name)
            
        }
        .onTapGesture {
            contact = name
            showingContact = false
        }
    }
}
