//
//  DetailView.swift
//  Pay Off Your Debt!
//
//  Created by Roli Bernanda on 06/04/23.
//
struct Loan {
    let amount: Int
    let type: String;
    let note: String;
    let createdAt: String;
}

import SwiftUI
import Combine

struct DetailView: View {
    let persistenceController = PersistenceController.shared
    
    var personName: String
    @State private var amount: String = ""
    @State private var personalNotes: String = ""
    @State private var newDebtSheet: Bool = false
    @State private var repaySheet: Bool = false
    @State private var showingAlert: Bool = false
    @State private var loans: [Loan] = [
        Loan(amount: 10000, type: "Lent", note: "Kopi 1 Cangkir", createdAt: "21/01/01"),
        Loan(amount: 20000, type: "Borrow", note: "Kopi 2 Cangkir", createdAt: "21/01/01"),
        Loan(amount: 30000, type: "Borrow", note: "Kopi 3 Cangkir", createdAt: "21/01/01"),
        Loan(amount: 40000, type: "Lent", note: "Kopi 4 Cangkir", createdAt: "21/01/01"),
    ]
    func isButtonDisabled() -> Bool{
        return amount.isEmpty
    }
    
    var body: some View {
        NavigationView{
            VStack{
                VStack {
                    Text ("Your Recent Debtsssss")
                    HStack {
                        Text ("- Rp.1.000.000")
                            .foregroundColor(.red)
                            .font(.system(size: 25))
                            .bold()
                        
                        Image (systemName: "eye.slash.fill")
                    }
                    HStack {
                        Button("New Debt"){
                            self.newDebtSheet.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("Repay"){
                            self.repaySheet.toggle()
                        }
                        .buttonStyle(.borderedProminent)
                        
                    }
                    Spacer()
                        .frame(minHeight:35,maxHeight:35)
                }
                .padding(.all, 20.0)
                .frame(maxWidth: .infinity)
                .background (Color("YellowBgt"))
                
                
                VStack {
                    List {
                        ForEach(loans, id: \.amount) {
                            loan in ListItem(amount: loan.amount, type: loan.type, note: loan.note, createdAt: loan.createdAt)
                        }
                        
                    }.listStyle(.plain)
                }
                
                
            }
            .navigationBarTitle("Monica", displayMode: .inline)
            .sheet(isPresented: $newDebtSheet) {
                AddDebtDetailSheet(personName: personName, showingAlert: $showingAlert, showingSheet: $newDebtSheet)
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            
            .sheet(isPresented: $repaySheet) {
                VStack {
                    List {
                        Section {
                            TextField("IDR0.00", text: $amount)
                                .keyboardType(.decimalPad)
                                .onReceive(Just(amount)) { newAmount in
                                    print(newAmount)
                                    let filtered = newAmount.filter {
                                        "0123456789".contains($0)
                                    }
                                    print (filtered)
                                    if filtered != newAmount {
                                        self.amount = filtered
                                    }
                                
                                }
                            TextField("Personal Notes", text: $personalNotes)
                            
                        }
                        Section {
                            Button {
                                self.repaySheet.toggle()
                            
                            } label: {
                                Text("Repay")
                                    .frame(maxWidth: .infinity)
                            }
                            // () ? true : false
                            .listRowBackground(isButtonDisabled() ? Color.gray : Color.accentColor)
                            .foregroundColor(Color.white)
                            .disabled(isButtonDisabled())
                        }
                    }
                }
                .background(Color(UIColor.systemGroupedBackground))
                .presentationDetents([.fraction(0.3)])
                .presentationDragIndicator(.visible)
            }
            
        }
    }
}

struct ListItem: View {
    @State var amount: Int
    @State var type: String
    @State var note: String
    @State var createdAt: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text ("I Owe Rp \(amount)")
            HStack(spacing: 5) {
                Image (systemName: "eye.slash.fill").resizable().scaledToFit().frame(width: 14)
                Text(type).font(.system(size: 14)).opacity(0.5)
            }
            Text(note).font(.system(size: 14)).opacity(0.5)
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}




