//
//  PassingOptions.swift
//  LinhKaSetting_Block_v1
//
//  Created by macbook on 10/4/18.
//  Copyright © 2018 Viet. All rights reserved.
//

import UIKit

protocol OptionDelegate {
    func setColor(colorName: UIColor);
}

class PassingOptions: UIViewController {
    
    @IBOutlet weak var currentSize: UITextField!
    @IBOutlet weak var currentFontName: UITextField!
    @IBOutlet weak var currentColor: UILabel!
    @IBOutlet weak var currentAlign: UILabel!
    @IBOutlet weak var currentFontStyle: UILabel!
    
    
    var delegate: OptionDelegate! = nil
    var colorLabelText: String! = nil
    var option: OptionFont!
    var completion: ((style: String) -> Void)?
    
    override func viewDidLoad() {
        currentFontName.text = option.fontName
        currentSize.text = String(option.size!)
        currentColor.backgroundColor = option.color
        var align = ""
        switch option.alignment {
        case 0:
            align = "Lef"
        case 1:
            align = "Cen"
        case 2:
            align = "Rig"
        default:
            break
        }
        currentAlign.text = align
    }
    
    // After the view will disappear
    // Singleton
    override func viewWillDisappear(animated: Bool) {
        let option = OptionFont.sharedInstance
        option.size = Int(currentSize.text!)
        option.fontName = currentFontName.text
        self.completion!(style: currentFontStyle.text!)
        // Style
        option.style = currentFontStyle.text
        option.color = currentColor.backgroundColor
    }
    
    // Delegate
    @IBAction func colorTouchUpInside(sender: UIButton) {
        if let color = sender.backgroundColor {
            currentColor.backgroundColor = color
            delegate.setColor(color)
        }
    }
    
    // NotificationCenter
    @IBAction func alignTouchUpInside(sender: UIButton) {
        print(sender.titleLabel?.text)
        currentAlign.text = sender.titleLabel?.text
        let dic: NSDictionary = ["Align":sender.tag - 100]
        NSNotificationCenter.defaultCenter().postNotificationName("Alignment", object: nil, userInfo: dic as [NSObject: AnyObject])
    }
    
    // Block
    func setStyle(completion: ((style: String) -> Void) ) {
        print("action")
        self.completion = completion
    }
    
    // Font Style
    @IBAction func styleTouchUpInside(sender: UIButton) {
        currentFontStyle.text = sender.currentTitle
    }
    
    
}
