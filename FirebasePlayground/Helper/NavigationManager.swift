//
//  NavigationManager.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/17.
//

import SwiftUI

class NavigationManager: ObservableObject {
    @Published var path: [ShowView] = []
    var currentViewModel: Any?

    // ここでViewModelをセットする。
    func setCurrentViewModel(_ viewModel: Any) {
        currentViewModel = viewModel
    }
}

struct NavigationDestinationModifier: ViewModifier {
    @EnvironmentObject var navigationManager: NavigationManager

    func body(content: Content) -> some View {
        content
            .navigationDestination(for: ShowView.self) { showView in // ②
                let viewModel = navigationManager.currentViewModel

                switch showView {
                case .HomeListView:
                    HomeListView(viewModel: viewModel as! FishingLogViewModel)
                case .AddListView:
                    AddListView(viewModel: viewModel as! FishingLogViewModel)
//                case .FishInputView:
//                    FishInputView(viewModel: viewModel as! FishingLogViewModel)
                }
            }
    }
}

// ①
enum ShowView: Hashable {
    case HomeListView
    case AddListView
//    case FishInputView
}
