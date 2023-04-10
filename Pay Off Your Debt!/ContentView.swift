//
//  ContentView.swift
//  Pay Off Your Debt!
//
//  Created by Ziady Mubaraq on 03/04/23.
//

import SwiftUI






/*
 Sebelumnya Zady hutang ke Afif = Rp50.000
 
 Ziady hutang ke Afif = Rp20.000
 - contact: Afif
 - type: Borrow
 - amount: 20000
 - date: 6, Apr 2023
 - repaymentDate: 10, Apr 2023
 - personalNote: "pinjem yak"
 
 Ziady bayar hutang ke Afif = Rp30.000
 
 Perhitungan akhir, Ziady hutang ke Afif Rp40.000
 
 */


struct ContentView: View {
    
    
    var body: some View {
        VStack {
            List {
                ForEach(debts) { debt in
                    VStack {
                        Text(debt.person.name)
                        Text(String(debt.amount))
                        Text(debt.personalNote)
                        Text(debt.repaymentDate, style: .date)
                        Text(debt.type.name)
                    }
                    
                }
            }
            .listStyle(.plain)
            
            Button("New Debt") {
                self.showingSheet.toggle()
            }
            .buttonStyle(.borderedProminent)
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}

