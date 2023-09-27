//
//  AddListViewModel.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/23.
//

import SwiftUI

class AddListViewModel: ObservableObject {
    @Published var model = AddListModel()

    var fihsData: FishData {
        get { model.fishData }
        set { model.fishData = newValue }
    }
}
