//
//  ViewController.swift
//
//  Created by Mohammad Farhan on 5/16/19.
//  Copyright © 2019 MohammadFarhan. All rights reserved.
//

import UIKit

final class TelnetViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var textView: UITextView!
    @IBOutlet private weak var textField: UITextField!
    
    // MARK: - Properties
    
    var presenter: TelnetPresenter!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
}

// MARK: - TextView Helper

extension TelnetViewController {
    
    func changeContentInsetOfTextView() {
        var inset: UIEdgeInsets = .zero
        inset.top = textView.bounds.size.height - textView.contentSize.height
        textView.contentInset = inset
        textView.scrollToBotom()
    }
    
    func append(toTextView text: String?) {
        textView.text = "\(textView.text ?? "")\(text ?? "")"
    }
}

// MARK: - Telnet Presentation

extension TelnetViewController: TelnetPresentation {
    
    func configure() {
        textField.isHidden = true
        textField.delegate = self
        textField.tintColor = .clear
    }
    
    func clearText() {
        textField.text = nil
    }
    
    func drop() {
        DispatchQueue.main.async(execute: {
            self.textView.text.removeLast()
        })
    }
    
    func append(text: String) {
        DispatchQueue.main.async(execute: {
            self.textField.becomeFirstResponder()
            self.append(toTextView: text)
            self.changeContentInsetOfTextView()
        })
    }
    
    func replace(text: String) {
        DispatchQueue.main.async(execute: {
            self.textView.text = text
        })
    }
    
    func setTextFieldEnabled(isEnabled: Bool) {
        DispatchQueue.main.async(execute: {
            self.textField.isEnabled = isEnabled
            self.textField.resignFirstResponder()
        })
    }
}


extension TelnetViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
        ) -> Bool {
        return presenter.shouldChangeTextIn(string)
    }
}
