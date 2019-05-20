//
//  ViewControllersAssembly+SSH.swift
//  TelnetClient
//
//  Created by Mohammad Farhan on 4/15/19.
//  Copyright © 2019 MohammadFarhan. All rights reserved.
//

import UIKit

extension Assembly {
    
    static var telnetController: UIViewController {
        let view: TelnetViewController = telnet.makeViewController()
        let gateway = TelnetGatewayImplementation()
        let presenter = TelnetPresenter(view: view, gateway: gateway)
        gateway.sessionDelegate = presenter
        view.presenter = presenter
        return view
    }
    
}
