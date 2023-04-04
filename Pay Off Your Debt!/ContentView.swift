//
//  ContentView.swift
//  Pay Off Your Debt!
//
//  Created by Ziady Mubaraq on 03/04/23.
//

import SwiftUI

struct ContentView: View {
    // Status
    @State var showingSheet: Bool = false
    @State var showingAlert: Bool = false
    @State var showingContacts: Bool = false
    
    // Data
    @State var contact: String = "Contact"
    @State var nominal: String = ""
    @State var note: String = ""
    @State var repaymentDate: Date = Date()
    @State var type: String = "Borrow"
    
    //    var numberFormatter: NumberFormatter = {
    //        let formatter = NumberFormatter()
    //        formatter.numberStyle = .currency
    //        return formatter
    //    }()
    
    var body: some View {
        VStack {
            Text(contact)
            Text(nominal)
            Text(note)
            Text(repaymentDate, style: .date)
            Text(type)
            Button("New Debt") {
                showingSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $showingSheet) {
                NavigationView {
                    VStack {
                        List {
                            Section {
                                HStack {
                                    Text(contact)
                                    Spacer()
                                    Label("Contact", systemImage: "plus.circle")
                                        .font(.title3)
                                        .labelStyle(.iconOnly)
                                }
                                .onTapGesture {
                                    self.showingContacts = true
                                }
                                .sheet(isPresented: $showingContacts) {
                                    ContactView(showingContact: $showingContacts, contact: $contact)
                                }
                                TextField("IDR0.00", text: $nominal)
                                HStack {
                                    Text("Repayment Date")
                                    Spacer()
                                    DatePicker(
                                        "",
                                        selection: $repaymentDate,
                                        in: Date()...,
                                        displayedComponents: [.date]
                                    )
                                }
                                TextField("Personal Note", text: $note)
                            }
                            Section {
                                HStack {
                                    Text("Type")
                                    Spacer()
                                    Picker(selection: $type, label: Text("")) {
                                        Text("Borrow").tag("Borrow")
                                        Text("Lend").tag("Lend")
                                    }
                                }
                            }
                            Section {
                                Button {
                                    self.showingSheet.toggle()
                                } label: {
                                    Text("Save")
                                        .frame(maxWidth: .infinity)
                                }
                                .listRowBackground(Color.accentColor)
                                .foregroundColor(Color.white)
                            }
                            
                        }
                        .scrollDisabled(true)
                        .scrollContentBackground(.hidden)
                        .alert(isPresented: self.$showingAlert) {
                            Alert(title: Text("Contact on Pressed!"), dismissButton: .default(Text("Dismiss")))
                        }
                        .navigationBarTitle("New Debt",displayMode: .inline)
                        .navigationBarItems(
                            leading:Button("Cancel", action: {
                                self.showingSheet.toggle()
                            })
                        )
                    }
                    .background(Color(UIColor.systemGroupedBackground))
                }
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

