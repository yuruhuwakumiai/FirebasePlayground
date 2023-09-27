//
//  AddListView.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/17.
//

import SwiftUI

struct AddListView: View {
    //
    ////    @EnvironmentObject var navigationManager: NavigationManager
    //    @Environment(\.presentationMode) var presentationMode
    //    @ObservedObject var uiViewModel: FishingLogUIViewModel
    @ObservedObject var viewModel = AddListViewModel()
    //
    //
    //    @State private var isShowingAlert = false
    //
    //    let fishLengths = Array(0...200)
    //    let fishWeights = Array(0...100)
    //
    var body: some View {
        Text("追加画面")
    }
}
//        VStack {
//            Form {
//                titleDateSection()
//                placeSection()
//                addPictureSection()
//                whetherSection()
//                addFishButtonSection()
//                addedFishListSection()
//                addTackleButtonSection()
//                tackleNoteSection()
//                saveButtonOrDeleteButtonView()
//
//            }
//            .closeKeyboardOnTap()
//        }
//        .alert(isPresented: $isShowingAlert) {
//            switch uiViewModel.currentAlertType {
//            case .deleteConfirmation:
//                return Alert(
//                    title: Text("警告"),
//                    message: Text("データが削除されますが、よろしいですか？"),
//                    primaryButton: .destructive(Text("削除"), action: {
//                        if let logID = uiViewModel.editingLog?.id {
//                            DispatchQueue.main.async {
//                                navigationManager.path.removeAll()
//                                uiViewModel.editingLog = nil
//                            }
//                        }
//                    }),
//                    secondaryButton: .cancel(Text("キャンセル"))
//                )
//            case .unsavedChanges:
//                return Alert(
//                    title: Text("警告"),
//                    message: Text("内容は保存されませんがよろしいでしょうか？"),
//                    primaryButton: .destructive(Text("はい")) {
//                        presentationMode.wrappedValue.dismiss()
//                    },
//                    secondaryButton: .cancel(Text("キャンセル"))
//                )
//            case .saveFirst:
//                return Alert(title: Text("警告"), message: Text("先に釣行記録を保存してください。"), dismissButton: .default(Text("了解")))
//            default:
//                return Alert(title: Text("エラー"), message: Text("不明なエラーが発生しました。"), dismissButton: .default(Text("了解")))
//            }
//        }
//        .onAppear {
//            print("Current Log ID before navigating to FishInputView: \(uiViewModel.currentLogID ?? "nil")")
//            fishingLogDataViewModel.loadLogs()
//            if let currentLogID = uiViewModel.currentLogID {
//                fishingLogDataViewModel.loadFishes(for: currentLogID)
//            }
//        }
//
//        .navigationBarBackButtonHidden(true)
//
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button(action: {
//                    uiViewModel.currentAlertType = .unsavedChanges
//                    isShowingAlert = true
//                }) {
//                    Image(systemName: "arrow.left")
//                }
//            }
//        }
//        .navigationBarTitle(uiViewModel.editingLog != nil ? "記録を確認" : "記録をつける" , displayMode: .inline)
//
//        .actionSheet(isPresented: $uiViewModel.showingActionSheet) {
//            ActionSheet(title: Text("写真の選択"), buttons: [
//                .default(Text("ライブラリから選択")) { uiViewModel.selectedAction = .library },
//                .default(Text("写真を撮影する")) { uiViewModel.selectedAction = .camera },
//                .destructive(Text("削除する")) { uiViewModel.selectedAction = .delete },
//                .cancel()
//            ])
//        }
//
//        .onChange(of: uiViewModel.selectedAction) { action in
//
//            switch action {
//            case .library:
//                uiViewModel.isUsingCamera = false
//                uiViewModel.showingImagePicker = true
//            case .camera:
//                uiViewModel.isUsingCamera = true
//                uiViewModel.showingImagePicker = true
//            case .delete:
//                uiViewModel.image = nil
//            default:
//                break
//            }
//        }
//        .sheet(isPresented: $uiViewModel.showingImagePicker) {
//        }
//    }
//
//    // スワイプして消す時使う
//    func deleteFish(at offsets: IndexSet) {
//        uiViewModel.fishes.remove(atOffsets: offsets)
//    }
//
//    @ViewBuilder
//    private func titleDateSection() -> some View {
//        Section(header: Text("タイトル・日付")) {
//            TextField("タイトルを入力", text: $uiViewModel.title)
//            DatePicker("日付", selection: $uiViewModel.date, displayedComponents: [.date])
//        }
//    }
//
//    @ViewBuilder
//    private func placeSection() -> some View {
//        Section(header: Text("場所")) {
//            TextField("釣り場所を入力", text: $uiViewModel.location)
//            DatePicker("開始時間", selection: $uiViewModel.startDate, displayedComponents: [.hourAndMinute])
//            DatePicker("終了時間", selection: $uiViewModel.endDate, displayedComponents: [.hourAndMinute])
//        }
//    }
//
//    @ViewBuilder
//    private func whetherSection() -> some View {
//        Section(header: Text("天候")) {
//            Picker("天候", selection: $uiViewModel.selectedWeather) {
//                ForEach(WeatherTypes.allCases, id: \.self) { weather in
//                    Text(weather.rawValue).tag(weather)
//                }
//            }.pickerStyle(SegmentedPickerStyle())
//
//            Picker("潮回り", selection: $uiViewModel.selectedTide) {
//                ForEach(TideTypes.allCases, id: \.self) { tide in
//                    Text(tide.rawValue).tag(tide)
//                }
//            }.pickerStyle(SegmentedPickerStyle())
//        }
//    }
//
//    @ViewBuilder
//    private func homeCellView() -> some View {
//
//        List(uiViewModel.fishes) { fish in
//            VStack(alignment: .leading) {
//                Text(fish.type)
//                Text("\(fish.length) cm")
//                // 他の情報もこちらに追加してください
//                if let image = fish.image {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(height: 100)
//                }
//            }
//        }
//    }
//
//    @ViewBuilder
//    private func addFishButtonSection() -> some View {
//        Section {
//            HStack {
//                Spacer()
//                Button("魚を追加") {
//                    if uiViewModel.currentLogID != nil {
//                        print("Current Log ID before adding fish: \(uiViewModel.currentLogID ?? "nil")")
////                        navigationManager.setCurrentViewModel(viewModel)
////                        navigationManager.path.append(.FishInputView)
//                    } else {
//                        // ここでアラートを表示して、先に釣行記録を保存するように促す
//                        uiViewModel.showingSaveFirstAlert = true
//                    }
//                }
//                Spacer()
//            }
//        }
//    }
//
//    @ViewBuilder
//    private func fishNoteSection() -> some View {
//        Section(header: Text("魚のメモ")) {
//            TextEditor(text: $uiViewModel.fishNote)
//                .frame(height: 100)
//        }
//    }
//
//    @ViewBuilder
//    private func addedFishListSection() -> some View {
//        Section(header: Text("追加された魚")) {
//            ForEach(uiViewModel.fishes.indices, id: \.self) { index in
//                let fish = uiViewModel.fishes[index]
//                HStack {
//                    if let image = fish.image {
//                        Image(uiImage: image)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 50, height: 50)
//                    } else {
//                        Image(systemName: "photo")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 50, height: 50)
//                    }
//                    Text("\(fish.type): \(fish.length)cm, \(fish.weightKilo)kg \(fish.weightGram)g")
//                }
//            }
//            .onDelete(perform: deleteFish)
//        }
//    }
//
//    @ViewBuilder
//    private func addTackleButtonSection() -> some View {
//        Section {
//            HStack {
//                Spacer()
//                Button("仕掛けを追加") {
////                    navigationManager.setCurrentViewModel(viewModel)
////                    navigationManager.path.append(.TackleInputView)
//                }
//                Spacer()
//            }
//        }
//    }
//
//    @ViewBuilder
//    private func tackleNoteSection() -> some View {
//        Section(header: Text("仕掛け・釣れ方")) {
//            TextEditor(text: $uiViewModel.tackleNote)
//                .frame(height: 100)
//        }
//    }
//
//    @ViewBuilder
//    private func moneySection() -> some View {
//        Section(header: Text("費用")) {
//            HStack {
//                TextField("合計費用（¥）", text: $uiViewModel.cost)
//                    .keyboardType(.numberPad)
//                Text("円")
//            }
//        }
//    }
//
//    @ViewBuilder
//    private func addPictureSection() -> some View {
//        Section(header: Text("釣り場の写真")) {
//            if let img = uiViewModel.image {
//                Image(uiImage: img)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(height: 200)
//            }
//            HStack {
//                Spacer()
//                Button("写真を選択") {
//                    uiViewModel.showingActionSheet = true
//                }
//                Spacer()
//            }
//        }
//    }
//
//    @ViewBuilder
//    private func saveButtonOrDeleteButtonView() -> some View {
//        Section {
//            HStack {
//                Spacer()
//                // MARK: ※更新ボタン
//                Button(uiViewModel.editingLog != nil ? "更新する" : "追加する") {
//                    let costDouble = Double(uiViewModel.cost) ?? 0.0
//                    var newLog = FishingLog()
//                    if let editingLog = uiViewModel.editingLog {
//                        newLog.id = editingLog.id
//                    }
//                    newLog.title = uiViewModel.title
//                    newLog.date = uiViewModel.date
//                    newLog.startDate = uiViewModel.startDate
//                    newLog.endDate = uiViewModel.endDate
//                    newLog.fishType = uiViewModel.selectedFishType
//                    newLog.length = Double(uiViewModel.selectedFishLength)
//                    newLog.location = uiViewModel.location
//                    newLog.fishNote = uiViewModel.fishNote
//                    newLog.weather = uiViewModel.selectedWeather
//                    newLog.tide = uiViewModel.selectedTide
//                    newLog.tackleNote = uiViewModel.tackleNote
//                    newLog.cost = costDouble
//
//                    // FireStorageに保存する
//                    fishingLogDataViewModel.addLog(newLog) { logID in
//                    }
//                    // FireStoreに保存する
//                    if let editingLog = uiViewModel.editingLog {
//                        print("Editing log ID: \(editingLog.id)")
//                        // Update existing log in Firebase
//                        fishingLogDataViewModel.updateLog(editingLog, with: newLog)
//                    } else {
//                        fishingLogDataViewModel.addLog(newLog) { logID in
//                            if let id = logID {
//                                self.uiViewModel.currentLogID = id
//                            }
//                        }
//                    }
//                    presentationMode.wrappedValue.dismiss()
//                }
//                .buttonStyle(CustomButtonStyle())
//
//                // 編集中の場合のみ、削除ボタンを表示
//                if uiViewModel.editingLog != nil {
//                    Spacer()
//                    Button("削除する") {
//                        uiViewModel.currentAlertType = .deleteConfirmation
//                        uiViewModel.isShowingAlert = true
//                    }
//                    .buttonStyle(CustomDeleteButtonStyle())
//                }
//                Spacer()
//            }
//        }
//    }
//}


