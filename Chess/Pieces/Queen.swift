//
//  Queen.swift
//  Chess
//
//  Created by Abhinav R. Pappu 2019 on 1/18/19.
//  Copyright © 2019 Abhinav Pappu. All rights reserved.
//

import Foundation
import AwesomeEnum

class Queen: Piece {
    let color: Color
    let text = Awesome.Solid.chessQueen
    let value = 9
    
    required init(_ color: Color) {
        self.color = color
    }
    
    func calculateMoves(board: [[Piece?]]) -> [Position] {
        let directions: [Direction] = [.north, .east, .south, .west, .northeast, .southeast, .southwest, .northwest]
        return Board.calculateMovesInDirections(board: board, piece: self, directions: directions)
    }
}
