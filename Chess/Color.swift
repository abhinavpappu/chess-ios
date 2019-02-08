//
//  Color.swift
//  Chess
//
//  Created by Abhinav R. Pappu 2019 on 1/11/19.
//  Copyright © 2019 Abhinav Pappu. All rights reserved.
//

import Foundation
import UIKit

enum Color {
    case white, black
    
    func getColor() -> UIColor {
        switch self {
            case .white:
                return UIColor.init(red: 1, green: 1, blue: 1, alpha: 1)
            case .black:
                return UIColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    func isWhite() -> Bool {
        return self == Color.white
    }
    
    func isBlack() -> Bool {
        return self == Color.black
    }
    
    func getOpposingColor() -> Color {
        return self == Color.white ? Color.black : Color.white
    }
    
    func getColorChar() -> String {
        return self == Color.white ? "w" : "b"
    }
}
