//
//  CustomMonthYearPicker.swift
//  FirebasePlayground
//
//  Created by 橋元雄太郎 on 2023/09/18.
//

import SwiftUI

struct CustomMonthYearPicker: View {
    @Binding var selectedYear: Int
    @Binding var selectedMonth: Int

    var currentYear: Int {
        Calendar.current.component(.year, from: Date())
    }

    var years: [Int] {
        Array((currentYear - 5)...(currentYear + 5))
    }

    var body: some View {
        HStack {
            // 年の選択
            Menu {
                ForEach(years, id: \.self) { year in
                    Button("\(formatNumber(year))年") {
                        selectedYear = year
                    }
                    .foregroundColor(Color.clear)
                }
            } label: {
                HStack {
                    Text("\(formatNumber(selectedYear))年")
                    Image(systemName: "chevron.down") // アイコンを追加
                }
                .foregroundColor(Color.clear)
                .padding(10) // パディングを追加
                .background(Color(.systemGray5)) // 背景色を変更
                .cornerRadius(8) // 角を丸くする
            }

            Spacer().frame(width: 20)

            // 月の選択
            Menu {
                ForEach(1...12, id: \.self) { month in
                    Button("\(month)月") {
                        selectedMonth = month
                    }
                    .foregroundColor(Color.clear)
                }
            } label: {
                HStack {
                    Text("\(selectedMonth)月")
                    Image(systemName: "chevron.down") // アイコンを追加
                }
                .foregroundColor(Color.clear)
                .padding(10) // パディングを追加
                .background(Color(.systemGray5)) // 背景色を変更
                .cornerRadius(8) // 角を丸くする
            }
        }
    }


    func formatNumber(_ number: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter.string(from: NSNumber(value: number)) ?? ""
    }
}
