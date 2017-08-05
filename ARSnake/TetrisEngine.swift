//
//  TetrisEngine.swift
//  ARSnake
//
//  Created by Jessie on 2017/8/3.
//  Copyright © 2017年 略懂工作室. All rights reserved.
//

import Foundation
import SceneKit

/** Snake game enigne */
class SnakeEngine {
    
    let config: SnakeConfig
    let ground: SnakeGround
    let scene: SnakeScene
    
    var current: SnakeState
    var timer: Timer?
    var scores = 0
    
    init(_ config: SnakeConfig, _ ground: SnakeGround, _ scene: SnakeScene) {
        self.config = config
        self.ground = ground
        self.scene = scene
        self.current = SnakeState.random(config)
//        self.scene.show(current)
        startTimer()
    }
    
    func rotate() { setState(current.rotate()) }
    
    func left() { setState(current.left()) }
    
    func right() { setState(current.right()) }
    
    func drop() {
        animate(onComplete: addCurrentTetrominoToWell) {
            let initial = current
            while(!ground.hasCollision(current.down())) {
                current = current.down()
            }
            return scene.drop(from: initial, to: current)
        }
    }
    
    private func setState(_ state: SnakeState) {
        if (!ground.hasCollision(state)) {
            self.current = state
            scene.show(state)
        }
    }
    
    private func addCurrentTetrominoToWell() {
        ground.add(current)
        scene.addToWell(current)
        
        let lines = ground.clearFilledLines()
        if (lines.isEmpty) {
            nextTetromino()
        } else {
            animate(onComplete: nextTetromino) {
                let scores = getScores(lines.count)
                self.scores += scores
                return scene.removeLines(lines, scores)
            }
        }
    }
    
    private func nextTetromino() {
//        current = .random(config)
        if (ground.hasCollision(current)) {
            stopTimer()
            scene.showGameOver(scores)
        } else {
            scene.show(current)
        }
    }
    
    private func getScores(_ lineCount: Int) -> Int {
        switch lineCount {
        case 1:
            return 100
        case 2:
            return 300
        case 3:
            return 500
        default:
            return 800
        }
    }
    
    private func animate(onComplete: @escaping () -> Void, block: () -> CFTimeInterval) {
        self.stopTimer()
        Timer.scheduledTimer(withTimeInterval: block(), repeats: false) { _ in
            self.startTimer()
            onComplete()
        }
    }
    
    private func startTimer() {
        self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            let down = self.current.down()
            if (self.ground.hasCollision(down)) {
                self.addCurrentTetrominoToWell()
            } else {
                self.current = down
                self.scene.show(self.current)
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}

