//
//  FirebasePlaygroundApp.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/17.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        return true
    }
}

@main
struct FirebasePlaygroundApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject var navigationManager = NavigationManager()

    var body: some Scene {
        WindowGroup {
            HomeListView(viewModel: FishingLogViewModel())
                .environmentObject(navigationManager) // 一番最初の画面にenviromentObjectを認識させる
        }
    }
}
