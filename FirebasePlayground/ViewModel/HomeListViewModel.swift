//
//  HomeListViewModel.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/23.
//

import SwiftUI

class HomeListViewModel: ObservableObject {
    @Published var model = HomeListModel()

    var fishDatabase: FishData {
        get { model.fishData }
        set { model.fishData = newValue }
    }

    func prepareForNewLog() {
        model.prepareForNewLog()
    }

//    func prepareForEditing(log: FishingLog) {
//        model.prepareForEditing(log: FishingLog)
//    }
}
