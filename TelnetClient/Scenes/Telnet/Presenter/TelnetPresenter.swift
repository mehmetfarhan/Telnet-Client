//
//  TelnetPresenter.swift
//  TelnetClient
//
//  Created by Mohammad Farhan on 5/19/19.
//  Copyright © 2019 MohammadFarhan. All rights reserved.
//

import Foundation

protocol TelnetPresenterInput {
    func performCommand(after text: String)
    func shouldChangeTextIn(_ string: String) -> Bool
    func viewDidLoad()
}

protocol TelnetPresentation: ViewDisplayable {
    func append(text: String)
    func drop()
    func clearText()
    func replace(text: String)
    func setTextFieldEnabled(isEnabled: Bool)
    func configure()
}

final class TelnetPresenter {
    
    // MARK: - Properties
    
    private weak var view: TelnetPresentation?
    var lastCommand = ""
    private var textViewLength = 0
    private var range = NSRange()
    private let gateway: TelnetGateway

    // MARK: - Init / Deinit
    
    init(view: TelnetPresentation,
         gateway: TelnetGateway) {
        self.view = view
        self.gateway = gateway
    }
}

// MARK: - Telnet Presenter Input

extension TelnetPresenter: TelnetPresenterInput {
    
    func viewDidLoad() {
        view?.configure()
        connect()
    }
    
    func shouldChangeTextIn(_ string: String) -> Bool {
        
        if string == "" , !lastCommand.isEmpty {
            view?.drop()
        } else {
            view?.append(text: string)
        }
        
        lastCommand += string
        performCommand(after: string)
        return true
    }
    
    func performCommand(after text: String) {
        let returnText = "\n"
        guard text == returnText else { return }
        view?.clearText()
        write()
    }
    
}

// MARK: - Gateway

extension TelnetPresenter {
    
    func write() {
        gateway.write(command: lastCommand)
        self.lastCommand = ""
    }
    
    func connect() {
        gateway.connect(toHost: "4.71.144.98")
        view?.setTextFieldEnabled(isEnabled: true)
    }
}

// MARK: - Telnet Session Delegate

extension TelnetPresenter: TelnetSessionDelegate {
    func shouldEcho(_ echo: Bool) {
        print(echo)
    }
    
    func didReceiveMessage(_ msg: String?) {
        let clearText = "clear"
        guard let message = msg else { return }
        if message.prefix(clearText.count) == clearText {
            view?.replace(text: message)
        }
        view?.append(text: message)
    }
}
