//
//  Issue_5.swift
//  JSONDecoder
//
//  Created by 韦烽传 on 2021/9/28.
//

import Foundation

/**
 `JSON`嵌套太多，`class`、`struct`仅需要其中的层次里的一些字段
    方案：`class`或`struct`内，重写`init(from decoder: Decoder) throws`解析方法，实现一个继承`CodingKey`的`class`或`struct`
 */

struct Model_5: Codable {
    
    /**
     `JSON`数据
     */
    static let data =
    """
    {
        "a": {
            "aa": {
                "aaa": 1
            }
        },
        "b": "bb",
        "c": true,
        "d": 1.1
    }
    """.data(using: .utf8)!
    
    var a: Int
    var b: String
    var c: Bool
    var d: Double
    
    struct AnyCodingKey: CodingKey {
        
        var stringValue: String
        
        init(stringValue: String) {
            
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        
        init(intValue: Int) {
            
            self.stringValue = String(intValue)
            self.intValue = intValue
        }
    }
    
    init(from decoder: Decoder) throws {
        
        /// 获取容器
        let container = try decoder.container(keyedBy: AnyCodingKey.self)
        
        /// 获取嵌套容器
        var nestedContainer = try container.nestedContainer(keyedBy: AnyCodingKey.self, forKey: AnyCodingKey(stringValue: "a"))
        nestedContainer = try nestedContainer.nestedContainer(keyedBy: AnyCodingKey.self, forKey: AnyCodingKey(stringValue: "aa"))
        
        /// 获取嵌套容器值
        a = try nestedContainer.decode(Int.self, forKey: AnyCodingKey(stringValue: "aaa"))
        
        /// 获取容器值
        b = try container.decode(String.self, forKey: AnyCodingKey(stringValue: "b"))
        c = try container.decode(Bool.self, forKey: AnyCodingKey(stringValue: "c"))
        d = try container.decode(Double.self, forKey: AnyCodingKey(stringValue: "d"))
    }
}
