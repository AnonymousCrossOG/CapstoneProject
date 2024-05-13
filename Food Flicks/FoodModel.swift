//
//  FoodModel.swift
//  Food Flicks
//
//  Created by Donis, Michael - Student on 3/28/24.
//

import Foundation
import SwiftUI
// MARK: - Names for Food
enum Food: CaseIterable { case bagels, Pie, pizza, Brownie, muffin, cake, cracker, cheesecake } // , cinnamonBun }

extension Food {
    var title: String {
        switch self {
            //        case .cinnamonBun:
            //            return "cinnamon bun"
        default:
            return "\(self)"
        }
    }
    var imageName: String {
        switch self {
        default:
            return "\(self)"
        }
        
    }
    var foodDescription: String {
        switch self {
        case .bagels:
            return "Yeast & Warm Water: Allows the dough to rise. I recommend an instant or active dry yeast.Bread Flour: A high protein flour is necessary for making bagels. We want a dense and chewy texture, not soft and airy like cinnamon rolls. Bread flour is the only solution!Brown Sugar: Bakeries use barley malt syrup to sweeten the bagel dough—it can be a little difficult to find, but brown sugar is a fine substitute. Read more in my recipe notes below.Vanilla Extract: For extra delicious flavor to these sweet bagels.Raisins: Use around 3/4 – 1 cup. Dried cranberries are a delicious substitute!Sugar & Cinnamon: Knead the dough directly on the mixture. We’ll use our hands to work it into the dough! This method, rather than just mixing it all in, helps create little swirls and pockets of cinnamon sugar. The dough gets a little moist from the sugar, but that’s completely fine."
        case .Pie:
            return "This is how you make a Pie"
        case .pizza:
            return "This is how you make a fire pizza"
        case .Brownie:
            return "This is how you make the worlds best brownies!"
        case .muffin:
            return "This is how you make the best"
        case .cake:
            return "This is the best recipe for a cake"
        case .cracker:
            return "This is how you make the best crackers"
        case .cheesecake:
            return "This is how you make the best cheesecake(also needs fruit or else)"
        default:
            return "\(self)"
        }
    }
}


@Observable class FoodLibrary {
    var foods: [Food] = Food.allCases
    var favoriteFoods: [Food] = []
    var deletedFoods: [Food] = []
}


@Observable class LikedFoodLibrary {
    var userfoods: [LikedFood] = LikedFood.allCases
    var userfavoriteFoods: [LikedFood] = []
    var userLikedFoods: [LikedFood] = []
    var userdeletedFoods: [LikedFood] = []
}

// MARK: - Names for Food
enum LikedFood: CaseIterable { case bagels, Pie, pizza, Brownie, muffin, cake, cracker, cheesecake } // , cinnamonBun }

extension LikedFood {
    var Likedtitle: String {
        switch self {
            //        case .cinnamonBun:
            //            return "cinnamon bun"
        default:
            return "\(self)"
        }
    }
    var LikedimageName: String {
        switch self {
        default:
            return "\(self)"
        }
        
    }
    var LikedfoodDescription: String {
        switch self {
        case .bagels:
            return "Yeast & Warm Water: Allows the dough to rise. I recommend an instant or active dry yeast.Bread Flour: A high protein flour is necessary for making bagels. We want a dense and chewy texture, not soft and airy like cinnamon rolls. Bread flour is the only solution!Brown Sugar: Bakeries use barley malt syrup to sweeten the bagel dough—it can be a little difficult to find, but brown sugar is a fine substitute. Read more in my recipe notes below.Vanilla Extract: For extra delicious flavor to these sweet bagels.Raisins: Use around 3/4 – 1 cup. Dried cranberries are a delicious substitute!Sugar & Cinnamon: Knead the dough directly on the mixture. We’ll use our hands to work it into the dough! This method, rather than just mixing it all in, helps create little swirls and pockets of cinnamon sugar. The dough gets a little moist from the sugar, but that’s completely fine."
        case .Pie:
            return "This is how you make a Pie"
        case .pizza:
            return "This is how you make a fire pizza"
        case .Brownie:
            return "This is how you make the worlds best brownies!"
        case .muffin:
            return "This is how you make the best"
        case .cake:
            return "This is the best recipe for a cake"
        case .cracker:
            return "This is how you make the best crackers"
        case .cheesecake:
            return "This is how you make the best cheesecake(also needs fruit or else)"
        default:
            return "\(self)"
        }
    }
}
