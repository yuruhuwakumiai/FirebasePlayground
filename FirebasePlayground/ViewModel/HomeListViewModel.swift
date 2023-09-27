//
//  HomeListViewModel.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/23.
//

import SwiftUI

class HomeListViewModel: ObservableObject {
    @Published var model = HomeListModel()

    var fishPosts: [FishPost] {
        get { model.fishPosts }
        set { model.fishPosts = newValue }
    }
}
