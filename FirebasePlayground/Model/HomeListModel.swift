//
//  HomeListModel.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/23.
//

import Foundation

struct HomeListModel {
    var fishPosts: [FishPost] = []
    var isShowAddListView = false

    var searchCriteria = SearchCriteria.date
    
    mutating func showAddListView() {
        isShowAddListView = true
    }
}

enum SearchCriteria: String, CaseIterable, Identifiable {
    case date = "日付"
    case fish = "魚種"
    case tackle = "仕掛け"
    
    var id: String { rawValue }
}
