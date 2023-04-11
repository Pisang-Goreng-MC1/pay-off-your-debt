//
//  HomeView.swift
//  Pay Off Your Debt!
//
//  Created by Muhammad Afif Maruf on 06/04/23.
//

import SwiftUI

struct DebtType: Identifiable {
    let id = UUID()
    var name: String
}

//struct Person: Identifiable {
//    let id = UUID()
//    var name: String
//    var phoneNumber: String
//}
//
//struct Wallet: Identifiable {
//    let id = UUID()
//    var person: Person
//    var totalAmount: Int
//    var debt: [Debt]
//    var repay: [Repay]
//
//    func addDebt(debt: Debt) {
//
//    }
//}
//
//
//struct Debt: Identifiable {
//    let id = UUID()
//    var person: Person
//    var amount: String
//    var personalNote: String
//    var repaymentDate: Date
//    var type: DebtType
//
//    init(person: Person, amount: String, personalNote: String, repaymentDate: Date, type: DebtType) {
//        self.person = person
//        self.amount = amount
//        self.personalNote = personalNote == "" ? "-" : personalNote
//        self.repaymentDate = repaymentDate
//        self.type = type
//    }
//}
//
//struct Repay: Identifiable {
//    let id = UUID()
//    let idWallet: Int
//    var date: Date
//    var amount: Int
//}

struct HomeView: View {
    @State var goToPage: Bool = false
    
    // Initial Data
    @State var People: [Person] = []
    @State var debtTypes: [DebtType] = [
        DebtType(name: "Lent"),
        DebtType(name: "Owe")]
//    @State var debts: [Debt] = [Debt]()
//    @State var repays: [Repay] = []
//    @State var wallets: [Wallet] = []
    
    
    // Status
    @State private var showingSheet: Bool = false
    @State private var showingAlert: Bool = false
    @State private var showingContacts: Bool = false
    
    // Data
    @State private var person: String = "Contact"
    @State private var amount: String = "0"
    @State private var personalNote: String = ""
    @State private var repaymentDate: Date = Date()
    @State private var debtType: String = "Owe"
    
    
    @State private var isSummaryShow : Bool = true
    @State private var summary : Int = 10000
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var wallets: FetchedResults<Wallet>
    
