//
//  ImageProcessor.swift
//  SITIENS
//
//  Created by Modibo on 22/05/2025.
//

import Foundation
import UIKit

class ImageProcessor {
    
    static func customImage(img:UIImage, name : String){
        let image = UIImage(named: name)
        image?.draw(in: CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height), blendMode: .normal, alpha: 1)
        
    }
}
