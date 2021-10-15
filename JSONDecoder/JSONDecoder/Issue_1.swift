//
//  File.swift
//  
//
//  Created by 韦烽传 on 2021/9/28.
//

import Foundation

/**
 `JSON`没有某个字段
    方案：设置属性为可选值`?`，例如`String?`
 */

struct Model_1: Codable {
    
    /**
     `JSON`数据
     */
    static let data =
    """
    {
        "a": 1,
        "b": "bb",
        "c": true
    }
    """.data(using: .utf8)!
    
    var a: Int
    var b: String
    var c: Bool
    var d: Int?
}
