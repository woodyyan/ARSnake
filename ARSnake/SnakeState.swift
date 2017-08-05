//
//  SnakeState.swift
//  ARSnake
//
//  Created by Jessie on 2017/8/3.
//  Copyright © 2017年 略懂工作室. All rights reserved.
//

import Foundation

/** Tetris game state: current tetromino and its position in the well */
class SnakeState {
    
    static func random(_ config: SnakeConfig) -> SnakeState {
//        return SnakeState(random(OneSidedTetromino.all.count), random(4), config.width / 2, config.height)
        return SnakeState.init(0, 0, 0, 0)
    }
    
    let index: Int
    let rotation: Int
    let x: Int
    let y: Int
    
    private init(_ index: Int, _ rotation: Int, _ x: Int, _ y: Int) {
        self.index = index
        self.rotation = rotation
        self.x = x
        self.y = y
    }
    
//    func tetromino() -> FixedTetromino { return OneSidedTetromino.all[index].fixed[rotation] }
    
    func rotate() -> SnakeState { return SnakeState(index, (rotation + 1) % 4, x, y) }
    
    func left() -> SnakeState { return SnakeState(index, rotation, x - 1, y) }
    
    func right() -> SnakeState { return SnakeState(index, rotation, x + 1, y) }
    
    func down() -> SnakeState { return SnakeState(index, rotation, x, y - 1) }
    
    private static func random(_ max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max)))
    }
}

