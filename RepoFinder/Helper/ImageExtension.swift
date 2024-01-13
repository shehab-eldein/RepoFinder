//
//  ImageExtension.swift
//  RepoFinder
//
//  Created by shehab ahmed on 11/01/2024.
//

import Foundation
import UIKit

extension UIImageView {
    func fromURL(url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),let image = UIImage(data: data) else {return }
           
            DispatchQueue.main.async {
                
               self?.image = image
            }

        }
    }
}
