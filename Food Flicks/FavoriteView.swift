//
//  FavoriteView.swift
//  Food Flicks
//
//  Created by Donis, Michael - Student on 3/28/24.
//

import SwiftUI

struct FavoriteView: View {
    @Environment(LikedFoodLibrary.self) private var Userlibrary
    @State var opacity = 1.0
    var userfood: LikedFood
    @State var userselectedFood: LikedFood?
    @State var userselection: [LikedFood: Bool] = [:]
    
    @Environment(FoodLibrary.self) private var library
    var food: Food
    @State var selectedFood: Food?
    @State var selection: [Food: Bool] = [:]
    var body: some View {
        ScrollView(showsIndicators: false){
            ForEach(library.favoriteFoods, id: \.self) { food in
                // Cards in the liked/favorites view
                ZStack{
                    Rectangle()
                        .frame(width: 390, height: 480)
                        .border(.white, width: 6.0)
                        .cornerRadius(4)
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
                        .frame(maxWidth: 350, maxHeight: 400)
                        .overlay(
                            Image(food.imageName)
                                .resizable()
                                .frame(maxWidth: 350, maxHeight: 400)
                                .opacity(isSelected ? 0.2 : 1)  // <-- here
                                .onTapGesture(count: 1) {
                                    
                                    if isSelected {
                                       selection[food] = false
                                        
                                    } else {
                                        selection[food] = true
                                    }
                                  
                                }
                                .onTapGesture(count: 2) {
                                    
                                    if isSelected {
                                        print("Added to favs")
                                        library.foods.remove(at: 1)
                                        Userlibrary.userfavoriteFoods.append(userfood).self
                                        library.favoriteFoods.remove(at: 1)
                                    } else {
                                        
                                    }
                                    
                                    if isSelected {
                                        userselection[userfood] = false
                                        print("Added to favs")
                                        
                                    } else {
                                        userselection[userfood] = true
                                    }
                                    
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
            }
            
        }
        
        .navigationTitle("Likes")
        .navigationBarItems(trailing:
                                Menu(content: {
            Button {
                print("Filter None")
            } label: {
                Image(systemName: "clear.fill")
                    .foregroundStyle(.yellow)
                
            }
            .font(.largeTitle)
            .foregroundStyle(.black)
            .frame(maxWidth: 110, maxHeight: 75)
            .background(.purple)
            .clipShape(Capsule())
            .padding()
            .offset(CGSize(width: -160, height: 110))
            
            Button {
                print("Filter For Likes")
            } label: {
                Image(systemName: "heart.fill")
                    .foregroundStyle(.yellow)
                
            }
            .font(.largeTitle)
            .foregroundStyle(.black)
            .frame(maxWidth: 110, maxHeight: 75)
            .background(.purple)
            .clipShape(Capsule())
            .padding()
            .offset(CGSize(width: -160, height: 110))
            
            Button {
                print("Filter for Favorites")
            } label: {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                
            }
            .font(.largeTitle)
            .foregroundStyle(.black)
            .frame(maxWidth: 110, maxHeight: 75)
            .background(.purple)
            .clipShape(Capsule())
            .padding()
            .offset(CGSize(width: -160, height: 110))
        }, label: {
            Text("Filter")
        }
                                     
                                    ))
        
        
    }
    
}

#Preview {
    FavoriteView(userfood: .Brownie, food: .Brownie )
}
