//
//  MainTabScreen.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/18.
//

import SwiftUI

struct MainTabScreen: View {
    @StateObject private var viewModel = FishingLogViewModel()

    var body: some View {
        TabView {
            HomeListView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("記録")
                }

            AboutAppView()
                .tabItem {
                    Image(systemName: "figure.fishing")
                    Text("その他")
                }
        }
        .accentColor(Color.main_color)  // ここでアクセント色を設定

    }
}


struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabScreen()
    }
}
