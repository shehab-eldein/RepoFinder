//
//  Coordinator.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinator: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}