    var body: some View {
        NavigationStack{
            
            NavigationLink(destination: DetailView(), isActive: $goToPage) {
                EmptyView()
            }
            VStack {
                //Header Debt
                VStack{
                    //Title and add button
                    HStack{
                        Text("🙌Hi, Buddy!")
                            .fontWeight(.medium)
                        Spacer()
                        NavigationLink( destination: EmptyView()){
                            Image(systemName: "plus")
                        }
                    }
                    .padding(.all)
                    .font(.title2)
                    
                    Text("You Lent")
                        .fontWeight(.medium)
                    HStack(alignment: .center){
                        Text(showSummary(totalAmount: summary, isMoneyShow: isSummaryShow))
                            .fontWeight(.heavy)
                        Image(systemName: isSummaryShow ? "eye.slash" : "eye.fill")
                            .onTapGesture {
                                isSummaryShow.toggle()
                            }
                    }
                    .font(.largeTitle)
                    
                    Text("Check your friend's pocket or unfriend them!")
                        .fontWeight(.ultraLight)
                        .padding(.bottom, 60)
                }
                .foregroundColor(.white)
                // Active Debt
                VStack(alignment: .leading){
                    Text("Active debts")
                        .font(.title2)
                        .fontWeight(.heavy)
                        .padding(.vertical, 20)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    // TODO: Create debtcard view with a list
                    ScrollView{
                        VStack(spacing: 20){
                            ForEach(wallets, id: \.id) {
                                wallet in DebtCard(personName: wallet.person?.name ?? "Unknown", type: "owe", totalAmount: wallet.totalAmount, cardColor: "CardPrimary")
                            }
//                            DebtCard(cardColor: "CardPrimary")
//                            DebtCard(cardColor: "CardPrimary")
//                            DebtCard(cardColor: "CardSecondary")
//                            DebtCard(cardColor: "CardPrimary")
//                            DebtCard(cardColor: "CardPrimary")
//                            DebtCard(cardColor: "CardSecondary")
                        }
                    }
                    .padding(.bottom)
                    .frame(height: 500)
                    Spacer()
                }
                .padding(.horizontal, 20)
                .background(.white)
                .cornerRadius(24)
                .padding(.bottom, -50)
                //.cornerRadius(36, corners: [.topLeft, .topRight])
            }
            .background(.blue)
            .toolbar{
                Button{
                    showingSheet.toggle()
                }label: {
                    Image(systemName: "plus")
                }
                
            }
            .sheet(isPresented: $showingSheet) {
                    VStack {
                        List {
                            Section {
                                HStack {
                                    Text(person)
                                    Spacer()
                                    Label("Contact", systemImage: "plus.circle")
                                        .font(.title3)
                                        .labelStyle(.iconOnly)
                                }
                                .onTapGesture {
                                    self.showingContacts = true
                                }
                                .sheet(isPresented: $showingContacts) {
                                    ContactView(showingContact: $showingContacts, contact: $person)
                                }
                                TextField("IDR0.00", text: $amount)
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
                                TextField("Personal Note", text: $personalNote)
                            }
                            Section {
                                HStack {
                                    Text("Type")
                                    Spacer()
                                    Picker("", selection: $debtType) {
                                        Text("Owe").tag("Owe")
                                        Text("Lent").tag("Lent")
                                    }
                                }
                            }
                            Section {
                                Button {
                                    self.showingSheet.toggle()
                                    addDebt() // TODO:
                                    self.goToPage = true
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
                    .presentationDetents([.large])
                    .presentationDragIndicator(.visible)
                
            }
        }
    }
    
    //function show total money
    func showSummary(totalAmount: Int, isMoneyShow: Bool) -> String{
        let stringMoney : String = String(totalAmount)
        //formater to currency indonesia
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        
        if isMoneyShow{
            return ("RP. \(formatter.string(for: totalAmount) ?? "0")")
        }else{
            return ("RP. \(stringToAsterisk(value: stringMoney))")
            
        }
        
    }
    
    //function convert to asterisk
    func stringToAsterisk(value : String) -> String{
        return String(repeating: "*", count: value.count)
    }
    
    
    private func addDebt() {
        withAnimation {
            
            // TODO:  Kalo belum ada walletnya create baru. Kalo dah ada langsung tambahin debt di walletnya
            // TODO: kalo target person blm ada create baru, kalo dah ada langsung tambahin
            let newWallet = Wallet(context: viewContext)
            let newDebt = Debt(context: viewContext)
            let newPerson = Person(context: viewContext)
            
            newWallet.id = UUID()
            newWallet.totalAmount = 10000 // TODO: integrate
            
            newPerson.id = UUID() //
            newPerson.name = "ME" // TODO:
            
            newDebt.id = UUID()
            newDebt.amount = 20000 // TODO: Integrate
            newDebt.personalNote = "note" // TODO: Integrate
            newDebt.type = "owe" // TODO: Integrate
            newDebt.repaymentDate = Date()
            
            newWallet.person = newPerson
            newWallet.debt = newDebt
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func AddRepay() {
        // TODO:
    }
}

//Debt Card Components
struct DebtCard: View {
    @State var personName: String
    @State var type: String // TODO: hitung banyakan hutang atau ngutangin
    @State var totalAmount: Int32
//    @State var createdAt: String // TODO:
    
    var cardColor : String
    
    var body: some View {
        NavigationLink(destination: EmptyView()){
            HStack(spacing: 60.0){
                Text("\(personName)")
                VStack(){
                    Text("I \(type) RP. \(totalAmount)") // TODO: Format currency
                    Text("31 days ago") // TODO
                }
                
            }
            .padding(.horizontal, 10.0)
            .frame(width: 360, height: 100, alignment: .center)
            .background(Color(cardColor))
            .foregroundColor(.white)
            .cornerRadius(19)
            .contextMenu(){
                NavigationLink(destination: EmptyView()) {
                    Label("Repay", systemImage: "checkmark.circle.fill")
                }
                Button (role: .destructive){
                    // Open Maps and center it on this item.
                } label: {
                    Label("Delete", systemImage: "trash")
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
