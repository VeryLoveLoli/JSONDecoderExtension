//
//  File.swift
//  
//
//  Created by 韦烽传 on 2021/9/28.
//

import Foundation

/**
 `JSON`没有该字段，属性为必须值，需加上一个默认值（仅基本类型：`String`、`Int`、`Bool`、`Double`、`Float`）
    方案一：扩展`KeyedDecodingContainer`重新实现`decode`（属性是必须值调用）
    方案二：`class`或`struct`内，重写`init(from decoder: Decoder) throws`解析方法
 */

struct Model_2: Codable {
    
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
    var d: Int
    
    /// 方案二：此方法需书写较多内容不建议使用，除非需特定默认值或者非基本类型
    /*
    init(from decoder: Decoder) throws {
        
        /// 获取容器
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        /// 获取容器值
        if let value = try? container.decodeIfPresent(Int.self, forKey: .a) {
            a = value
        }
        else {
            a = 0
        }
        if let value = try? container.decodeIfPresent(String.self, forKey: .b) {
            b = value
        }
        else {
            b = ""
        }
        if let value = try? container.decodeIfPresent(Bool.self, forKey: .c) {
            c = value
        }
        else {
            c = false
        }
        if let value = try? container.decodeIfPresent(Int.self, forKey: .d) {
            d = value
        }
        else {
            d = 0
        }
    }
    */
}
