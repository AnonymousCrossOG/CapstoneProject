//
//  FavoriteView.swift
//  Food Flicks
//
//  Created by Donis, Michael - Student on 3/28/24.
//

import SwiftUI
import AVFoundation
import ConfettiSwiftUI

enum Choice: CaseIterable { case none, favorite, like }

extension Choice {
    var imageName: String {
        switch self {
        case .none:
            return "clear.fill"
        case .favorite:
            return "star.fill"
        case .like:
            return "heart.fill"
        }
    }
}

struct LikesViews: View {
    @Environment(FoodLibrary.self) private var library
    @Environment(LikedFoodLibrary.self) private var Userlibrary
    @State var opacity = 1.0
    // var userfood: LikedFood
    @State var likedFoods: [LikedFood] = []
    @State var selectChoice: Choice = .none
    @State var userselectedFood: LikedFood?
    @State var userselection: [LikedFood: Bool] = [:]
    @State var player: AVAudioPlayer!
    @State private var counter: Int = 0
    var body: some View {
        ScrollView(showsIndicators: false){
            ForEach(likedFoods, id: \.self) { likedFood in
                // Cards in the liked/favorites view
                ZStack{
                    Rectangle()
                        .frame(width: 390, height: 480)
                        .border(.white, width: 6.0)
                        .cornerRadius(4)
                        .shadow(radius: 4)
                    Text(likedFood.LikedfoodDescription)
                        .foregroundStyle(.black)
                        .font(.largeTitle)
                        .background(.green).blur(radius: 3.0)
                        .frame(width: 340, height: 400)
                    Text( likedFood.LikedfoodDescription)
                        .foregroundStyle(.black)
                        .font(.largeTitle)
                        .frame(width: 340, height: 400)
                    let issSelected = userselection[likedFood] ?? false
                    Image(likedFood.LikedimageName)
                        .resizable()
                        .opacity(0)
                        .frame(maxWidth: 350, maxHeight: 400)
                        .overlay(
                            Image(likedFood.LikedimageName)
                                .resizable()
                                .frame(maxWidth: 350, maxHeight: 400)
                                .opacity(issSelected ? 0.2 : 1)
//                                .onTapGesture(count: 1) {
//                                    if issSelected {
//                                        userselection[userfood] = false
//                                    } else {
//                                        userselection[userfood] = true
//                                    }
//                                }// <-- here
                                .onTapGesture(count: 2) {
                                    print("/(food) removed")
                                    print("Play sound")
                                    playSound()
                                    counter += 1
                                   
                                    Userlibrary.userfavoriteFoods.append(likedFood)
                                    if let index = Userlibrary.userLikedFoods.firstIndex(where: { $0 == likedFood}) {
                                        Userlibrary.userfoods.remove(at: index)
//                                        library.foods.remove(at: index)
                                        
                                        if issSelected {
                                            userselection[likedFood] = false
                                        } else {
                                            userselection[likedFood] = true
                                        }
                                        
                                    }
                                }
                                .confettiCannon(counter: $counter)
                                .onLongPressGesture() {
//                                    userselection = [:]
                                    // print("userfood = \(userfood)")
                                    if issSelected {
                                    userselection[likedFood] = false
                                    } else {
                                    userselection[likedFood] = true
                                            }
//                                                                        } <-- here
                                    
                                }
                        )
                                    
                    
                    VStack{
                        Text(likedFood.Likedtitle)
                            .font(.largeTitle)
                            .foregroundStyle(.yellow)
                            .offset(CGSize(width: 0, height: -220.0))
                        
                    }
                }
            }
            
        }
        .onChange(of: selectChoice, { oldValue, newValue in
            selectFoods(choice: newValue)
        })
        .onAppear {
            selectFoods(choice: selectChoice)
        }
        .navigationTitle(findTitle())
        .navigationBarItems(trailing:
                                Menu(content: {
            ForEach(Choice.allCases, id: \.self) { choice in
                Button {
                    print("Filter \(choice)")
                    selectChoice = choice
                } label: {
                    Image(systemName: choice.imageName)
                        .foregroundStyle(.yellow)
                    
                }
                .font(.largeTitle)
                .foregroundStyle(.black)
                .frame(maxWidth: 110, maxHeight: 75)
                .background(.purple)
                .clipShape(Capsule())
                .padding()
           }
        }, label: {
            Text("Filter")
        }
                                     
                                    ))
        
        
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "fire", withExtension: "mp3")
        
        //Do nothing if this url is empty
        guard url != nil else {
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            
            player?.play()
        } catch {
            print("\(error)")
        }
        
    }
    func findTitle() -> String {
        switch selectChoice {
        case .none:
            return "All"
        case .favorite:
            return "Favorites"
        case .like:
            return "Likes"
        }
    }
    
    func selectFoods(choice: Choice) {
        switch choice {
        case .none:
            likedFoods = Userlibrary.userfoods
        case .favorite:
            likedFoods = Userlibrary.userfavoriteFoods
            
        case .like:
            likedFoods = Userlibrary.userLikedFoods
            
        }

    }
    
}

#Preview {
    LikesViews()
}
