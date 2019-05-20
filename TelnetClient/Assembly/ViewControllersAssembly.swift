//
//  ViewControllersAssembly.swift
//  TelnetClient
//
//  Created by Mohammad Farhan on 4/15/19.
//  Copyright © 2019 MohammadFarhan. All rights reserved.
//

import UIKit

final class Assembly {
    
    // MARK: - Static properties
    
    static private(set) var telnet: UIStoryboard = { UIStoryboard(name: "Main") }()
    
}

extension UIStoryboard {
    
    // MARK: - Init / Deinit
    
    convenience init(name: String) {
        self.init(name: name, bundle: .main)
    }
    
    // MARK: - Actions
    
    // swiftlint:disable force_cast
    func makeViewController<T: StoryboardInitiable>() -> T {
        return instantiateViewController(withIdentifier: T.storyboardIdentifier) as! T
    }
    
    func makeViewController(with storyboardIdentifier: String) -> UIViewController {
        return instantiateViewController(withIdentifier: storyboardIdentifier)
    }
    // swiftlint:enable force_cast
    
}
