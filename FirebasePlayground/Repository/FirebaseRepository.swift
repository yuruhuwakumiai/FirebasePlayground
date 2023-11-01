//
//  FirebaseRepository.swift
//  FirebasePlayground
//
//  Created by RikutoSato on 2023/10/30.
//

import SwiftUI
import FirebaseFirestore

class FirebaseRepository: ObservableObject {
    // ここでFirebaseからデータを取得する
    
    func getData() -> [String] {
        return ["りんご", "みかん", "スイカ"]
    }
}

/*
 
 View       - レイアウト
 ViewModel  - VIewに加工して渡す
 Model      - 変数を定義、処理
 Repository - データ通信など
 
 */

