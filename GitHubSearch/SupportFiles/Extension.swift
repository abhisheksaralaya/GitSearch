//
//  Extension.swift
//  GitHubSearch
//
//  Created by Apple on 25/11/20.
//

import Foundation
import UIKit

extension NSAttributedString {
    func changeTextColor (string: NSMutableString, stringColor: String, font: CGFloat, fontColor: CGFloat, newLine:Bool) -> NSMutableAttributedString {
        let longestWordRange = (string as NSString).range(of: stringColor)
        if newLine {
            string.append("\n")
        }
        let attributedString = NSMutableAttributedString(string: string as String, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: font)])
        
        attributedString.setAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: fontColor), NSAttributedString.Key.foregroundColor : UIColor.black], range: longestWordRange)
        return attributedString
    }
}

var vSpinner : UIView?
 
extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.bounds.origin.x = (onView.bounds.size.width/2)-25
        spinnerView.bounds.origin.y = (onView.bounds.size.height/2)-25
        spinnerView.bounds.size.height = 50
        spinnerView.bounds.size.width = 50
        spinnerView.layer.cornerRadius = 10
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: UIActivityIndicatorView.Style.large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
            if vSpinner != nil {
                vSpinner?.removeFromSuperview()
                vSpinner = nil
            }
            vSpinner = spinnerView
        }
        
        
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
