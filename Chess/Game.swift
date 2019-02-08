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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
        board = Board.getInitialBoard(userColor: userColor)
        Position.setBoardDimensions(board: board)
        
        Board.printBoard(board: board)
        setBoard()
    }
    
    func setBoard() {
        for (i, row) in board.enumerated() {
            for (j, pieceOptional) in row.enumerated() {
                if let piece = pieceOptional {
                    let squareView = boardView.subviews[i].subviews[j]
                    
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

}

