//
//  NavigationManager.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/17.
//

//import SwiftUI
//
//class NavigationManager: ObservableObject {
//    @Published var path: [ShowView] = []
//    var currentViewModel: Any?
//    var uiViewModel: Any?
//    var logDataViewModel: Any?
//    var logStateViewModel: Any?
//    var logFilterViewModel: Any?
//    var logUtilityViewModel: Any?
//
//    // ここでViewModelをセットする。
//    func setCurrentViewModel(_ viewModel: Any) {
//        currentViewModel = viewModel
//    }
//
//    func setUiViewModel(_ viewModel: Any) {
//        uiViewModel = viewModel
//    }
//
//    func setLogViewModel(_ viewModel: Any) {
//        logDataViewModel = viewModel
//    }
//
//    func setLogStateViewModel(_ viewModel: Any) {
//        logStateViewModel = viewModel
//    }
//
//    func setLogFilterViewModel(_ viewModel: Any) {
//        logFilterViewModel = viewModel
//    }
//
//    func setlogUtilityViewModel(_ viewModel: Any) {
//        logUtilityViewModel = viewModel
//    }
//}
//
//struct NavigationDestinationModifier: ViewModifier {
//    @EnvironmentObject var navigationManager: NavigationManager
//
//    func body(content: Content) -> some View {
//        content
//            .navigationDestination(for: ShowView.self) { showView in // ②
//                let viewModel = navigationManager.currentViewModel
//                let uiViewModel = navigationManager.uiViewModel
//                let logDataViewModel = navigationManager.logDataViewModel
//                let logStateViewModel = navigationManager.logStateViewModel
//                let logFilterViewModel = navigationManager.logFilterViewModel
//                let logUtilityViewModel = navigationManager.logUtilityViewModel
//
//                switch showView {
////                case .HomeListView:
////                    HomeListView(uiViewModel: uiViewModel as! FishingLogUIViewModel, fishingLogDataViewModel: logDataViewModel as! FishingLogDataViewModel, logStateViewModel: logStateViewModel as! FishingLogStateViewModel, logFilterViewModel: logFilterViewModel as! FishingLogFilterViewModel, logUtilityViewModel: logUtilityViewModel as! FishingLogUtilityViewModel)
//                case .AddListView:
//                    AddListView(uiViewModel: uiViewModel as! FishingLogUIViewModel, fishingLogDataViewModel: logDataViewModel as! FishingLogDataViewModel)
////                case .FishInputView:
////                    FishInputView(viewModel: viewModel as! FishingLogViewModel)
//                }
//            }
//    }
//}
//
//// ①
//enum ShowView: Hashable {
//    case HomeListView
//    case AddListView
////    case FishInputView
//}
