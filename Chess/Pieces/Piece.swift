//
//  Piece.swift
//  Chess
//
//  Created by Abhinav R. Pappu 2019 on 1/9/19.
//  Copyright © 2019 Abhinav Pappu. All rights reserved.
//

import Foundation
import UIKit
import AwesomeEnum

protocol Piece: AnyObject {
    var color: Color { get }
    var text: Awesome.Solid { get }
    var value: Int { get }
    
    init(_ color: Color)
    
    func calculateMoves(board: [[Piece?]]) -> [Position]
    @discardableResult func move(board: inout [[Piece?]], to: Position) -> Bool
    
}

extension Piece {
    public var iconText: NSAttributedString {
        return text.asAttributedText(fontSize: 48, color: color.getColor())
    }
    
    public var description: String {
        return color.getColorChar() + text.asAttributedText(fontSize: 12).string
    }
    
    @discardableResult func move(board: inout [[Piece?]], to: Position) -> Bool {
        return Board.movePiece(board: &board, piece: self, to: to)
    }
}
