//
//  Board.swift
//  Chess
//
//  Created by Abhinav R. Pappu 2019 on 1/25/19.
//  Copyright © 2019 Abhinav Pappu. All rights reserved.
//

import Foundation

class Board {
    static func getInitialBoard(userColor: Color) -> [[Piece?]] {
        var board: [[Piece?]] = []
        for i in 0..<8 {
            board.append(getInitialRow(row: i, userColor: Color.white))
        }
        return board
    }
    
    static func getInitialRow(row: Int, userColor: Color) -> [Piece?] {
        let mainRow = ["rook", "knight", "bishop", "queen", "king", "bishop", "knight", "rook"]
        let pawnRow = ["pawn", "pawn", "pawn", "pawn", "pawn", "pawn", "pawn", "pawn"]
        let blankRow = ["", "", "", "", "", "", "", ""]
        switch row {
        case 0:
            return getPiecesArray(arr: mainRow, color: userColor.getOpposingColor())
        case 1:
            return getPiecesArray(arr: pawnRow, color: userColor.getOpposingColor())
        case 6:
            return getPiecesArray(arr: pawnRow, color: userColor)
        case 7:
            return getPiecesArray(arr: mainRow, color: userColor)
        default:
            return getPiecesArray(arr: blankRow, color: userColor)
        }
    }
    
    static func getPiecesArray(arr: [String], color: Color) -> [Piece?] {
        return arr.map { getPieceFromString(piece: $0, color: color) }
    }
    
    static func getPieceFromString(piece: String, color: Color) -> Piece? {
        switch piece {
        case "pawn":
            return Pawn(color)
        case "knight":
            return Knight(color)
        case "bishop":
            return Bishop(color)
        case "rook":
            return Rook(color)
        case "queen":
            return Queen(color)
        case "king":
            return King(color)
        default:
            return nil
        }
    }
    
    static func printBoard(board: [[Piece?]]) {
        for row in board {
            print(row.map { $0 == nil ? "  " : $0!.description })
        }
    }
    
    static func getPiecePosition(board: [[Piece?]], piece: Piece) -> Position? {
        for (i, row) in board.enumerated() {
            for (j, pieceOptional) in row.enumerated() {
                if let boardPiece = pieceOptional {
                    if (piece === boardPiece) {
                        return Position(x: j, y: i)
                    }
                }
            }
        }
        return nil
    }
    
    static func getPositionInDirection(board: [[Piece?]], position: Position, direction: Direction, distance: Int) -> Position? {
        switch direction {
        case .north:
            return Position(x: position.x, y: position.y - distance)
        case .east:
            return Position(x: position.x + distance, y: position.y)
        case .south:
            return Position(x: position.x, y: position.y + distance)
        case .west:
            return Position(x: position.x - distance, y: position.y)
        case .northeast:
            return Position(x: position.x + distance, y: position.y - distance)
        case .southeast:
            return Position(x: position.x + distance, y: position.y + distance)
        case .southwest:
            return Position(x: position.x - distance, y: position.y + distance)
        case .northwest:
            return Position(x: position.x - distance, y: position.y - distance)
        }
    }
    
    static func getPieceAt(board: [[Piece?]], position: Position) -> Piece? {
        return board[position.y][position.x]
    }
    
    static func calculateMovesInDirections(board: [[Piece?]], piece: Piece, directions: [Direction], maxDistance: Int = 7) -> [Position] {
        let position = getPiecePosition(board: board, piece: piece)!
        var moves: [Position] = []
        
        var keepGoing: [Direction: Bool] = [:]
        for direction in directions {
            keepGoing[direction] = true
        }
        
        for i in 1...maxDistance {
            for direction in directions {
                if (keepGoing[direction]!) {
                    if let position = getPositionInDirection(board: board, position: position, direction: direction, distance: i) {
                        if let otherPiece = getPieceAt(board: board, position: position) {
                            if piece.color != otherPiece.color {
                                moves.append(position)
                            }
                            keepGoing[direction] = false
                        } else {
                            moves.append(position)
                        }
                    } else {
                        keepGoing[direction] = false
                    }
                }
            }
        }
        
        return moves
    }
    
    // does not check if move is valid
    static func movePiece(board: inout [[Piece?]], piece: Piece, to: Position) -> Bool {
        // make sure piece is on the board first
        if let position = getPiecePosition(board: board, piece: piece) {
            board[to.y][to.x] = piece
            board[position.y][position.x] = nil
            return true
        }
        
        return false
    }
    
    static func getScore(board: [[Piece?]], forColor: Color) -> Int {
        var score = 8 + 2*3 + 2*3 + 2*5 + 9 + 10
        for row in board {
            for square in row {
                if let piece = square {
                    if piece.color == forColor.getOpposingColor() {
                        score -= piece.value
                    }
                }
            }
        }
        return score
    }
    
    static func evaluateBoard(board: [[Piece?]], forColor: Color) {
        
    }
    
    static func getWinner(board: [[Piece?]]) -> Color? {
        var whiteKingDead = true
        var blackKingDead = true
        for row in board {
            for square in row {
                if let piece = square {
                    if piece is King {
                        if (piece.color == .white) { whiteKingDead = false }
                        if (piece.color == .black) { blackKingDead = false }
                    }
                }
            }
        }
        if (whiteKingDead) {
            return .black
        } else if (blackKingDead) {
            return .white
        } else {
            return nil
        }
    }
}
