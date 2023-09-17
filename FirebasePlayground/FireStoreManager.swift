//
//  FireStoreManager.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/17.
//

import SwiftUI
import FirebaseFirestoreSwift
import Firebase

class FireStoreManager {
    private var db: Firestore

    init() {
        db = Firestore.firestore()
    }

    func saveLog(log: FishingLog, completion: @escaping (Error?) -> Void) {
        do {
            var newLog = log

            // ドキュメントのIDが未設定の場合は新しいIDを生成して設定する
            if newLog.id.isEmpty {
                let newDocRef = db.collection("logs").document()
                newLog.id = newDocRef.documentID
                print("Generated new log ID: \(newLog.id)")  // ここを追加
            }

            let logData = try newLog.asDictionary()
            db.collection("logs").document(newLog.id).setData(logData) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }


    func fetchLogs(completion: @escaping ([FishingLog]?, Error?) -> Void) {
        db.collection("logs").getDocuments { (querySnapshot, error) in
            if let error = error {
                completion(nil, error)
            } else {
                var logs: [FishingLog] = []
                for document in querySnapshot!.documents {
                    if let log = FishingLog(dictionary: document.data()) {
                        logs.append(log)
                    }
                }
                completion(logs, nil)
            }
        }
    }

    func updateLog(logID: String, updatedData: [String: Any], completion: @escaping (Error?) -> Void) {
        db.collection("logs").document(logID).updateData(updatedData) { error in
            completion(error)
        }
    }

    func saveFish(fish: Fish, logID: String, completion: @escaping (Error?) -> Void) {
        do {
            var newFish = fish
            newFish.logID = logID
            print("Saving fish for log ID: \(logID)")  // ここを追加

            let fishData = try newFish.asDictionary()
            db.collection("fishes").addDocument(data: fishData) { error in
                completion(error)
            }
        } catch {
            completion(error)
        }
    }


    func fetchFishes(for logID: String, completion: @escaping ([Fish]?, Error?) -> Void) {
        print("Fetching fishes for log ID: \(logID)")  // ここを追加

        db.collection("fishes").whereField("logID", isEqualTo: logID).getDocuments { (snapshot, error) in
            if let error = error {
                completion(nil, error)
                return
            }

            let fishes = snapshot?.documents.compactMap { document in
                var data = document.data()
                data["id"] = document.documentID
                return Fish(dictionary: data)
            }

            print("Converted fishes: \(fishes)")
            completion(fishes, nil)
        }
    }


    // Add other methods for saving, fetching, updating, and deleting logs and fishes as needed
}

extension FishingLog {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        if let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
            return dictionary
        } else {
            throw NSError(domain: "FishingLog", code: -1, userInfo: nil)
        }
    }

    init?(dictionary: [String: Any]) {
        let data = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        if let data = data {
            let log = try? JSONDecoder().decode(FishingLog.self, from: data)
            if let log = log {
                self = log
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}

extension Fish {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        if let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
            return dictionary
        } else {
            throw NSError(domain: "Fish", code: -1, userInfo: nil)
        }
    }

    init?(dictionary: [String: Any]) {
        let data = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        if let data = data {
            let fish = try? JSONDecoder().decode(Fish.self, from: data)
            if let fish = fish {
                self = fish
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
