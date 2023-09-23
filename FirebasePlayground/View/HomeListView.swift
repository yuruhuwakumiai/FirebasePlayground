//
//  HomeListView.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/17.
//

import SwiftUI
import UIKit

//struct HomeListView: View {
//
//    @ObservedObject var uiViewModel: FishingLogUIViewModel
////    @ObservedObject var fishingLogDataViewModel: FishingLogDataViewModel
//    @ObservedObject var logStateViewModel: FishingLogStateViewModel
//    @ObservedObject var logFilterViewModel: FishingLogFilterViewModel
//    @ObservedObject var logUtilityViewModel: FishingLogUtilityViewModel
//
//    @State private var selectedDate: Date = Date()
////    @EnvironmentObject var navigationManager: NavigationManager
//
//    let dateTimeFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        formatter.timeStyle = .short
//        return formatter
//    }()
//
////    var body: some View {
////        NavigationStack(path: $navigationManager.path) {
////            ZStack {
////                Color.background_color
////                    .ignoresSafeArea()
////                VStack(spacing: 20) {
////                    homeSearchView()
////                    diaryListView()
////                    Button {
////                        logStateViewModel.prepareForNewLog()
//////                        navigationManager.setViewModels(newViewModels)
////                        navigationManager.path.append(.AddListView)
////                    } label: {
////                        Image(systemName: "plus.circle.fill") // 「追加」のアイコン
////                            .imageScale(.large) // アイコンのサイズを調整
////                    }
////                }
////
//////                .customNavigationBarItems(viewModel: viewModel)
////                .navigationBarTitle("記録", displayMode: .inline)
////
////            }
////            .onAppear {
////                fishingLogDataViewModel.loadLogs()
////            }
////            .modifier(NavigationDestinationModifier())
////        }
////    }
//
//    @ViewBuilder
//    private func homeSearchView() -> some View {
//        Picker("検索項目", selection: $uiViewModel.selectedSearchCriteria) {
//            ForEach(SearchCriteria.allCases, id: \.self) { criteria in
//                Text(criteria.rawValue).tag(criteria)
//            }
//        }
//        .pickerStyle(SegmentedPickerStyle())
//        .padding(.horizontal)
//        .padding(.top, 30)
//
//        if uiViewModel.selectedSearchCriteria == .date {
//            CustomMonthYearPicker(selectedYear: $uiViewModel.selectedYear, selectedMonth: $uiViewModel.selectedMonth)
//        } else {
//            TextField("検索...", text: $uiViewModel.searchText)
//                .padding(10)
//                .background(Color(.systemGray6))
//                .cornerRadius(8)
//                .padding(.horizontal)
//        }
//    }
//
//
//    @ViewBuilder
//    private func diaryListView() -> some View {
//        List {
//            ForEach(Array(logFilterViewModel.filteredLogs.keys), id: \.self) { key in
//                Section(header: Text(readableYearAndMonth(from: key))) {
//                    ForEach(logFilterViewModel.filteredLogs[key]!, id: \.id) { log in
//                        Button {
//                            logStateViewModel.prepareForEditing(log: log)
////                            navigationManager.setCurrentViewModel(viewModel)
////                            navigationManager.path.append(.AddListView)
//                        } label: {
//                            HStack(spacing: 50) {
//                                logImage(for: log)
//                                logText(for: log)
//                            }
//                        }
//                        .foregroundColor(Color.white)
//                        .padding(5)
//                        .onAppear {
////                            viewModel.fetchImage(for: log)
//                        }
//                    }
//                }
//            }
//        }
//        .id(UUID())
//    }
//
//    @ViewBuilder
//    private func logText(for log: FishingLog) -> some View {
//        VStack(alignment: .leading) {
//            HStack {
//                Text(logUtilityViewModel.dateString(from: log.date))
//                    .foregroundColor(Color.sub_color)
//                    .bold()
//                Text(log.title)
//            }
//            Text("\(logUtilityViewModel.timeRangeString(from: log.startDate, to: log.endDate))")  // 開始時間と終了時間
//            if let location = log.location, !location.isEmpty {
//                Text(location)  // 場所
//            }
//        }
//    }
//
//
//    @ViewBuilder
//    private func logImage(for log: FishingLog) -> some View { // LogTypeは適切な型に置き換えてください。
//        if let img = uiViewModel.images[log.id] {
//            Image(uiImage: img)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 50, height: 50)
//        } else {
//            Image(systemName: "photo")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 50, height: 50)
//        }
//    }
//
//
//    func readableYearAndMonth(from key: String) -> String {
//        let components = key.split(separator: "-")
//        if components.count == 2, let year = components.first, let month = components.last {
//            return "\(year)年 \(month)月"
//        } else {
//            return "Unknown"
//        }
//    }
//}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeListView()
//    }
//}
