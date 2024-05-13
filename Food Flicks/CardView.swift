//  CardView.swift
//  Food Flicks
//
//  Created by Donis, Michael - Student on 3/6/24.
//

import SwiftUI

struct CardView: View {
    
    @Environment(FoodLibrary.self) private var library
    @State private var offset = CGSize.zero
    @State private var color: Color = .black
    let foodimages = Image(.bagels)
    
    
    var food: Food
    @Binding var cardOffset: CGSize
    @State var selectedFood: Food?
    @State var selection: [Food: Bool] = [:]
    
    var body: some View {
        
        ZStack{
            // MARK: - The actual card on main view
            Rectangle()
                .frame(width: 440, height: 540)
                .border(.white, width: 6.0)
                .cornerRadius(4)
                .foregroundStyle(color.opacity(0.9))
                .shadow(radius: 4)
            Text(food.foodDescription)
                .foregroundStyle(.black)
                .font(.largeTitle)
                .background(.green).blur(radius: 3.0)
                .frame(width: 340, height: 400)
            Text(food.foodDescription)
                .foregroundStyle(.black)
                .font(.largeTitle)
                .frame(width: 340, height: 400)
            let isSelected = selection[food] ?? false
            Image(food.imageName)
                .resizable()
                .opacity(0)
                .frame(maxWidth: 400, maxHeight: 400)
                .overlay(
                    Image(food.imageName)
                        .resizable()
                        .frame(maxWidth: 400, maxHeight: 400)
                        .opacity(isSelected ? 0.2 : 1)  // <-- here
                        .onTapGesture(count: 1) {
                            if isSelected {
                                selection[food] = false
                            } else {
                                selection[food] = true
                            }
                            
                        }
                        .onTapGesture(count: 2) {
                            print("Tapped To Favorite")
                            //                            Userlibrary.userfavoriteFoods.append(userfood)
                        }
                        .onLongPressGesture() {
                            selection = [:]
                        }
                       
                )
            VStack{
                Text(food.title)
                    .font(.largeTitle)
                    .foregroundStyle(.yellow)
                    .offset(CGSize(width: 0, height: -220.0))
                
            }
            
            
        }
        .offset(CGSize(width: 0, height: -60.0))
        .offset(x: offset .width, y: offset .height * 0.4)
        .rotationEffect(.degrees(Double(offset.width / 40)))
        .gesture(DragGesture()
            .onChanged{ gesture in offset = gesture.translation
                cardOffset = offset
                withAnimation {
                    changeColor(width: offset.width, height:  offset.height)
                }
            }.onEnded{_ in
                withAnimation{
                    swipeCard(width: offset.width, height: offset.height)
                    changeColor(width: offset.width, height: offset.height)
                    
                }
                
            }
                 
        )
        
    }
    // MARK: - Swipe
    
    func swipeCard (width: CGFloat, height: CGFloat) {
        var swipeHandled = false
        switch width {
        case -500...(-150):
            print("/(food) removed")
            library.deletedFoods.append(food)
            if let index = library.foods.firstIndex(where: { $0 == food}) {
                library.foods.remove(at: index)
            }
            offset = CGSize(width: -500, height: 0 )
            swipeHandled = true
        case 150...(500):
            print("/(food) added")
            library.favoriteFoods.append(food)
            if let index = library.foods.firstIndex(where: { $0 == food}) {
                library.foods.remove(at: index)
            }
            offset = CGSize(width: 500, height: 0 )
            swipeHandled = true
        default:
            offset = .zero
        }
        
        if !swipeHandled {
            switch height {
            case -500...(-150):
                print("/(food) show")
                
                if let index = library.foods.firstIndex(where: { $0 == food}) {
                    library.foods.remove(at: index)
                }
                offset = CGSize(width: -500, height: 0 )
            case 150...(500):
                print("/(food) do not show")
                if let index = library.foods.firstIndex(where: { $0 == food}) {
                    library.foods.remove(at: index)
                }
                offset = CGSize(width: 500, height: 0 )
            default:
                offset = .zero
            }
        }
    }
    // MARK: - Change Color
    func changeColor(width: CGFloat, height: CGFloat) {
        switch width {
        case -500...(-90): //130 original number instead of 90
            color = .red
        case 90...500:
            color = .green
        default:
            color = .black
            
            switch height {
            case -500...(-90): //130 original number instead of 90
                color = .green
            case 90...500:
                color = .red
            default:
                color = .black
            }
        }
    }
    
    
}



#Preview {
    CardView(food: Food.bagels, cardOffset: .constant(.zero))
 
    
    
}

