//
//  ViewController.swift
//  LinhKaSetting_Block_v1
//
//  Created by macbook on 10/4/18.
//  Copyright © 2018 Viet. All rights reserved.
//

import UIKit

class ViewController: UIViewController, OptionDelegate {

    @IBOutlet weak var txt_View: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt_View.textColor = UIColor.blackColor()
    }

    // Called from the PssingOptions controller via delegation
    func setColor(color: UIColor) -> Void {
        txt_View.textColor = color
    }

    // Called from the PassingOption controller via NotificationCenter
    func alignment(notification: NSNotification) -> Void {
        if let info = notification.userInfo as? Dictionary<String,Int> {
            if let value = info["Align"] {
                txt_View.textAlignment = NSTextAlignment(rawValue: value)!
                print(value)
            } else {
                print("no value for key \n")
            }
        }
    }
    
    // Singleton
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let option = OptionFont.sharedInstance
        if let size = option.size {
            print("size:\(size)")
            if let name = option.fontName {
                
                if size != Int((txt_View.font?.pointSize)!) {
                    txt_View.font = UIFont(name: name, size: CGFloat(size))
                } else {
                    if let style = option.style {
                        option.size = 14
                        switch style {
                        case "B":
                            txt_View.font = UIFont.boldSystemFontOfSize(CGFloat(size))
                        case "I":
                            txt_View.font = UIFont.italicSystemFontOfSize(CGFloat(size))
                        case "U":
                            let attributedString = NSAttributedString(string: txt_View.text, attributes: [
                                NSFontAttributeName: UIFont(name: ".SFUIText-Regular", size: 14)!,
                                NSUnderlineStyleAttributeName: 1
                                ])
                            txt_View.attributedText = attributedString
                        case "N":
                            let attributedString = NSAttributedString(string: txt_View.text, attributes: [
                                NSFontAttributeName: UIFont(name: ".SFUIText-Regular", size: 14)!,
                                NSUnderlineStyleAttributeName: 0
                                ])
                            txt_View.attributedText = attributedString
                        default:
                            break
                        }
                    }
                    txt_View.textColor = option.color
                }
            }
        }
    }
    
    func setStyle() -> Void {
        print("")
    }
    
    // Delegate
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Options" {
            let destination = segue.destinationViewController as! PassingOptions
            destination.option = OptionFont(size: Int(txt_View.font!.pointSize), fontName: txt_View.font!.fontName, color: txt_View.textColor!, alignment: txt_View.textAlignment.rawValue, style: "N")
            destination.delegate = self
            
            // NotificationCenter: pass data
            NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(alignment), name: "Alignment", object: nil)
            
            // Block
            destination.setStyle({ (style) ->Void in
                print("p1:\(style)")
            })
        } else {
            print("Segue not found.")
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
}

