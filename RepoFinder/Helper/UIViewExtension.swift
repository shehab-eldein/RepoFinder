//
//  UIViewExtension.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import Foundation
import UIKit

extension UIView {
    func addCornerRadius(_ radius: CGFloat = 4) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    func makeRounded() {
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
    
    func elevate() {
          
           layer.cornerRadius = 10
           layer.shadowColor = UIColor.black.cgColor
           layer.shadowOpacity = 0.9
           layer.shadowOffset = CGSize(width: 0, height: 2)
           layer.shadowRadius = 6
       }
}

extension UIViewController {
    
    func delay(seconds: Double, completion: @escaping ()-> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: completion)
    }
}
