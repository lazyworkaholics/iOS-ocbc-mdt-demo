//
//  StringConstants.swift
//  OCBCDemo
//
//  Created by Pabbineedi Harsha on 28/10/21.
//

import Foundation

struct NETWORK {
    static let BASE_URL = "http://localhost:8080/"
    struct HEADERS {
        static let CONTENT_TYPE = "Content-Type"
        static let APP_JSON = "application/json"
        static let ACCEPT = "Accept"
        static let AUTHORIZATION = "Authorization"
    }
    struct BODY {
        static let USERNAME = "username"
        static let PASSWORD = "password"
    }
    struct PATH {
        static let LOGIN = "authenticate/login"
        static let BALANCE = "account/balances"
        static let PAYEES = "account/payees"
        static let TRANSACTIONS = "account/transactions"
        static let TRANSFER = "transfer"
    }
}

struct ERROR {
    static let ERROR_MESSAGE_KEY = "Error Message"
    struct INVALID_REQUEST {
        static let DOMAIN = "ocbc_demo.local_error.invalid_request"
        static let CODE = 1008
        static let DESCRIPTION = "The request is not valid"
    }
    struct NO_INTERNET {
        static let DOMAIN = "ocbc_demo.local_error.no_internet"
        static let CODE = 1009
        static let DESCRIPTION = "Internet connection appears to be offline"
    }
    struct PARSING {
        static let DOMAIN = "ocbc_demo.local_error.parsing_failure"
        static let CODE = 1010
        static let DESCRIPTION = "Cannot parse response of the httpclient"
    }
    struct HTTPURLRESPONSE {
        static let DOMAIN = "ocbc_demo.local_error.httpurlresponse_error"
    }
    struct STATUS_200 {
        static let DOMAIN = "ocbc_demo.local_error.200_status_error"
        static let CODE = 1012
        static let DESCRIPTION = "Internet connection appears to be offline"
    }
}

struct VIEWCONTROLLERS {
    
    static let DASHBOARD = "DashboardViewController"
    static let LOGIN = "LoginViewController"
    static let TRANSFER = "TransferViewController"
    static let SETTINGS = "SettingsViewController"
    static let DETAIL = "DetailViewController"
}

struct LITERALS {
    static let MAIN = "Main"
    static let OK = "OK"
}
