//
//  Issue_7.swift
//  JSONDecoder
//
//  Created by 韦烽传 on 2021/9/29.
//

import Foundation

/**
 `Swift5.5`新增`enum`类型解析
    原理：每个`case`即是一个`class`、`struct`，如果`enum`已设置类型，则`case`就为该类型
 */

struct Model_7: Codable {
    
    /**
     `JSON`数据
     */
    static let data =
    """
    {
        "a": {"sun": {}},
        "b": {"wind": {"speed": 10}},
        "c": {"rain": {"amount": 5, "chance": 50}},
        "d": 0,
        "e": 1,
        "f": 2,
        "k": 3
    }
    """.data(using: .utf8)!
    
    var a: Weather
    var b: Weather
    var c: Weather
    
    var d: Status
    var e: Status
    var f: Status
    
    /**
     空字段或空值需设置为`?`可选值，否则会报错误：`The data couldn’t be read because it is missing.`
     */
    var i: Weather?
    /**
     空字段或空值需设置为`?`可选值，否则会报错误：`The data couldn’t be read because it is missing.`
     */
    var j: Status?
    
    /**
     字段值不在范围内会解析失败：`The data couldn’t be read because it isn’t in the correct format.`
     */
//    var k: Status?
}

/**
 天气
 */
enum Weather: Codable {
    
    /// 太阳
    case sun
    /// 风
    case wind(speed: Int)
    /// 雨
    case rain(amount: Int, chance: Int)
}

/**
 状态
 */
enum Status: Int, Codable {
    
    /// 未开始
    case none = 0
    /// 开始
    case start = 1
    /// 结束
    case end = 2
}
