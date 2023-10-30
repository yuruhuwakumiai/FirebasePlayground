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
    
    var isShowAddListView: Bool {
        get { model.isShowAddListView }
        set { model.isShowAddListView = newValue }
    }

    var searchCriteria: SearchCriteria {
        get { model.searchCriteria }
        set { model.searchCriteria = newValue }
    }

    var selectedSearchCriteria: SearchCriteria {
        get {
            model.selectedSearchCriteria }
        set {
            model.selectedSearchCriteria = newValue }
        }

    var selectedYear: Int {
        get {
            model.selectedYear
        }
        set {
            model.selectedYear = newValue
        }
    }

    var selectedMonth: Int {
        get {
            model.selectedMonth
        }
        set {
            model.selectedMonth = newValue
        }
    }

    var searchText: String {
        get {
            model.searchText
        }
        set {
            model.searchText = newValue
        }
    }

    func showAddListView() {
        model.showAddListView()
    }
}

