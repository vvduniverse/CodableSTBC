//
//  ContentView.swift
//  CodableSTBC
//
//  Created by Vahtee Boo on 31.03.2022.
//

import SwiftUI

struct CustomModel: Identifiable, Codable {
    let id: String
    let name: String
    let points: Int
    let isPremium: Bool
}

class CodableViewModel: ObservableObject {
    
    @Published var customer: CustomModel?
    
    init() {
        getData()
    }
    
    func getData() {
        
        guard let data = getJSONData() else { return }
        
        self.customer = try? JSONDecoder().decode(CustomModel.self, from: data)

    }
    
    func getJSONData() -> Data? {
        
        let customer = CustomModel(id: "333", name: "Anna", points: 7, isPremium: true)
        let jsonData = try? JSONEncoder().encode(customer)

        return jsonData
    }
    
}

struct ContentView: View {
    
    @StateObject var vm = CodableViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            if let customer = vm.customer {
                Text(customer.id)
                Text(customer.name)
                Text("\(customer.points)")
                Text(customer.isPremium.description)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



