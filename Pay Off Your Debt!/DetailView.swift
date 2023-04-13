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

struct Dummy {
    let amount: Int
}



import SwiftUI
import Combine


struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let persistenceController = PersistenceController.shared
    
    var personName: String
    @State private var amount: String = ""
    @State private var newDebtSheet: Bool = false
    @State private var repaySheet: Bool = false
    @State private var showingAlert: Bool = false
    @State private var loans: [Loan] = [
        Loan(amount: 10000, type: "Lent", note: "Kopi 1 Cangkir", createdAt: "21/01/01"),
        Loan(amount: 20000, type: "Borrow", note: "Kopi 2 Cangkir", createdAt: "21/01/01"),
        Loan(amount: 30000, type: "Borrow", note: "Kopi 3 Cangkir", createdAt: "21/01/01"),
        Loan(amount: 40000, type: "Lent", note: "Kopi 4 Cangkir", createdAt: "21/01/01"),
    ]
    var totalAmount: Int32
    func isButtonDisabled() -> Bool{
        return amount.isEmpty
    }
    
    @State private var dummys: [Dummy] = [
        Dummy(amount: 10000)
    ]
    
    private var backButton: some View {
            Button(action: {
                // Navigate to a specific view when the back button is tapped
                presentationMode.wrappedValue.dismiss()
                // Alternatively, you could use a NavigationLink to navigate to a specific view
                //NavigationLink(destination: HomeView()) {
                //    Text("Back")
                //}
            }) {
                Image(systemName: "chevron.backward")
                Text("Back")
            }
        }
    
    
    @State private var tabType = ["Debt", "Repay"]
    @State private var selectedTab = 0
    
    var body: some View {
        ZStack (alignment: .top){
            changeColorByTypeDebt(amount: totalAmount).ignoresSafeArea()
            VStack{
                VStack{
                    Text("You Owe \(personName)")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                    Text("\(abs(totalAmount))")
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                    Text("Check your friend's pocket or unfriend them!")
                        .font(.system(size: 12))
                        .padding(.bottom, 20)
                    HStack(spacing: 40){
                        VStack{
                            Button {
                                self.newDebtSheet.toggle()
                                
                            } label: {
                                VStack {
                                    Circle()
                                        .fill(.white)
                                        .frame(height: 50)
                                        .overlay {
                                            Image(systemName: "plus")
                                                .foregroundColor(.red)
                                        }
                                    Text("New Debt")
                                        .font(.system(size: 12))
                                        .fontWeight(.bold)
                                }
                            }
                            
                        }
                        
                        VStack{
                            Button {
                                self.repaySheet.toggle()
                                
                            } label: {
                                VStack {
                                    Circle()
                                        .fill(.white)
                                        .frame(height: 50)
                                        .overlay {
                                            Image(systemName: "banknote")
                                                .foregroundColor(.red)
                                        }
                                    Text("Repay")
                                        .font(.system(size: 12))
                                        .fontWeight(.bold)
                                }
                            }
                            
                        }
                        
                    }.padding(.bottom, 24)
                    
                    
                }
                            .navigationBarBackButtonHidden(true)
                            .navigationBarItems(leading: backButton)
//                .navigationBarBackButtonHidden()
//                    .toolbar{
//                        ToolbarItem(placement: .navigationBarLeading){
//                            HStack {
//                                Image(systemName: "chevron.backward")
//                                    .font(.system(size: 20))
//                            }
//                        }
//                    }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                
                
                VStack(){
                    Picker("What is", selection:
                            $selectedTab){
                        Text("Loan").tag(0)
                        Text("Repay").tag(1)
                        
                        
                        
                    }
                            .padding(30)
                            .pickerStyle(.segmented)
                            .frame(width: 250)
                    
                    VStack {
                        List {
                            if selectedTab == 0 {
                                ForEach(loans, id: \.amount) {
                                    loan in ListItem(amount: loan.amount, type: loan.type, note: loan.note, createdAt: loan.createdAt)
                                }
                            } else {
                                ForEach(dummys, id: \.amount) {
                                    dummy in  Text("sa")
                                }
                            }
                            
                        }.listStyle(.plain)
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 20)
                .background(.white)
                .cornerRadius(24)
                .padding(.bottom, -50)
                .frame(height: 500)
            }
            
            .frame(maxWidth: .infinity)
            .background(changeColorByTypeDebt(amount: Int32(totalAmount)))
            
        }
        .sheet(isPresented: $newDebtSheet) {
            AddDebtDetailSheet(personName: personName, showingSheet: $newDebtSheet)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        
        .sheet(isPresented: $repaySheet) {
            RepaySheet(showingSheet: $repaySheet)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
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




