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
    var color: Color
    var text = Awesome.solid.chessRook
    
    required init(_ color: Color) {
        self.color = color
    }
    
    func calculateMoves(board: [[Piece?]]) -> [Position] {
        let position = Board.getPiecePosition(board: board, piece: self)!
        var moves: [Position] = []
        for i in -7...7 {
            for j in -7...7 {
                // need exclude 0,0
                if let move = Position(x: position.x + i, y: position.y + j) {
                    moves.append(move)
                }
            }
        }
        return moves
    }
}
