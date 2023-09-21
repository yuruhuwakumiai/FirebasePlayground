//
//  AddListView.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/17.
//

import SwiftUI
import Foundation

struct AddListView: View {

    @EnvironmentObject var navigationManager: NavigationManager
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: FishingLogViewModel

    @State private var isShowingAlert = false

    let fishLengths = Array(0...200)
    let fishWeights = Array(0...100)

    var body: some View {

        VStack {
            Form {
                titleDateSection()
                placeSection()
                addPictureSection()
                whetherSection()
                addFishButtonSection()
                addedFishListSection()
                addTackleButtonSection()
                tackleNoteSection()
                saveButtonOrDeleteButtonView()

            }
            .closeKeyboardOnTap()
        }
        .alert(isPresented: $isShowingAlert) {
            switch viewModel.currentAlertType {
            case .deleteConfirmation:
                return Alert(
                    title: Text("警告"),
                    message: Text("データが削除されますが、よろしいですか？"),
                    primaryButton: .destructive(Text("削除"), action: {
                        if let logID = viewModel.editingLog?.id {
                            DispatchQueue.main.async {
                                navigationManager.path.removeAll()
                                viewModel.editingLog = nil
                            }
                        }
                    }),
                    secondaryButton: .cancel(Text("キャンセル"))
                )
            case .unsavedChanges:
                return Alert(
                    title: Text("警告"),
                    message: Text("内容は保存されませんがよろしいでしょうか？"),
                    primaryButton: .destructive(Text("はい")) {
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel(Text("キャンセル"))
                )
            case .saveFirst:
                return Alert(title: Text("警告"), message: Text("先に釣行記録を保存してください。"), dismissButton: .default(Text("了解")))
            default:
                return Alert(title: Text("エラー"), message: Text("不明なエラーが発生しました。"), dismissButton: .default(Text("了解")))
            }
        }
        .onAppear {
            print("Current Log ID before navigating to FishInputView: \(viewModel.currentLogID ?? "nil")")
            viewModel.loadLogs()
            if let currentLogID = viewModel.currentLogID {
                viewModel.loadFishes(for: currentLogID)
            }
        }

        .navigationBarBackButtonHidden(true)

        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    viewModel.currentAlertType = .unsavedChanges
                    isShowingAlert = true
                }) {
                    Image(systemName: "arrow.left")
                }
            }
        }
        .navigationBarTitle(viewModel.editingLog != nil ? "記録を確認" : "記録をつける" , displayMode: .inline)

        .actionSheet(isPresented: $viewModel.showingActionSheet) {
            ActionSheet(title: Text("写真の選択"), buttons: [
                .default(Text("ライブラリから選択")) { viewModel.selectedAction = .library },
                .default(Text("写真を撮影する")) { viewModel.selectedAction = .camera },
                .destructive(Text("削除する")) { viewModel.selectedAction = .delete },
                .cancel()
            ])
        }

        .onChange(of: viewModel.selectedAction) { action in

            switch action {
            case .library:
                viewModel.isUsingCamera = false
                viewModel.showingImagePicker = true
            case .camera:
                viewModel.isUsingCamera = true
                viewModel.showingImagePicker = true
            case .delete:
                viewModel.image = nil
            default:
                break
            }
        }
        .sheet(isPresented: $viewModel.showingImagePicker) {
        }
    }

    // スワイプして消す時使う
    func deleteFish(at offsets: IndexSet) {
        viewModel.fishes.remove(atOffsets: offsets)
    }

    @ViewBuilder
    private func titleDateSection() -> some View {
        Section(header: Text("タイトル・日付")) {
            TextField("タイトルを入力", text: $viewModel.title)
            DatePicker("日付", selection: $viewModel.date, displayedComponents: [.date])
        }
    }

    @ViewBuilder
    private func placeSection() -> some View {
        Section(header: Text("場所")) {
            TextField("釣り場所を入力", text: $viewModel.location)
            DatePicker("開始時間", selection: $viewModel.startDate, displayedComponents: [.hourAndMinute])
            DatePicker("終了時間", selection: $viewModel.endDate, displayedComponents: [.hourAndMinute])
        }
    }

    @ViewBuilder
    private func whetherSection() -> some View {
        Section(header: Text("天候")) {
            Picker("天候", selection: $viewModel.selectedWeather) {
                ForEach(WeatherTypes.allCases, id: \.self) { weather in
                    Text(weather.rawValue).tag(weather)
                }
            }.pickerStyle(SegmentedPickerStyle())

            Picker("潮回り", selection: $viewModel.selectedTide) {
                ForEach(TideTypes.allCases, id: \.self) { tide in
                    Text(tide.rawValue).tag(tide)
                }
            }.pickerStyle(SegmentedPickerStyle())
        }
    }

    @ViewBuilder
    private func homeCellView() -> some View {

        List(viewModel.fishes) { fish in
            VStack(alignment: .leading) {
                Text(fish.type)
                Text("\(fish.length) cm")
                // 他の情報もこちらに追加してください
                if let image = fish.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                }
            }
        }
    }

    @ViewBuilder
    private func addFishButtonSection() -> some View {
        Section {
            HStack {
                Spacer()
                Button("魚を追加") {
                    if viewModel.currentLogID != nil {
                        print("Current Log ID before adding fish: \(viewModel.currentLogID ?? "nil")")
//                        navigationManager.setCurrentViewModel(viewModel)
//                        navigationManager.path.append(.FishInputView)
                    } else {
                        // ここでアラートを表示して、先に釣行記録を保存するように促す
                        viewModel.showingSaveFirstAlert = true
                    }
                }
                Spacer()
            }
        }
    }

    @ViewBuilder
    private func fishNoteSection() -> some View {
        Section(header: Text("魚のメモ")) {
            TextEditor(text: $viewModel.fishNote)
                .frame(height: 100)
        }
    }

    @ViewBuilder
    private func addedFishListSection() -> some View {
        Section(header: Text("追加された魚")) {
            ForEach(viewModel.fishes.indices, id: \.self) { index in
                let fish = viewModel.fishes[index]
                HStack {
                    if let image = fish.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                    }
                    Text("\(fish.type): \(fish.length)cm, \(fish.weightKilo)kg \(fish.weightGram)g")
                }
            }
            .onDelete(perform: deleteFish)
        }
    }

    @ViewBuilder
    private func addTackleButtonSection() -> some View {
        Section {
            HStack {
                Spacer()
                Button("仕掛けを追加") {
//                    navigationManager.setCurrentViewModel(viewModel)
//                    navigationManager.path.append(.TackleInputView)
                }
                Spacer()
            }
        }
    }

    @ViewBuilder
    private func tackleNoteSection() -> some View {
        Section(header: Text("仕掛け・釣れ方")) {
            TextEditor(text: $viewModel.tackleNote)
                .frame(height: 100)
        }
    }

    @ViewBuilder
    private func moneySection() -> some View {
        Section(header: Text("費用")) {
            HStack {
                TextField("合計費用（¥）", text: $viewModel.cost)
                    .keyboardType(.numberPad)
                Text("円")
            }
        }
    }

    @ViewBuilder
    private func addPictureSection() -> some View {
        Section(header: Text("釣り場の写真")) {
            if let img = viewModel.image {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 200)
            }
            HStack {
                Spacer()
                Button("写真を選択") {
                    viewModel.showingActionSheet = true
                }
                Spacer()
            }
        }
    }

    @ViewBuilder
    private func saveButtonOrDeleteButtonView() -> some View {
        Section {
            HStack {
                Spacer()
                // MARK: ※更新ボタン
                Button(viewModel.editingLog != nil ? "更新する" : "追加する") {
                    let costDouble = Double(viewModel.cost) ?? 0.0
                    var newLog = FishingLog()
                    if let editingLog = viewModel.editingLog {
                        newLog.id = editingLog.id
                    }
                    newLog.title = viewModel.title
                    newLog.date = viewModel.date
                    newLog.startDate = viewModel.startDate
                    newLog.endDate = viewModel.endDate
                    newLog.fishType = viewModel.selectedFishType
                    newLog.length = Double(viewModel.selectedFishLength)
                    newLog.location = viewModel.location
                    newLog.fishNote = viewModel.fishNote
                    newLog.weather = viewModel.selectedWeather
                    newLog.tide = viewModel.selectedTide
                    newLog.tackleNote = viewModel.tackleNote
                    newLog.cost = costDouble

                    // FireStorageに保存する
                        viewModel.addLog(newLog) { logID in
                    }
                    // FireStoreに保存する
                    if let editingLog = viewModel.editingLog {
                        print("Editing log ID: \(editingLog.id)")
                        // Update existing log in Firebase
                        viewModel.updateLog(editingLog, with: newLog)
                    } else {
                        viewModel.addLog(newLog) { logID in
                            if let id = logID {
                                self.viewModel.currentLogID = id
                            }
                        }
                    }
                    presentationMode.wrappedValue.dismiss()
                }
                .buttonStyle(CustomButtonStyle())

                // 編集中の場合のみ、削除ボタンを表示
                if viewModel.editingLog != nil {
                    Spacer()
                    Button("削除する") {
                        viewModel.currentAlertType = .deleteConfirmation
                        viewModel.isShowingAlert = true
                    }
                    .buttonStyle(CustomDeleteButtonStyle())
                }
                Spacer()
            }
        }
    }
}


