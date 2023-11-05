//
//  HomeListView.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/17.
//  レイアウトを作る役割

import SwiftUI
import UIKit

struct HomeListView: View {
    @StateObject var viewModel = HomeListViewModel()
    @EnvironmentObject var navigationManager: NavigationManager

    var body: some View {
        VStack(spacing: 20) {
            homeSearchView()
            diaryListView()
            toAddListViewButtonView()
        }
        .navigationSetting("記録")
        .backgroundView(.background_color)
        .modifier(NavigationDestinationModifier())
        .sheet(isPresented: $viewModel.isShowAddListView) {
            AddListView()
        }
    }
    
    @ViewBuilder
    private func toAddListViewButtonView() -> some View {
        Button(action: viewModel.showAddListView) {
            Image(systemName: "plus.circle.fill")
                .imageScale(.large)
        }
    }

    @ViewBuilder
    private func homeSearchView() -> some View {
        Picker("検索項目", selection: $viewModel.selectedPicker) {
            ForEach(SelectedPicker.allCases, id: \.self) { criteria in
                Text(criteria.rawValue).tag(criteria)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal)
        .padding(.top, 30)

        if viewModel.selectedPicker == .date {
            CustomMonthYearPicker(selectedYear: $viewModel.selectedYear, selectedMonth: $viewModel.selectedMonth)
        } else {
            TextField("検索...", text: $viewModel.searchText)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
        }
    }

    @ViewBuilder
    private func diaryListView() -> some View {
        List {
            ForEach(Array(viewModel.filteredLogs.keys), id: \.self) { key in
                Section(header: Text(readableYearAndMonth(from: key))) {
                    ForEach(viewModel.filteredLogs[key]!, id: \.id) { log in
                        Button {
// TODO: ボタンアクション
// logStateViewModel.prepareForEditing(log: log)

                        } label: {
                            HStack(spacing: 50) {
                                logImage(for: log)
                                logText(for: log)
                            }
                        }
                        .foregroundColor(Color.white)
                        .padding(5)
                        .onAppear {

                        }
                    }
                }
            }
        }
        .id(UUID())
    }

    @ViewBuilder
    private func logText(for log: FishingLog) -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text(viewModel.dateString(from: log.date))
                    .foregroundColor(Color.sub_color)
                    .bold()
                Text(log.title)
            }
            Text("\(viewModel.timeRangeString(from: log.startDate, to: log.endDate))")  // 開始時間と終了時間
            if let location = log.location, !location.isEmpty {
                Text(location)  // 場所
            }
        }
    }


    @ViewBuilder
    private func logImage(for log: FishingLog) -> some View {
                if let img = viewModel.images[log.id] {
                    Image(uiImage: img)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
    }


    func readableYearAndMonth(from key: String) -> String {
        let components = key.split(separator: "-")
        if components.count == 2, let year = components.first, let month = components.last {
            return "\(year)年 \(month)月"
        } else {
            return "Unknown"
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeListView()
    }
}
