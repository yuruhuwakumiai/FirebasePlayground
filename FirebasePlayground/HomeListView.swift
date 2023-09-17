//
//  HomeListView.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/17.
//

import SwiftUI

struct HomeListView: View {

    @ObservedObject var viewModel: FishingLogViewModel
    @State private var selectedDate: Date = Date()
    @EnvironmentObject var navigationManager: NavigationManager

    let dateTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }

    @ViewBuilder
    private func diaryListView() -> some View {
        List {
            ForEach(Array(viewModel.filteredLogs.keys), id: \.self) { key in
                Section(header: Text(readableYearAndMonth(from: key))) {
                    ForEach(viewModel.filteredLogs[key]!, id: \.id) { log in
                        Button {
                            viewModel.prepareForEditing(log: log)
                            navigationManager.setCurrentViewModel(viewModel)
                            navigationManager.path.append(.AddFishingLogScreen)
                        } label: {
                            HStack(spacing: 50) {
                                // 画像表示部分
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
                        }
                        .foregroundColor(Color.white)
                        .padding(5)
                        .onAppear {
                            viewModel.fetchImage(for: log)
                        }  // ここに追加
                    }
                }
            }
        }
        .id(UUID())
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
