//
//  ViewDisplayable.swift
//  TelnetClient
//
//  Created by Mohammad Farhan on 4/15/19.
//  Copyright © 2019 MohammadFarhan. All rights reserved.
//

import UIKit

protocol ViewDisplayable: class {
    func displayView(title: String)
}

extension ViewDisplayable where Self: UIViewController {
    
    func displayView(title: String) {
        self.title = title
    }
    
}
