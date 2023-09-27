//
//  FirebasePlaygroundApp.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/17.
//

import SwiftUI
import FirebaseCore

@main
struct FirebasePlaygroundApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var navigationManager = NavigationManager()

    var body: some Scene {
        WindowGroup {
            HomeListView()
                .environmentObject(navigationManager) // 一番最初の画面にenviromentObjectを認識させる
        }
    }
}
