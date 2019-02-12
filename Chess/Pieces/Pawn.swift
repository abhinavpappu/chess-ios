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
    let text = Awesome.Solid.chessPawn
    let direction: Int
    var hasMoved = false
    
    required init(_ color: Color) {
        self.color = color
        self.direction = color == Game.userColor ? -1 : 1
    }
    
    func calculateMoves(board: [[Piece?]]) -> [Position] {
        let position = Board.getPiecePosition(board: board, piece: self)! // assuming piece is on the board
        var moves: [Position] = []
        
        if let forward = Position(x: position.x, y: position.y + direction) {
            if Board.getPieceAt(board: board, position: forward) == nil {
                moves.append(forward)
            }
        }
        
        // need to ensure that pawn has not moved and that moving one space forward is possible
        // before attempting to move 2 spaces forward
        if (!hasMoved && moves.count == 1) {
            if let forward2 = Position(x: position.x, y: position.y + direction * 2) {
                if Board.getPieceAt(board: board, position: forward2) == nil {
                    moves.append(forward2)
                }
            }
        }
        
        if let diagonalRight = Position(x: position.x + 1, y: position.y + direction) {
            if let piece = Board.getPieceAt(board: board, position: diagonalRight) {
                if (piece.color != color) {
                    moves.append(diagonalRight)
                }
            }
        }
        
        if let diagonalLeft = Position(x: position.x - 1, y: position.y + direction) {
            if let piece = Board.getPieceAt(board: board, position: diagonalLeft) {
                if (piece.color != color) {
                    moves.append(diagonalLeft)
                }
            }
        }
        
        return moves
    }
    
    @discardableResult func move(board: inout [[Piece?]], to: Position) -> Bool {
        if (Board.movePiece(board: &board, piece: self, to: to)) {
            hasMoved = true
            return true
        }
        return false
    }
}
