//
//  UITextView.swift
//  TelnetClient
//
//  Created by Mohammad Farhan on 5/20/19.
//  Copyright © 2019 MohammadFarhan. All rights reserved.
//

import UIKit

extension UITextView {
    
    func scrollToBotom() {
        let range = NSMakeRange(text.utf8.count - 1, 1);
        scrollRangeToVisible(range);
    }
    
}
