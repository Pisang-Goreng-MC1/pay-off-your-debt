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
    
    @State private var searchText = ""
    @State private var showCancelButton: Bool = false
    
    var body: some View {
        NavigationStack {
            //contact get name and grouping by alphabet + show in
            VStack{
                HStack {
                        HStack {
                           //search bar magnifying glass image
                           Image(systemName: "magnifyingglass").foregroundColor(.secondary)
                                    
                           //search bar text field
                           TextField("search", text: self.$searchText, onEditingChanged: { isEditing in
                           self.showCancelButton = true
                           })
                           
                           // x Button
                           Button(action: {
                               self.searchText = ""
                           }) {
                               Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                                      .opacity(self.searchText == "" ? 0 : 1)
                              }
                    }
                     .padding(8)
                     .background(Color(.secondarySystemBackground))
                     .cornerRadius(8)
                                
                      // Cancel Button
                      if self.showCancelButton  {
                          Button("Cancel") {
                             UIApplication.shared.endEditing(true)
                             self.searchText = ""
                             self.showCancelButton = false
                       }
                     }
                   }
                    .padding([.leading, .trailing,.top])
                
                List {
                    ForEach(groupedContacts, id: \.key) { key, values in
                                        Section(header: Text(key).font(.system(size: 12))) {
                                            ForEach(values, id: \.self) { singleContact in
                                                if self.searchText.isEmpty || singleContact.givenName.localizedCaseInsensitiveContains(self.searchText) {
                                                    ExtractedView(contact: $contact, showingContact: $showingContact, name: singleContact.givenName)
                                                }
                                            }
                        }
                    }
                }
                
                
//                List {
//                               ForEach (self.contacts.filter({ (cont) -> Bool in
//                                   self.searchText.isEmpty ? true :
//                                       "\(cont)".lowercased().contains(self.searchText.lowercased())
//                               })) { contact in
//                                   ContactRow(contact: contact)
//                               }
//                           }.onAppear() {
//                               self.requestAccess()
//                           }
                
                
                
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
            
        }
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
        
    }
    
    var groupedContacts: [(key: String, values: [CNContact])] {
        let filteredContacts = contacts.filter { contact in
                searchText.isEmpty || contact.givenName.localizedCaseInsensitiveContains(searchText)
            }
            
            return Dictionary(grouping: filteredContacts, by: { String($0.givenName.prefix(1)).uppercased() })
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

extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}
