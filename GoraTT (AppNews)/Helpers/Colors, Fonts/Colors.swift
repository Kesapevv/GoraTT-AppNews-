//
//  Colors.swift
//  GoraTT (AppNews)
//
//  Created by Vadim Voronkov on 13.06.2022.
//

import Foundation
import UIKit

enum Colors {
    case black
    
    var value: UIColor {
        switch self {
        case .black:
            return UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    var cgColor: CGColor {
        return self.value.cgColor
    }
}
