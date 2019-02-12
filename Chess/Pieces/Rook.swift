//
//  Rook.swift
//  Chess
//
//  Created by Abhinav R. Pappu 2019 on 1/18/19.
//  Copyright © 2019 Abhinav Pappu. All rights reserved.
//

import Foundation
import AwesomeEnum

class Rook: Piece {
    let color: Color
    let text = Awesome.Solid.chessRook
    let value = 5
    
    required init(_ color: Color) {
        self.color = color
    }
    
    func calculateMoves(board: [[Piece?]]) -> [Position] {
        let directions: [Direction] = [.north, .east, .south, .west]
        return Board.calculateMovesInDirections(board: board, piece: self, directions: directions)
    }
}
