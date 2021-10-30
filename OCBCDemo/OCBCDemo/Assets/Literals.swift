//
//  Literals.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 30/10/21.
//

import Foundation

struct LITERAL {
    struct DESCRIPTION {
        struct ERROR {
            static let LOGIN = "Username and Password cannot be nil"
        }
    }
    static let OK = "OK"
    static let ERROR = "Error"
    static let USERNAME = "Username"
    static let PASSWORD = "Password"
    static let LOGIN = "Login"
    static let NOTYOU = "Not you?"
    static let BALANCE = "Current Balance:"
    
    static let DASHBOARD_TITLE = "Your Account Overview"
}

struct ICON {
    static let APPICON = "appIcon"
    static let BACKGROUND = "background"
    static let LAUNCH = "launch"
    static let USERNAME = "username"
    static let PASSWORD = "password"
    static let SETTINGS = "settings"
}

struct CUSTOM_COLOR {
    static let THEME = "theme"
    struct BACKGROUND {
        static let PRIMARY = "background_primary"
        static let SECONDARY = "background_secondary"
        static let TERTIARY = "background_tertiary"
        static let QUATERNARY = "background_quad"
    }
    struct BORDER {
        static let PRIMARY = "border_primary"
        static let SECONDARY = "border_secondary"
        static let TERTIARY = "border_tertiary"
    }
    struct FONT {
        static let PRIMARY = "font_primary"
        static let SECONDARY = "font_secondary"
        static let TERTIARY = "font_tertiary"
    }
    struct GRADIENT {
        static let PRIMARY = "gradient_primary"
        static let SECONDARY = "gradient_secondary"
        static let TERTIARY = "gradient_tertiary"
    }
    struct TINT {
        static let PRIMARY = "tint_primary"
        static let SECONDARY = "tint_secondary"
    }
}
