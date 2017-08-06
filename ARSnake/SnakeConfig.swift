//
//  SnakeConfig.swift
//  ARSnake
//
//  Created by Jessie on 2017/8/3.
//  Copyright © 2017年 略懂工作室. All rights reserved.
//
import UIKit

// 贪吃蛇的大小配置
struct SnakeConfig {
    
    static let standard: SnakeConfig = SnakeConfig(width: 10, length: 10)
    
    let width: Int
    let length: Int
    let cellWidth:Float = 0.05
    let lingWidth:Float = 0.001
    let groundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
}
