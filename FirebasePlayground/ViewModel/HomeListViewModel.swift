//
//  HomeListViewModel.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/23.
//  データをViewに渡す役割

import SwiftUI

class HomeListViewModel: ObservableObject {
    @Published var model = HomeListModel()

    var logs: [FishingLog] {
        model.logs
    }

    var fishPosts: [FishPost] {
        get { model.fishPosts }
        set { model.fishPosts = newValue }
    }

    var isShowAddListView: Bool {
        get { model.isShowAddListView }
        set { model.isShowAddListView = newValue }
    }

    var selectedPicker: SelectedPicker {
        get { model.selectedPicker }
        set { model.selectedPicker = newValue }
    }

    var filteredLogs: [String: [FishingLog]] {
        model.filterLogs()
    }
    
//    var dataList: [String] { model.dataList }

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

    func timeRangeString(from start: Date, to end: Date) -> String {
        return model.timeRangeString(from: start, to: end)
    }

    func dateString(from date: Date) -> String {
        return model.dateString(from: date)
    }

    func showAddListView() {
        model.showAddListView()
    }
}

