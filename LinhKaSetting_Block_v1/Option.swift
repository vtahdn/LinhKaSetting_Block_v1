//
//  Option.swift
//  LinhKaSetting_Block_v1
//
//  Created by macbook on 10/4/18.
//  Copyright © 2018 Viet. All rights reserved.
//

import UIKit
// Class for font attributes
class OptionFont {
    
    static let sharedInstance = OptionFont()
    
    var size: Int?
    var fontName: String?
    var color: UIColor?
    var alignment: Int!
    var style: String?
    
    private init() {
        
    }
    
    init(size: Int, fontName: String, color: UIColor, alignment: Int, style: String) {
        self.size = size
        self.fontName = fontName
        self.color = color
        self.alignment = alignment
        self.style = style
    }
    
}
