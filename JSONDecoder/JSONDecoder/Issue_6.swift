//
//  Issue_6.swift
//  JSONDecoder
//
//  Created by 韦烽传 on 2021/9/28.
//

import Foundation

/**
 属性需要以其它格式展示
    方案一：添加一个计算属性进行转换
    方案二：添加方法进行转换
    方案三：添加`@propertyWrapper`（属性包装器）进行转换（注意：属性对应字段必须存在）
 */

struct Model_6: Codable {
    
    /**
     `JSON`数据
     */
    static let data =
    """
    {
        "a": "abc",
        "b": "abc",
        "c": "abc",
        "d": null
    }
    """.data(using: .utf8)!
    
    var a: String
    var b: String
    /// 方案三
    @UppercasedString var c: String
    /**
     空值有效
     */
    @UppercasedString var d: String
    /**
     无法处理空字段，会报错误：`The data couldn’t be read because it is missing.`
     */
//    @UppercasedString var e: String
    /**
     无法处理空字段，会报错误：`The data couldn’t be read because it is missing.`
     */
//    @UppercasedStringNil var f: String?
    
    /// 方案一
    var uppercasedA: String { a.uppercased() }
    
    /// 方案二
    func uppercasedB() -> String {
        
        return b.uppercased()
    }
}

/**
 属性包装器
 */
@propertyWrapper struct UppercasedString: Codable {
    
    private var value: String
    
    var wrappedValue: String {
        
        value.uppercased()
    }
    
    init(from decoder: Decoder) throws {
        
        do {
            value = try decoder.singleValueContainer().decode(String.self)
        } catch {
            value = String()
        }
    }
}

/**
 属性包装器
 */
@propertyWrapper struct UppercasedStringNil: Codable {
    
    private var value: String?
    
    var wrappedValue: String? {
        
        (value ?? String()).uppercased()
    }
    
    init(from decoder: Decoder) throws {
        
        do {
            value = try decoder.singleValueContainer().decode(String.self)
        } catch {
            value = String()
        }
    }
}
