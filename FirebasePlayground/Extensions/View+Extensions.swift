//
//  View+Extensions.swift
//  FirebasePlayground
//
//  Created by RikutoSato on 2023/09/27.
//

import SwiftUI

extension View {
    /// 背景色変更
    @ViewBuilder
    func backgroundView(_ backgroundColor: Color = .red) -> some View {
        backgroundColor
            .edgesIgnoringSafeArea(.all)
            .overlay { self }
    }
    
    /// ナビゲーション設定
    @ViewBuilder
    func navigationSetting(_ title: String) -> some View {
        self
            .navigationTitle(title)
            .navigationBarTitleDisplayMode(.inline)
    }
}
