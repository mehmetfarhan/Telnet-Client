//
//  TelnetGatway.swift
//  TelnetClient
//
//  Created by Mohammad Farhan on 5/19/19.
//  Copyright © 2019 MohammadFarhan. All rights reserved.
//

import UIKit

// MARK: - Gateway

protocol TelnetGateway {
    func write(command: String)
    func connect(toHost: String)
}

protocol TelnetSessionDelegate {
    func didReceiveMessage(_ msg: String?)
    func shouldEcho(_ echo: Bool)
}

// MARK: - Gateway Implementation

class TelnetGatewayImplementation: NSObject {
    private var client: TelnetClient?
    var sessionDelegate: TelnetSessionDelegate?
}

// MARK: - Telnet Gateway Implementation

private extension TelnetGatewayImplementation {
    func configureSession() {
        client = TelnetClient()
        client?.delegate = self
    }
}

// MARK: - Telnet Gateway

extension TelnetGatewayImplementation: TelnetGateway {
    func write(command: String) {
        client?.writeMessage(command)
    }
    
    func connect(toHost: String) {
        configureSession()
        let hostEntry = HostEntry()
        hostEntry.host = toHost
        hostEntry.port = "23"
        client?.setup(hostEntry)
    }
    
}

// MARK: - Telnet Delegate

extension TelnetGatewayImplementation: TelnetDelegate {
    func didReceiveMessage(_ msg: String!) {
        sessionDelegate?.didReceiveMessage(msg)
    }
    func shouldEcho(_ echo: Bool) {
        sessionDelegate?.shouldEcho(echo)
    }
}



