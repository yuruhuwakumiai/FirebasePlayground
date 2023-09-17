//
//  Model.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/17.
//

import SwiftUI

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

enum SearchCriteria: String, CaseIterable {
    case date = "日付"
    case fish = "魚種"
    case tackle = "仕掛け"
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

    var image: UIImage? {
        get {
            if let data = imageData {
                return UIImage(data: data)
            }
            return nil
        }
        set {
            imageData = newValue?.pngData()
        }
    }
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
