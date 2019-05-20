//
//  SSHError.swift
//  TelnetClient
//
//  Created by Mohammad Farhan on 4/9/19.
//  Copyright © 2019 MohammadFarhan. All rights reserved.
//

import Foundation

enum SSHError: Error {
    case notConnected(String)
    case notAuthorized
}

extension SSHError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .notConnected(host):
            return "ssh: Could not resolve hostname \(host): nodename nor servname provided, or not known\n"
        case .notAuthorized:
            return "Permission denied (publickey,password)\n"
        }
    }
}
