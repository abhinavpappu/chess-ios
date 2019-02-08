//
//  Pawn.swift
//  Chess
//
//  Created by Abhinav R. Pappu 2019 on 1/11/19.
//  Copyright © 2019 Abhinav Pappu. All rights reserved.
//

import Foundation
import AwesomeEnum

class Pawn: Piece {
    let color: Color
    let text = Awesome.solid.chessPawn
    let direction: Int
    
    required init(_ color: Color) {
        self.color = color
        self.direction = color == Game.userColor ? -1 : 1
    }
    
    func calculateMoves(board: [[Piece?]]) -> [Position] {
        let position = Board.getPiecePosition(board: board, piece: self)! // assuming piece is on the board
        var moves: [Position] = []
        if let forward = Position(x: position.x, y: position.y + direction) {
            moves.append(forward)
        }
        return moves
    }
}
