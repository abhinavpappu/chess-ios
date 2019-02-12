//
//  Knight.swift
//  Chess
//
//  Created by Abhinav R. Pappu 2019 on 1/18/19.
//  Copyright © 2019 Abhinav Pappu. All rights reserved.
//

import Foundation
import AwesomeEnum

class Knight: Piece {
    var color: Color
    var text = Awesome.Solid.chessKnight
    
    required init(_ color: Color) {
        self.color = color
    }
    
    func calculateMoves(board: [[Piece?]]) -> [Position] {
        let position = Board.getPiecePosition(board: board, piece: self)! // assuming piece is on the board
        
        let moveDistances = [
            (1, 2),
            (1, -2),
            (-1, 2),
            (-1, -2),
            (2, 1),
            (2, -1),
            (-2, 1),
            (-2, -1)
        ]
        
        var moves: [Position] = []
        for (dx, dy) in moveDistances {
            if let move = Position(x: position.x + dx, y: position.y + dy) {
                if let piece = Board.getPieceAt(board: board, position: move) {
                    if (piece.color != color) {
                        moves.append(move)
                    }
                } else {
                    moves.append(move)
                }
            }
        }
        
        return moves
    }
}
