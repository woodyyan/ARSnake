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
    let cellWidth:Float = 0.1
    let lingWidth:Float = 0.001
    let groundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
    let colors : [UIColor] = [
        UIColor(red:1.00, green:0.23, blue:0.19, alpha:1.0),
        UIColor(red:1.00, green:0.18, blue:0.33, alpha:1.0),
        UIColor(red:1.00, green:0.58, blue:0.00, alpha:1.0),
        UIColor(red:1.00, green:0.80, blue:0.00, alpha:1.0),
        UIColor(red:0.35, green:0.34, blue:0.84, alpha:1.0),
        UIColor(red:0.20, green:0.67, blue:0.86, alpha:1.0),
        UIColor(red:0.56, green:0.56, blue:0.58, alpha:1.0)]
}
