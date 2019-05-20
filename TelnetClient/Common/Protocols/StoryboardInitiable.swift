//
//  StoryboardInitiable.swift
//  TelnetClient
//
//  Created by Mohammad Farhan on 4/15/19.
//  Copyright © 2019 MohammadFarhan. All rights reserved.
//

import UIKit

protocol StoryboardInitiable {
    
    static var storyboardIdentifier: String { get }
}

extension StoryboardInitiable where Self: UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryboardInitiable { }
