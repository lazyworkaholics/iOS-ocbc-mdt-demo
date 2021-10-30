//
//  Font.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 29/10/21.
//

import UIKit

enum FontSize:CGFloat {
    case xs = 10.0
    case s = 14.0
    case m = 18.0
    case l = 22.0
    case xl = 26.0
}
enum FontFamily: String {
    case Arial = "Arial"
    case American = "American Typewriter"
    case Apple = "Apple Color Emoji"
}

enum FontStyle {
    case Bold
    case Italic
    case Regular
}
struct Fonts {
    struct Arial {
        static let xs = UIFont.init(name: FontFamily.Arial.rawValue, size: FontSize.xs.rawValue)
        static let s = UIFont.init(name: FontFamily.Arial.rawValue, size: FontSize.s.rawValue)
        static let m = UIFont.init(name: FontFamily.Arial.rawValue, size: FontSize.m.rawValue)
        static let l = UIFont.init(name: FontFamily.Arial.rawValue, size: FontSize.l.rawValue)
        static let xl = UIFont.init(name: FontFamily.Arial.rawValue, size: FontSize.xl.rawValue)
    }
    struct American {
        static let xs = UIFont.init(name: FontFamily.American.rawValue, size: FontSize.xs.rawValue)
        static let s = UIFont.init(name: FontFamily.American.rawValue, size: FontSize.s.rawValue)
        static let m = UIFont.init(name: FontFamily.American.rawValue, size: FontSize.m.rawValue)
        static let l = UIFont.init(name: FontFamily.American.rawValue, size: FontSize.l.rawValue)
        static let xl = UIFont.init(name: FontFamily.American.rawValue, size: FontSize.xl.rawValue)
    }
    struct Apple {
        static let xs = UIFont.init(name: FontFamily.Apple.rawValue, size: FontSize.xs.rawValue)
        static let s = UIFont.init(name: FontFamily.Apple.rawValue, size: FontSize.s.rawValue)
        static let m = UIFont.init(name: FontFamily.Apple.rawValue, size: FontSize.m.rawValue)
        static let l = UIFont.init(name: FontFamily.Apple.rawValue, size: FontSize.l.rawValue)
        static let xl = UIFont.init(name: FontFamily.Apple.rawValue, size: FontSize.xl.rawValue)
    }
}


