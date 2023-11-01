//
//  HomeListModel.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/23.
//  処理する役割

import Foundation

struct HomeListModel {
    let firebaseRepository = FirebaseRepository()
    var fishPosts: [FishPost] = []
    var isShowAddListView = false

    var selectedPicker = SelectedPicker.date

    var selectedYear = Calendar.current.component(.year, from: Date())

    var selectedMonth = Calendar.current.component(.month, from: Date())

    var searchText = ""
    
    var dataList = firebaseRepository.getData()

    //    var filteredLogs: [String: [FishingLog]] {
    //        var currentFilteredLogs = logsByYearAndMonth
    //
    //        switch uiViewModel.selectedSearchCriteria {
    //        case .fish:
    //            currentFilteredLogs = currentFilteredLogs.mapValues { logs in
    //                logs.filter { log in
    //                    return log.fishNote?.contains(uiViewModel.searchText) ?? false
    //                }
    //            }.filter { $0.value.count > 0 }
    //        case .tackle:
    //            currentFilteredLogs = currentFilteredLogs.mapValues { logs in
    //                logs.filter { log in
    //                    return log.tackleNote?.contains(uiViewModel.searchText) ?? false
    //                }
    //            }.filter { $0.value.count > 0 }
    //        case .date:
    //            let key = "\(uiViewModel.selectedYear)-\(uiViewModel.selectedMonth)"
    //            currentFilteredLogs = currentFilteredLogs.filter { $0.key == key }
    //        }
    //
    //        return currentFilteredLogs
    //    }


    mutating func showAddListView() {
        isShowAddListView = true
    }
}

enum SelectedPicker: String, CaseIterable, Identifiable {
    case date = "日付"
    case fish = "魚種"
    case tackle = "仕掛け"
    
    var id: String { self.rawValue }
}
