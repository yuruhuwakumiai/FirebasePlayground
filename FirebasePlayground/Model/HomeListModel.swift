//
//  HomeListModel.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/23.
//

import Foundation

class HomeListModel: ObservableObject {
    @Published var fishData = FishData()

    func prepareForNewLog() {
        fishData.title = ""
        fishData.date = Date()
        fishData.startDate = Date()
        fishData.endDate = Date()
        fishData.fishType = ""
        fishData.length = ""
        fishData.location = ""
        fishData.fishNote = ""
//        fishData.image = nil
        fishData.tackleNote = ""
        fishData.selectedFishType = FishType.salmon.rawValue
        fishData.selectedFishLength = 0.0
        fishData.selectedFishWeight = 0.0
//        fishData.fishes = []
//        fishData.showingFishImagePicker = false
//        fishData.selectedTackleTypeIndex = 0
//        fishData.selectedTackleMaterialIndex = 0
//        fishData.tackleSizeString = ""
//        fishData.baitString = ""
//        fishData.selectedRodIndex = 0
//        fishData.selectedReelIndex = 0
        fishData.editingLog = nil
    }

    func prepareForEditing(log: FishingLog) {
        fishData.title = log.title
        fishData.date = log.date
        fishData.startDate = log.startDate
        fishData.endDate = log.endDate
        fishData.fishType = log.fishType
        fishData.length = "\(log.length)"
        fishData.location = log.location ?? ""
        fishData.fishNote = log.fishNote ?? ""
        fishData.tackleNote = log.tackleNote ?? ""
        fishData.selectedFishType = log.fishType
        fishData.selectedFishLength = log.length
        fishData.selectedFishWeight = log.weight
//        fishData.fishes = log.fishes
//        fishData.showingFishImagePicker = false
//        fishData.currentLog = log
//        fishData.selectedTackleTypeIndex = 0
//        fishData.selectedTackleMaterialIndex = 0
//        fishData.tackleSizeString = ""
//        fishData.baitString = ""
//        fishData.selectedRodIndex = 0
//        fishData.selectedReelIndex = 0
        fishData.editingLog = log
    }
}
