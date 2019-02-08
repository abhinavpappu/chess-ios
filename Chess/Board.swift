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
    }
}
