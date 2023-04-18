//
//  DebtCard.swift
//  Pay Off Your Debt!
//
//  Created by Muhammad Afif Maruf on 11/04/23.
//

import SwiftUI
import CoreData

struct DebtCard: View {
    //view context
    let persistenceController = PersistenceController.shared
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var personName: String
    //    @State var type: String // TODO: hitung banyakan hutang atau ngutangin
    var totalAmount: Int32
    
    //function to get days ago from descending
//    func daysAgo(for personName: String) -> Int {
//        let request = NSFetchRequest<Debt>(entityName: "Debt")
//        request.sortDescriptors = [NSSortDescriptor(keyPath: \Debt.createdAt, ascending: false)]
//        request.fetchLimit = 1
//        request.predicate = NSPredicate(format: "person.name == %@ AND type IN %@",
//                                        personName, ["Owe", "Lent"])
//
//        do {
//            let results = try viewContext.fetch(request)
//            if let latestDebt = results.first, let createdAt = latestDebt.createdAt {
//                let calendar = Calendar.current
//                let today = calendar.startOfDay(for: Date())
//                let createdAtDay = calendar.startOfDay(for: createdAt)
//                let components = calendar.dateComponents([.day], from: createdAtDay, to: today)
//
//                return components.day ?? 0
//            }
//        } catch {
//            // handle error
//        }
//
//        return 0 // default value
//    }
    
    var body: some View {
        NavigationLink(destination: DetailView(personName: personName, totalAmount: totalAmount).environment(\.managedObjectContext, persistenceController.container.viewContext)){
            HStack(){
                Grid {
                    GridRow {
                        Text("\(personName)")
                            .bold()
                        Spacer()
                        
                        VStack(alignment: .trailing){
                            Text("\(moneyFormater(amount: totalAmount))")
                                .foregroundColor((totalAmount < 0 ? .red : .green))
                                .fontWeight(.bold)
//                            Text("\(daysAgo(for: personName)) days ago")
//                                .italic()// TODO
                        }
                    }
                }
                .padding(.vertical, 15)
                
                
            }
            .foregroundColor(.black)
        }
    }
}

struct DebtCard_Previews: PreviewProvider {
    static var previews: some View {
        DebtCard(personName: "Alexander MonMon", totalAmount: 10000)
    }
}
