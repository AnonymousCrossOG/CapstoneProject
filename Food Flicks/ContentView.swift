//
//  ContentView.swift
//  Food Flicks
//
//  Created by Donis, Michael - Student on 3/6/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(FoodLibrary.self) private var library
    
    @State var cardOffset: CGSize = .zero
    
    var body: some View {
        let topFood = library.foods.last ?? .bagels // FIXME:
        NavigationStack {
            
            VStack {
                ZStack{
                    CardBgView(food: topFood)
                    ForEach(library.foods, id: \.self) { food in
                        ZStack {
                            CardView(food: food, cardOffset: $cardOffset)
                        }
                        
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
