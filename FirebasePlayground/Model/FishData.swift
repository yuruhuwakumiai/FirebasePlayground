//
//  Model.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/17.
//

import Foundation
// MARK: enum
enum AlertType {
    case deleteConfirmation
    case unsavedChanges
    case saveFirst
}

enum WeatherTypes: String, CaseIterable, Codable {
    case sunny = "晴れ"
    case cloudy = "曇り"
    case rainy = "雨"
}

enum TideTypes: String, CaseIterable, Codable {
    case highTide = "大潮"
    case lowTide = "小潮"
    case midTide = "中潮"
}

enum FishType: String, CaseIterable, Codable {
    case salmon = "サーモン"
    case trout = "トラウト"
    case tuna = "マグロ"
}

enum ImagePickerAction: Codable {
    case library, camera, delete, cancel
}

struct Fish: Codable, Identifiable {
    var id: String = UUID().uuidString
    var type: String = ""
    var count: Int = 1
    var length: Double = 0.0
    var weightKilo: Int = 0
    var weightGram: Int = 0
    var imageData: Data?
    var logID: String
}

struct FishingLog: Codable, Identifiable {
    var id: String = UUID().uuidString
    var title: String = ""
    var date: Date = Date()
    var startDate: Date = Date()
    var endDate: Date = Date()
    var fishType: String = ""
    var length: Double = 0.0
    var weight: Double = 0.0
    var location: String?
    var fishNote: String?
    var weatherString: String?
    var tideString: String?
    var tackleNote: String?
    var cost: Double = 0.0

    var imageURL: String?

    var fishes: [Fish] = []

    var weather: WeatherTypes? {
        get {
            if let weather = weatherString {
                return WeatherTypes(rawValue: weather)
            }
            return nil
        }
        set {
            weatherString = newValue?.rawValue
        }
    }

    var tide: TideTypes? {
        get {
            if let tide = tideString {
                return TideTypes(rawValue: tide)
            }
            return nil
        }
        set {
            tideString = newValue?.rawValue
        }
    }
}
// TODO: 別ファルに分ける Home画面で表示するもの
struct FishPost {
    var title = ""
}

// MARK: ひとまず全部このストラクトにいれた
struct FishData {

    // AddFishingLogScreen
    var currentAlertType: AlertType?
    var isShowingAlert: Bool = false
    var isShowingInputView = false
    var selectedFishType = FishType.salmon.rawValue
    var selectedFishLength = 0.0
    var selectedFishWeight = 0.0
    var title: String = ""
    var date = Date()
    var startDate: Date = Date()
    var endDate: Date = Date()
    var fishType = ""
    var length: String = ""
    var location = ""
    var fishNote = ""
    var cost: String = ""
    var selectedWeather = WeatherTypes.sunny
    var selectedTide = TideTypes.highTide
    var tackleNote: String = ""
    var showingImagePicker = false
    var isUsingCamera: Bool = false
    var showingActionSheet = false
    var selectedAction: ImagePickerAction? = nil
    var isShowingTackleInputView = false
    var tackleInput: String = ""
    var showingDeleteAlert = false
    var logs: [FishingLog] = []

    var needsRefresh: Bool = false
    var showingSaveFirstAlert: Bool = false
    var showingUnsavedChangesAlert = false // 戻る時の保存確認
    var editingLog: FishingLog? = nil // 新規か編集かを判断

    // MARK: FishInputView
    var isPresented: Bool = false
    var selectedTime = Date()
    var selectedFishTypeIndex: Int = 0
    var fishLengthString: String = ""
    var fishKiloWeightString: String = ""
    var fishGramWeightString: String = ""

    // MARK: TacleInputView
    //    @Published var selectedTackleTypeIndex: Int = 0
    //    @Published var selectedTackleMaterialIndex: Int = 0
    //    @Published var tackleSizeString: String = ""
    //    @Published var baitString: String = ""
    //    @Published var selectedRodIndex: Int = 0
    //    @Published var selectedReelIndex: Int = 0
}
