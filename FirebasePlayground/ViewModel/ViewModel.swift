//
//  ViewModel.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/17.
//

import SwiftUI
import Firebase

class FishingLogViewModel: ObservableObject {

    private var firebaseService = FireStoreManager() // firebase

    func prepareForNewLog() {
        title = ""
        date = Date()
        startDate = Date()
        endDate = Date()
        fishType = ""
        length = ""
        location = ""
        fishNote = ""
        image = nil
        tackleNote = ""
        selectedFishType = FishType.salmon.rawValue
        selectedFishLength = 0.0
        selectedFishWeight = 0.0
        fishes = []
        showingFishImagePicker = false
        //        currentLog = nil
        selectedTackleTypeIndex = 0
        selectedTackleMaterialIndex = 0
        tackleSizeString = ""
        baitString = ""
        selectedRodIndex = 0
        selectedReelIndex = 0
        editingLog = nil
    }

    func prepareForEditing(log: FishingLog) {
        title = log.title
        date = log.date
        startDate = log.startDate
        endDate = log.endDate
        fishType = log.fishType
        length = "\(log.length)"
        location = log.location ?? ""
        fishNote = log.fishNote ?? ""
        tackleNote = log.tackleNote ?? ""
        selectedFishType = log.fishType
        selectedFishLength = log.length
        selectedFishWeight = log.weight
        fishes = log.fishes
        showingFishImagePicker = false
        currentLog = log
        selectedTackleTypeIndex = 0
        selectedTackleMaterialIndex = 0
        tackleSizeString = ""
        baitString = ""
        selectedRodIndex = 0
        selectedReelIndex = 0
        editingLog = log
    }


    // AddFishingLogScreen
    @Published var isShowingInputView = false
    @Published var selectedFishType = FishType.salmon.rawValue
    @Published var selectedFishLength = 0.0
    @Published var selectedFishWeight = 0.0
    @Published var title: String = ""
    @Published var date = Date()
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var fishType = ""
    @Published var length: String = ""
    @Published var location = ""
    @Published var fishNote = ""
    @Published var image: UIImage?
    @Published var cost: String = ""
    @Published var selectedWeather = WeatherTypes.sunny
    @Published var selectedTide = TideTypes.highTide
    @Published var tackleNote: String = ""
    @Published var showingImagePicker = false
    @Published var isUsingCamera: Bool = false
    @Published var showingActionSheet = false
    @Published var selectedAction: ImagePickerAction? = nil
    @Published var isShowingTackleInputView = false
    @Published var tackleInput: String = ""
    @Published var showingDeleteAlert = false
    @Published var logs: [FishingLog] = []
    @Published var searchText = ""
    @Published var selectedSearchCriteria = SearchCriteria.date
    @Published var needsRefresh: Bool = false
    @Published var selectedYear: Int = Calendar.current.component(.year, from: Date())
    @Published var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @Published var images: [String: UIImage] = [:]  // キーはFishingLogのID、値は画像
    @Published var showingSaveFirstAlert: Bool = false


    @Published var showingUnsavedChangesAlert = false // 戻る時の保存確認
    @Published var editingLog: FishingLog? = nil // 新規か編集かを判断
    @Published var navigationManager = NavigationManager()



    // MARK: FishInputView
    @Published var isPresented: Bool = false
    @Published var selectedTime = Date()
    @Published var selectedFishTypeIndex: Int = 0
    @Published var fishLengthString: String = ""
    @Published var fishKiloWeightString: String = ""
    @Published var fishGramWeightString: String = ""
    // 写真追加のため Fishsに入れ直してるから前の変数消した方がいいかも
    @Published var currentFishImage: UIImage?
    @Published var fishes: [Fish] = []
    @Published var showingFishImagePicker = false
    @Published var currentLog: FishingLog?
    @Published var currentLogID: String?



    // MARK: TacleInputView
    @Published var selectedTackleTypeIndex: Int = 0
    @Published var selectedTackleMaterialIndex: Int = 0
    @Published var tackleSizeString: String = ""
    @Published var baitString: String = ""
    @Published var selectedRodIndex: Int = 0
    @Published var selectedReelIndex: Int = 0

    // 年度と月ごとにlogをフィルタリング
    var logsByYearAndMonth: [String: [FishingLog]] {
        Dictionary(grouping: logs) { log in
            let components = Calendar.current.dateComponents([.year, .month], from: log.date)
            if let year = components.year, let month = components.month {
                return "\(year)-\(month)"
            } else {
                return "Unknown"
            }
        }
    }

    // 検索でlogをフィルタリング
    var filteredLogs: [String: [FishingLog]] {
        var currentFilteredLogs = logsByYearAndMonth

        switch selectedSearchCriteria {
        case .fish:
            currentFilteredLogs = currentFilteredLogs.mapValues { logs in
                logs.filter { log in
                    return log.fishNote?.contains(searchText) ?? false
                }
            }.filter { $0.value.count > 0 }
        case .tackle:
            currentFilteredLogs = currentFilteredLogs.mapValues { logs in
                logs.filter { log in
                    return log.tackleNote?.contains(searchText) ?? false
                }
            }.filter { $0.value.count > 0 }
        case .date:
            let key = "\(selectedYear)-\(selectedMonth)"
            currentFilteredLogs = currentFilteredLogs.filter { $0.key == key }
        }

        return currentFilteredLogs
    }

    func loadLogs() {
        firebaseService.fetchLogs { logs, error in
            if let error = error {
                print("Failed to fetch logs: \(error)")
            } else if let logs = logs {
                self.logs = logs
                print("Fetched \(logs.count) logs.")
            }
        }
    }

    func addLog(_ log: FishingLog, completion: @escaping (String?) -> Void) {
        firebaseService.saveLog(log: log) { error in
            if let error = error {
                print("Failed to save log: \(error)")
                completion(nil)
            } else {
                self.currentLogID = log.id
                print("Current Log ID after adding new log: \(self.currentLogID ?? "nil")")
                self.loadLogs()
                print("Saved log: \(log)")
                completion(self.currentLogID)
            }
        }
    }


    func updateLog(_ log: FishingLog, with newLog: FishingLog) {
        do {
            let updatedData = try newLog.asDictionary()
            firebaseService.updateLog(logID: log.id, updatedData: updatedData) { error in
                if let error = error {
                    print("Failed to update log: \(error)")
                } else {
                    print("Log updated successfully!")
                    // 必要に応じて、UIを更新するための処理を追加する
                    self.loadLogs()
                }
            }
        } catch {
            print("Error converting log to dictionary: \(error)")
        }
    }

    func saveFish(fish: Fish) {
        guard let logID = currentLogID else {
            print("Error: saveFish(): currentLogID is nil")
            return
        }

        // Firebaseへの保存ロジックをこちらに実装
        firebaseService.saveFish(fish: fish, logID: logID) { error in
            if let error = error {
                print("Failed to save fish: \(error)")
            } else {
                print("Saved fish: \(fish)")
            }
        }
    }


    func loadFishes(for logID: String) {
        firebaseService.fetchFishes(for: logID) { fishes, error in
            if let error = error {
                print("Failed to fetch fishes: \(error)")
            } else if let fishes = fishes {
                self.fishes = fishes.filter { $0.logID == logID }
                print("Fetched \(fishes.count) fishes.")
            }
        }
    }


    func timeRangeString(from start: Date, to end: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let startTime = formatter.string(from: start)
        let endTime = formatter.string(from: end)

        return "\(startTime)時〜\(endTime)時"
    }
    // 日付の表示
    func dateString(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M月d日"

        return dateFormatter.string(from: date)
    }
}
