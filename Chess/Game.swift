//
//  ViewController.swift
//  Chess
//
//  Created by Abhinav R. Pappu 2019 on 1/9/19.
//  Copyright © 2019 Abhinav Pappu. All rights reserved.
//

import UIKit

class Game: UIViewController {
    @IBOutlet weak var boardView: UIStackView!
    
    static var userColor: Color = .white
    
    let whiteColor = UIColor.init(red: CGFloat(176.0 / 255.0), green: CGFloat(190.0 / 255.0), blue: CGFloat(197.0 / 255.0), alpha: CGFloat(1))
    let blackColor = UIColor.init(red: CGFloat(84.0 / 255.0), green: CGFloat(110.0 / 255.0), blue: CGFloat(122.0 / 255.0), alpha: CGFloat(1))
    
    var board: [[Piece?]] = []
    var isUserTurn = false
    var userSelectedPiece: Piece?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        isUserTurn = Game.userColor == .white
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onBoardTapped(_:))))
        
        var makeSquareWhite = true // begin with white square
        let rows = boardView.arrangedSubviews
        for row in rows {
            for square in (row as! UIStackView).arrangedSubviews {
                square.backgroundColor = makeSquareWhite ? whiteColor : blackColor
                makeSquareWhite = !makeSquareWhite
            }
            makeSquareWhite = !makeSquareWhite
        }
        
        resetBoard()
    }
    
    func resetBoard() {
        board = Board.getInitialBoard(userColor: Game.userColor)
        Position.setBoardDimensions(board: board)
        setBoard()
    }
    
    func setBoard() {
        for (i, row) in board.enumerated() {
            for (j, pieceOptional) in row.enumerated() {
                let squareView = boardView.subviews[i].subviews[j]
                
                // remove any existing subviews
                for subview in squareView.subviews {
                    subview.removeFromSuperview()
                }
                
                if let piece = pieceOptional {
                    let label = UILabel()
                    label.attributedText = piece.iconText
                    label.sizeToFit()
                    label.textAlignment = .center
                    
                    squareView.addSubview(label)
                    
                    label.translatesAutoresizingMaskIntoConstraints = false
                    
                    let constraints = [
                        NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: squareView, attribute: .top, multiplier: 1, constant: 0),
                        NSLayoutConstraint(item: label, attribute: .right, relatedBy: .equal, toItem: squareView, attribute: .right, multiplier: 1, constant: 0),
                        NSLayoutConstraint(item: label, attribute: .bottom, relatedBy: .equal, toItem: squareView, attribute: .bottom, multiplier: 1, constant: 0),
                        NSLayoutConstraint(item: label, attribute: .left, relatedBy: .equal, toItem: squareView, attribute: .left, multiplier: 1, constant: 0),
                    ]
                    
                    NSLayoutConstraint.activate(constraints);
                }
            }
        }
    }
    
    @objc func onBoardTapped(_ sender: UITapGestureRecognizer) {
        if isUserTurn {
            let squareWidth = view.frame.width / 8
            let squareHeight = view.frame.height / 8
            let row = Int(sender.location(in: view).y / squareHeight)
            let col = Int(sender.location(in: view).x / squareWidth)
            let selectedPosition = Position(x: col, y: row)!
        
            if let selectedPiece = userSelectedPiece {
                let moves = selectedPiece.calculateMoves(board: board)
                if let move = moves.first(where: { $0 == selectedPosition }) {
                    selectedPiece.move(board: &board, to: move)
                    setBoard()
                    playComputer()
                }
                userSelectedPiece = nil
            } else {
                if let selectedPiece = Board.getPieceAt(board: board, position: selectedPosition) {
                    if selectedPiece.color == Game.userColor {
                        userSelectedPiece = selectedPiece
                        print(selectedPiece.calculateMoves(board: board))
                    }
                }
            }
        }
    }
    
    func playComputer() {
        isUserTurn = false
        
        var possibleMoves: [(Piece, Position)] = []
        for row in board {
            for square in row {
                if let piece = square {
                    if piece.color == Game.userColor.getOpposingColor() {
                        for move in piece.calculateMoves(board: board) {
                            possibleMoves.append((piece, move))
                        }
                    }
                }
            }
        }
        
        let (selectedPiece, selectedMove) = possibleMoves[Int.random(in: 0..<possibleMoves.count)]
        selectedPiece.move(board: &board, to: selectedMove)
        setBoard()
        
        isUserTurn = true
    }
}
