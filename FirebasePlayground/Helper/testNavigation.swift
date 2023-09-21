//
//  testNavigation.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/21.
//

//import SwiftUI
//
//// ViewModelのセットを行うための構造体
//struct ViewModels {
//    var fishingLogViewModel: FishingLogViewModel?
//    var fishingLogUIViewModel: FishingLogUIViewModel?
//    var fishingLogDataViewModel: FishingLogDataViewModel?
//    var fishingLogStateViewModel: FishingLogStateViewModel?
//    var fishingLogFilterViewModel: FishingLogFilterViewModel?
//    var fishingLogUtilityViewModel: FishingLogUtilityViewModel?
//}
//
//class NavigationManager: ObservableObject {
//    @Published var path: [ShowView] = []
//    var viewModels = ViewModels()
//
//    // このようにビューモデルをセットできます
//    func setViewModels(_ viewModels: ViewModels) {
//        self.viewModels = viewModels
//    }
//}
//
//
//struct NavigationDestinationModifier: ViewModifier {
//    @EnvironmentObject var navigationManager: NavigationManager
//
//    func body(content: Content) -> some View {
//        content
//            .navigationDestination(for: ShowView.self) { showView in
//                let vm = navigationManager.viewModels // 短く書くために一時変数を使用
//
//                switch showView {
//                case .HomeListView:
//                    if let viewModel = vm.fishingLogViewModel,
//                       let uiViewModel = vm.fishingLogUIViewModel,
//                       let dataViewModel = vm.fishingLogDataViewModel,
//                       let stateViewModel = vm.fishingLogStateViewModel,
//                       let filterViewModel = vm.fishingLogFilterViewModel,
//                       let utilityViewModel = vm.fishingLogUtilityViewModel {
//                        HomeListView(
//                            viewModel: viewModel,
//                            uiViewModel: uiViewModel,
//                            fishingLogDataViewModel: dataViewModel,
//                            logStateViewModel: stateViewModel,
//                            logFilterViewModel: filterViewModel,
//                            logUtilityViewModel: utilityViewModel
//                        )
//                    }
//
//                case .AddListView:
//                    if let viewModel = vm.fishingLogViewModel,
//                       let uiViewModel = vm.fishingLogUIViewModel,
//                       let dataViewModel = vm.fishingLogDataViewModel {
//                        AddListView(
//                            viewModel: viewModel,
//                            uiViewModel: uiViewModel,
//                            fishingLogDataViewModel: dataViewModel
//                        )
//                    }
//
//                    //                case .StatisticsView:
//                    //                    if let viewModel = vm.fishingLogViewModel {
//                    //                        StatisticsView(viewModel: viewModel)
//                    //                    }
//
//                    //                case .FishInputView:
//                    //                    if let viewModel = vm.fishingLogViewModel {
//                    //                        FishInputView(viewModel: viewModel)
//                    //                    }
//
//                    //                case .TackleInputView:
//                    //                    if let viewModel = vm.fishingLogViewModel {
//                    //                        TackleInputView(viewModel: viewModel)
//                    //                    }
//                }
//            }
//    }
//}
//
//
//// ①
//enum ShowView: Hashable {
//    case HomeListView
//    case AddListView
//    //    case FishInputView
//}
