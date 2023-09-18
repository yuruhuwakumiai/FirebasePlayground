//
//  CustomNavigationBarItems.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/18.
//

//import SwiftUI
//
//struct CustomNavigationBarItems: ViewModifier {
//    @EnvironmentObject private var navigationManager: NavigationManager
//    let viewModel: FishingLogViewModel
//
//    func body(content: Content) -> some View {
//        content
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        //                        navigationManager.setCurrentViewModel(viewModel)
//                        //                        navigationManager.path.append(.StatisticsView)
//                    } label: {
//                        Image(systemName: "chart.bar.fill") // 統計のアイコン
//                            .foregroundColor(Color.main_color)
//                            .imageScale(.large) // アイコンのサイズを調整
//                            .padding(.trailing, 10) // 右側のスペース
//                    }
//                }
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        viewModel.prepareForNewLog()
//                        navigationManager.setCurrentViewModel(viewModel)
//                        navigationManager.path.append(.AddFishingLogScreen)
//                    } label: {
//                        Image(systemName: "plus.circle.fill") // 「追加」のアイコン
//                            .foregroundColor(Color.main_color)
//                            .imageScale(.large) // アイコンのサイズを調整
//                    }
//                }
//            }
//    }
//}
//
//extension View {
//    func customNavigationBarItems(viewModel: FishingLogViewModel) -> some View {
//        self.modifier(CustomNavigationBarItems(viewModel: viewModel))
//    }
//}
//
