//
//  Element.swift
//  HappyMoney
//
//  Created by MAC on 2023/05/28.
//
import UIKit
import Foundation
import RealmSwift

//クラスの定義
class Element: Object {
    @Persisted var createdDate: Date = Date() // 要素の作成日時(プライマリーキー、変更不可)
    @Persisted var date: Int = 230528 // 日付[yymmdd]
//    @Persisted var index: Int = 0 // 同じ日付内での順番(未使用)
    @Persisted var amount: Int = 0 // 金額
    @Persisted var note: String = "" // メモ
    @Persisted var type: Int = 0//　0: 支出, 1: 収入
}


