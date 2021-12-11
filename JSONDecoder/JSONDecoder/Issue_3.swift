//
//  Issue_3.swift
//  JSONDecoder
//
//  Created by 韦烽传 on 2021/9/28.
//

import Foundation

/**
 `JSON`字段类型可能多个（仅基本类型：`String`、`Int`、`Bool`、`Double`、`Float`，`Array`必须值转为`[]`，其余做空处理）
    方案：扩展`KeyedDecodingContainer`重新实现`decode`（属性是必须值调用）、`decodeIfPresent`（属性是可选值 `?`调用）方法
 */

struct Model_3: Codable {
    
    /**
     `JSON`数据
     */
    static let data =
    """
    {
        "int_1": 1,
        "int_2": "123",
        "int_3": true,
        "int_4": 1.1,
        "int_5": null,
    
        "string_1": 1,
        "string_2": "123",
        "string_3": true,
        "string_4": 1.1,
        "string_5": null,
    
        "float_1": 1,
        "float_2": "123",
        "float_3": true,
        "float_4": 1.1,
        "float_5": null,
    
        "bool_1": 1,
        "bool_2": "123",
        "bool_3": true,
        "bool_4": 1.1,
        "bool_5": null,
        "bool_6": false,
    
        "double_1": 1,
        "double_2": "123",
        "double_3": true,
        "double_4": 1.1,
        "double_5": null
    }
    """.data(using: .utf8)!
    
    var int_1: Int
    var int_2: Int
    var int_3: Int
    var int_4: Int
    var int_5: Int
    
    var string_1: String
    var string_2: String
    var string_3: String
    var string_4: String
    var string_5: String
    
    var bool_1: Bool
    var bool_2: Bool
    var bool_3: Bool
    var bool_4: Bool
    var bool_5: Bool
    var bool_6: Bool
    
    var float_1: Float
    var float_2: Float
    var float_3: Float
    var float_4: Float
    var float_5: Float

    var double_1: Double
    var double_2: Double
    var double_3: Double
    var double_4: Double
    var double_5: Double
}
