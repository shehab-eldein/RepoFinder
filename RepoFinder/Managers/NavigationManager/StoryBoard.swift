//
//  StoryBoard.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import Foundation
import UIKit

protocol StoryBoard {
    static func instantiate() -> Self
}

extension StoryBoard where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyBoard.instantiateViewController(withIdentifier: id) as! Self
    }
}
