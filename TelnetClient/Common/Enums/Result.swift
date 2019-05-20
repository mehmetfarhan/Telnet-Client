//
//  Result.swift
//  TelnetClient
//
//  Created by Mohammad Farhan on 4/9/19.
//  Copyright © 2019 MohammadFarhan. All rights reserved.
//

import Foundation

enum Result<Value> {
    case success(Value)
    case failure(Error)
}

