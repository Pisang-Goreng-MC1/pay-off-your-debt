//
//  DetailView.swift
//  Pay Off Your Debt!
//
//  Created by Roli Bernanda on 06/04/23.
//
import SwiftUI
import Combine
import CoreData


struct DetailView: View {
    @Environment(\.presentationMode) var presentationMode
    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Debt.entity(), sortDescriptors: []) var debts: FetchedResults<Debt>
    
    
    @State var personName: String
    @State private var amount: String = ""
    @State private var newDebtSheet: Bool = false
    @State private var repaySheet: Bool = false
    @State private var showingAlert: Bool = false
    @State private var messageInDetail = ""
    @State private var isDebt = true
    
    var totalAmount: Int32
    func isButtonDisabled() -> Bool{
        return amount.isEmpty
    }
    
    private func getListDebts () -> [Debt] {
        print("Running Debt")
        return debts.filter {$0.person?.name == personName && $0.type != "Repay"}.sorted { $0.createdAt ?? Date() > $1.createdAt ?? Date() }
    }
    
    private func getListRepay () -> [Debt] {
        return debts.filter {$0.person?.name == personName && $0.type == "Repay"}.sorted { $0.createdAt ?? Date() > $1.createdAt ?? Date() }
    }
    
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
                    Text("You \(getDebtTypeByAmount(totalAmount: totalAmount)) \(personName)")
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                    Text("\(showSummary(totalAmount: totalAmount, isMoneyShow: true))")
                        .font(.system(size: 32))
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    Text(messageInDetail)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20.0)
                        .lineLimit(nil)
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
                                                .foregroundColor(changeColorByTypeDebt(amount: Int32(totalAmount)))
                                                .font(.system(size: 22))
                                        }
                                    
                                    Text("New Debt")
                                        .font(.system(size: 12))
                                        .fontWeight(.bold)
                                }
                            }
                            
                        }
                        
                        if(totalAmount < 0) {
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
                                                    .foregroundColor(changeColorByTypeDebt(amount: Int32(totalAmount)))
                                                    .font(.system(size: 22))
                                            }
                                        
                                        Text("Repay")
                                            .font(.system(size: 12))
                                            .fontWeight(.bold)
                                    }
                                }
                                
                                
                            }
                        }
                        
                        
                        
                    }.padding(.bottom, 20)
                    
                    
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
                .onAppear{
                    messageInDetail = getMessagesByDebtType(label: getDebtTypeByAmount(totalAmount: totalAmount))
                }
                
                
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
                                ForEach(getListDebts(), id: \.id) {
                                    debt in ListItem(amount: debt.amount, type: debt.type ?? "", personalNote: debt.personalNote == "" ? "-": debt.personalNote ?? "-" )
                                }
                            } else {
                                ForEach(getListRepay(), id: \.id) {
                                    repay in ListItem(amount: repay.amount, type: repay.type ?? "", personalNote: repay.personalNote == "" ? "-" : repay.personalNote ?? "-")
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
            }
            
            .frame(maxWidth: .infinity)
            .background(changeColorByTypeDebt(amount: Int32(totalAmount)))
            
        }
        .sheet(isPresented: $newDebtSheet) {
            AddDebtDetailSheet(personName: personName, showingSheet: $newDebtSheet)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.colorScheme, .light)
        }
        
        .sheet(isPresented: $repaySheet) {
            RepaySheet(showingSheet: $repaySheet, person: personName)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.colorScheme, .light)
        }
        
        
    }
    
    
}




struct ListItem: View {
    @State var amount: Int32
    @State var type: String
    @State var personalNote: String
    //    @State var createdAt: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text ("I \(type) Rp \(amount)")
            HStack(spacing: 5) {
                Image (systemName: type == "Owe" ? "arrow.down" : "arrow.up").resizable().scaledToFit().frame(width: 14).foregroundColor(type == "Owe" ? Color.red : Color.green)
                Text(type).font(.system(size: 14)).opacity(0.5)
            }
            Text(personalNote).font(.system(size: 14)).opacity(0.5)
        }
    }
}


//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView()
//    }
//}




