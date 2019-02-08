//
//  Position.swift
//  Chess
//
//  Created by Abhinav R. Pappu 2019 on 2/5/19.
//  Copyright © 2019 Abhinav Pappu. All rights reserved.
//

import Foundation

class Position {
    let x: Int
    let y: Int
    
    static var boardWidth = 8
    static var boardHeight = 8
    
    init?(x: Int, y: Int, width: Int = boardWidth, height: Int = boardHeight) {
        if x < width && x > 0 && y > 0 && y < height {
            self.x = x
            self.y = y
        } else {
            return nil
        }
    }
    
    static func setBoardDimensions(board: [[Piece?]]) {
        boardWidth = board[0].count
        boardHeight = board.count
    }
}
