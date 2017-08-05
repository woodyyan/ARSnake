//
//  SnakeConfig.swift
//  ARSnake
//
//  Created by Jessie on 2017/8/3.
//  Copyright © 2017年 略懂工作室. All rights reserved.
//

/** Snake configuration: width and helengthight of the ground */
struct SnakeConfig {
    
    static let standard: SnakeConfig = SnakeConfig(width: 20, length: 20)
    
    let width: Int
    let length: Int
}
