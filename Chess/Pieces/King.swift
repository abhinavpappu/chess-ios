//
//  King.swift
//  Chess
//
//  Created by Abhinav R. Pappu 2019 on 1/18/19.
//  Copyright © 2019 Abhinav Pappu. All rights reserved.
//

import Foundation
import AwesomeEnum

class King: Piece {
    var color: Color
    var text = Awesome.solid.chessKing
    
    required init(_ color: Color) {
        self.color = color
    }
}
