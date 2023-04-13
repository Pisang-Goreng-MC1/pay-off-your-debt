//
//  RepaySheet.swift
//  Pay Off Your Debt!
//
//  Created by Ziady Mubaraq on 13/04/23.
//

import SwiftUI
import Combine

struct RepaySheet: View {
    @State private var amount: String = ""
    @State private var repaySheet: Bool = false
    @State private var personalNote: String = ""
    @Binding var showingSheet: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    
    func isButtonDisabled() -> Bool{
        return amount.isEmpty
    }
    
    var body: some View {
        NavigationStack {
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
                        TextField("Personal Note", text: $personalNote)
                        
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
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                .navigationBarTitle("Repay",displayMode: .inline)
            }
            .background(Color(UIColor.systemGroupedBackground))
        }
        .presentationDetents([.fraction(0.4)])
        .presentationDragIndicator(.visible)
    }
}

//struct AddDebtSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        AddDebtSheet()
//    }
//}
