//
//  Issue_4.swift
//  JSONDecoder
//
//  Created by 韦烽传 on 2021/9/28.
//

import Foundation

/**
 `JSON`字段名称和属性名称不一致
    方案：`class`或`struct`内，重写`enum CodingKeys: String, CodingKey`，`case`名与属性名相同，值与字段名一致
 */

struct Model_4: Codable {
    
    /**
     `JSON`数据
     */
    static let data =
    """
    {
        "a_a": 1,
        "xx": "bb",
        "c": true,
        "d": 1.1
    }
    """.data(using: .utf8)!
    
    var a: Int
    var b: String
    var c: Bool
    var d: Double
    
    enum CodingKeys: String, CodingKey {
        
        case a = "a_a"
        case b = "xx"
        case c
        case d
    }
}
