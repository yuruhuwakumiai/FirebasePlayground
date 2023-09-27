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
    
    func setCurrentViewModel(_ viewModel: Any) {
        currentViewModel = viewModel
    }
}

struct NavigationDestinationModifier: ViewModifier {
    @EnvironmentObject var navigationManager: NavigationManager

    func body(content: Content) -> some View {
        NavigationStack(path: $navigationManager.path) {
            content
                .navigationDestination(for: ShowView.self) { showView in // ②
                    let viewModel = navigationManager.currentViewModel
                    switch showView {
                    case .addListView:
                        AddListView(viewModel: viewModel as! AddListViewModel)
                    }
                }
        }
    }
}

enum ShowView: Hashable {
    case addListView
}
