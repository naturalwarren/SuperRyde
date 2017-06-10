//
//  WhereToTextField.swift
//  SuperRyde
//
//  Created by Warren Smith on 6/10/17.
//  Copyright © 2017 Warren Smith. All rights reserved.
//

import UIKit
import Foundation

// A wrapper around UITextField that preconfigures a UITextField as a "Where to?" dialog. 
class DestinationView {

    let textField = UITextField()

    init() {
        textField.text = "Where to?"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.backgroundColor = UIColor.gray
        textField.spellCheckingType = .no
    }
}
