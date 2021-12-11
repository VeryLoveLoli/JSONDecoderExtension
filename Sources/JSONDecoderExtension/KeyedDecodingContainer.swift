//
//  KeyedDecodingContainer.swift
//  
//
//  Created by 韦烽传 on 2021/10/15.
//

import Foundation

/**
 解码容器解码实现
 
 `init(from decoder: Decoder) throws`默认会调用`decode(_,forkey:)`、`decodeIfPresent(_,forkey:)`方法
 重写`init(from decoder: Decoder) throws`后需手动调用解码方法
 
 解决字段类型不正确、无字段引起的崩溃，返回类型初始化值或`nil`
 
 以下重写方法（基本类型、数组）
 `decode(_,forkey:)` `null`、无字段、字段类型不正确时提供一个`type.init()`默认值
 `decodeIfPresent(_,forkey:)`值是其它基本类型值时，进行转换
 
 其余类型（字典）
 字典`null`、无字段、字段类型不正确 返回`nil`
 */
public extension KeyedDecodingContainer {
    
    // MARK: - 必须值调用
    
    func decode(_ type: Bool.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Bool {
        
        if let value = try? decodeIfPresent(type, forKey: key) { return value }
        
        return type.init()
    }
    
    func decode(_ type: String.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> String {
        
        if let value = try? decodeIfPresent(type, forKey: key) { return value }
        
        return type.init()
    }
    
    func decode(_ type: Double.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Double {
        
        if let value = try? decodeIfPresent(type, forKey: key) { return value }
        
        return type.init()
    }
    
    func decode(_ type: Float.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Float {
        
        if let value = try? decodeIfPresent(type, forKey: key) { return value }
        
        return type.init()
    }
    
    func decode(_ type: Int.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int {
        
        if let value = try? decodeIfPresent(type, forKey: key) { return value }
        
        return type.init()
    }
    
    func decode(_ type: Int8.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int8 {
        
        if let value = try? decodeIfPresent(type, forKey: key) { return value }
        
        return type.init()
    }
    
    func decode(_ type: Int16.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int16 {
        
        if let value = try? decodeIfPresent(type, forKey: key) { return value }
        
        return type.init()
    }
    
    func decode(_ type: Int32.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int32 {
        
        if let value = try? decodeIfPresent(type, forKey: key) { return value }
        
        return type.init()
    }
    
    func decode(_ type: Int64.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int64 {
        
        if let value = try? decodeIfPresent(type, forKey: key) { return value }
        
        return type.init()
    }
    
    func decode(_ type: UInt.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> UInt {
        
        if let value = try? decodeIfPresent(type, forKey: key) { return value }
        
        return type.init()
    }
    
    func decode(_ type: UInt8.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> UInt8 {
        
        if let value = try? decodeIfPresent(type, forKey: key) { return value }
        
        return type.init()
    }
    
    func decode(_ type: UInt16.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> UInt16 {
        
        if let value = try? decodeIfPresent(type, forKey: key) { return value }
        
        return type.init()
    }
    
    func decode(_ type: UInt32.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> UInt32 {
        
        if let value = try? decodeIfPresent(type, forKey: key) { return value }
        
        return type.init()
    }
    
    func decode(_ type: UInt64.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> UInt64 {
        
        if let value = try? decodeIfPresent(type, forKey: key) { return value }
        
        return type.init()
    }
    
    /*
     字典类型无需重新设置默认值，避免必须值无限嵌套
    */
    func decode<T>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> T where T : Decodable {
        
        if let value = try? decodeIfPresent(type, forKey: key) { return value }
        
        if let data = "[]".data(using: .utf8), let value = try? JSONDecoder().decode(type, from: data) {
            
            return value
        }
        
        let decoder = try superDecoder(forKey: key)
        let container = try decoder.singleValueContainer()
        
        return try container.decode(type)
    }
    
    // MARK: - 可选值调用`?`
    
    func decodeIfPresent(_ type: Bool.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Bool? {
        
        guard let decoder = try? superDecoder(forKey: key) else { return nil }
        guard let container = try? decoder.singleValueContainer() else { return nil }
        
        if let value = try? container.decode(type) { return value }
        
        if let value = try? container.decode(String.self) { return value != "" && value != "0" && value != "false" }
        if let value = try? container.decode(Double.self) { return value != 0 }
        if let value = try? container.decode(Float.self) { return value != 0 }
        if let value = try? container.decode(Int.self) { return value != 0 }
        
        return nil
    }
    
    func decodeIfPresent(_ type: String.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> String? {
        
        guard let decoder = try? superDecoder(forKey: key) else { return nil }
        guard let container = try? decoder.singleValueContainer() else { return nil }
        
        if let value = try? container.decode(type) { return value }
        
        if let value = try? container.decode(Bool.self) { return value.description }
        if let value = try? container.decode(Int.self) { return value.description }
        if let value = try? container.decode(Double.self) { return value.description }
        if let value = try? container.decode(Float.self) { return value.description }
        
        return nil
    }
    
    func decodeIfPresent(_ type: Double.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Double? {
        
        guard let decoder = try? superDecoder(forKey: key) else { return nil }
        guard let container = try? decoder.singleValueContainer() else { return nil }
        
        if let value = try? container.decode(type) { return value }
        
        if let value = try? container.decode(Bool.self) { return value ? 1 : 0 }
        if let value = try? container.decode(String.self) { return Double(value) }
        if let value = try? container.decode(Float.self) { return Double(value) }
        if let value = try? container.decode(Int.self) { return Double(value) }
        
        return nil
    }
    
    func decodeIfPresent(_ type: Float.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Float? {
        
        guard let decoder = try? superDecoder(forKey: key) else { return nil }
        guard let container = try? decoder.singleValueContainer() else { return nil }
        
        if let value = try? container.decode(type) { return value }
        
        if let value = try? container.decode(Bool.self) { return value ? 1 : 0 }
        if let value = try? container.decode(String.self) { return Float(value) }
        if let value = try? container.decode(Double.self) { return Float(value) }
        if let value = try? container.decode(Int.self) { return Float(value) }
        
        return nil
    }
    
    func decodeIfPresent(_ type: Int.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int? {
        
        guard let decoder = try? superDecoder(forKey: key) else { return nil }
        guard let container = try? decoder.singleValueContainer() else { return nil }
        
        if let value = try? container.decode(type) { return value }
        
        if let value = try? container.decode(Bool.self) { return value ? 1 : 0 }
        if let value = try? container.decode(String.self) { return Int(value) }
        if let value = try? container.decode(Double.self) { return Int(value) }
        if let value = try? container.decode(Float.self) { return Int(value) }
        
        return nil
    }
    
    func decodeIfPresent(_ type: Int8.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int8? {
        
        guard let decoder = try? superDecoder(forKey: key) else { return nil }
        guard let container = try? decoder.singleValueContainer() else { return nil }
        
        if let value = try? container.decode(type) { return value }
        
        if let value = try? container.decode(Bool.self) { return value ? 1 : 0 }
        
        var int64: Int64?
        
        if let value = try? container.decode(Int.self) { int64 = Int64(value) }
        if let value = try? container.decode(String.self) { int64 = Int64(value) }
        if let value = try? container.decode(Double.self) { int64 = Int64(value) }
        if let value = try? container.decode(Float.self) { int64 = Int64(value) }
        
        if let int64 = int64 { return Int8((int64 << 56) >> 56)}
        
        return nil
    }
    
    func decodeIfPresent(_ type: Int16.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int16? {
        
        guard let decoder = try? superDecoder(forKey: key) else { return nil }
        guard let container = try? decoder.singleValueContainer() else { return nil }
        
        if let value = try? container.decode(type) { return value }
        
        if let value = try? container.decode(Bool.self) { return value ? 1 : 0 }
        
        var int64: Int64?
        
        if let value = try? container.decode(Int.self) { int64 = Int64(value) }
        if let value = try? container.decode(String.self) { int64 = Int64(value) }
        if let value = try? container.decode(Double.self) { int64 = Int64(value) }
        if let value = try? container.decode(Float.self) { int64 = Int64(value) }
        
        if let int64 = int64 { return Int16((int64 << 48) >> 48)}
        
        return nil
    }
    
    func decodeIfPresent(_ type: Int32.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int32? {
        
        guard let decoder = try? superDecoder(forKey: key) else { return nil }
        guard let container = try? decoder.singleValueContainer() else { return nil }
        
        if let value = try? container.decode(type) { return value }
        
        if let value = try? container.decode(Bool.self) { return value ? 1 : 0 }
        
        var int64: Int64?
        
        if let value = try? container.decode(Int.self) { int64 = Int64(value) }
        if let value = try? container.decode(String.self) { int64 = Int64(value) }
        if let value = try? container.decode(Double.self) { int64 = Int64(value) }
        if let value = try? container.decode(Float.self) { int64 = Int64(value) }
        
        if let int64 = int64 { return Int32((int64 & 32) >> 32)}
        
        return nil
    }
    
    func decodeIfPresent(_ type: Int64.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> Int64? {
        
        guard let decoder = try? superDecoder(forKey: key) else { return nil }
        guard let container = try? decoder.singleValueContainer() else { return nil }
        
        if let value = try? container.decode(type) { return value }
        
        if let value = try? container.decode(Bool.self) { return value ? 1 : 0 }
        if let value = try? container.decode(Int.self) { return Int64(value) }
        if let value = try? container.decode(String.self) { return Int64(value) }
        if let value = try? container.decode(Double.self) { return Int64(value) }
        if let value = try? container.decode(Float.self) { return Int64(value) }
        
        return nil
    }
    
    func decodeIfPresent(_ type: UInt.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> UInt? {
        
        guard let decoder = try? superDecoder(forKey: key) else { return nil }
        guard let container = try? decoder.singleValueContainer() else { return nil }
        
        if let value = try? container.decode(type) { return value }
        
        if let value = try? container.decode(Bool.self) { return value ? 1 : 0 }
        
        var double: Double?
        
        if let value = try? container.decode(Int.self) { double = Double(value) }
        if let value = try? container.decode(String.self) { double = Double(value) }
        if let value = try? container.decode(Double.self) { double = Double(value) }
        if let value = try? container.decode(Float.self) { double = Double(value) }
        
        if let double = double { return double <= -1 ? (UInt.max - UInt(-Int(double)) + 1) : (double < 0 ? 0 : UInt(double)) }
        
        return nil
    }
    
    func decodeIfPresent(_ type: UInt8.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> UInt8? {
        
        guard let decoder = try? superDecoder(forKey: key) else { return nil }
        guard let container = try? decoder.singleValueContainer() else { return nil }
        
        if let value = try? container.decode(type) { return value }
        
        if let value = try? container.decode(Bool.self) { return value ? 1 : 0 }
        
        var double: Double?
        
        if let value = try? container.decode(Int.self) { double = Double(value) }
        if let value = try? container.decode(String.self) { double = Double(value) }
        if let value = try? container.decode(Double.self) { double = Double(value) }
        if let value = try? container.decode(Float.self) { double = Double(value) }
        
        if let double = double {
            
            let unit64 = double <= -1 ? (UInt64.max - UInt64(-Int(double)) + 1) : (double < 0 ? 0 : UInt64(double))
            
            return UInt8(unit64 % (UInt64(UInt8.max) + 1))
        }
        
        return nil
    }
    
    func decodeIfPresent(_ type: UInt16.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> UInt16? {
        
        guard let decoder = try? superDecoder(forKey: key) else { return nil }
        guard let container = try? decoder.singleValueContainer() else { return nil }
        
        if let value = try? container.decode(type) { return value }
        
        if let value = try? container.decode(Bool.self) { return value ? 1 : 0 }
        
        var double: Double?
        
        if let value = try? container.decode(Int.self) { double = Double(value) }
        if let value = try? container.decode(String.self) { double = Double(value) }
        if let value = try? container.decode(Double.self) { double = Double(value) }
        if let value = try? container.decode(Float.self) { double = Double(value) }
        
        if let double = double {
            
            let unit64 = double <= -1 ? (UInt64.max - UInt64(-Int(double)) + 1) : (double < 0 ? 0 : UInt64(double))
            
            return UInt16(unit64 % (UInt64(UInt16.max) + 1))
        }
        
        return nil
    }
    
    func decodeIfPresent(_ type: UInt32.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> UInt32? {
        
        guard let decoder = try? superDecoder(forKey: key) else { return nil }
        guard let container = try? decoder.singleValueContainer() else { return nil }
        
        if let value = try? container.decode(type) { return value }
        
        if let value = try? container.decode(Bool.self) { return value ? 1 : 0 }
        
        var double: Double?
        
        if let value = try? container.decode(Int.self) { double = Double(value) }
        if let value = try? container.decode(String.self) { double = Double(value) }
        if let value = try? container.decode(Double.self) { double = Double(value) }
        if let value = try? container.decode(Float.self) { double = Double(value) }
        
        if let double = double {
            
            let unit64 = double <= -1 ? (UInt64.max - UInt64(-Int(double)) + 1) : (double < 0 ? 0 : UInt64(double))
            
            return UInt32(unit64 % (UInt64(UInt32.max) + 1))
        }
        
        return nil
    }
    
    func decodeIfPresent(_ type: UInt64.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> UInt64? {
        
        guard let decoder = try? superDecoder(forKey: key) else { return nil }
        guard let container = try? decoder.singleValueContainer() else { return nil }
        
        if let value = try? container.decode(type) { return value }
        
        if let value = try? container.decode(Bool.self) { return value ? 1 : 0 }
        
        var double: Double?
        
        if let value = try? container.decode(Int.self) { double = Double(value) }
        if let value = try? container.decode(String.self) { double = Double(value) }
        if let value = try? container.decode(Double.self) { double = Double(value) }
        if let value = try? container.decode(Float.self) { double = Double(value) }
        
        if let double = double { return double <= -1 ? (UInt64.max - UInt64(-Int(double)) + 1) : (double < 0 ? 0 : UInt64(double)) }
        
        return nil
    }
    
    func decodeIfPresent<T>(_ type: T.Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> T? where T : Decodable {
        
        guard let decoder = try? superDecoder(forKey: key) else { return nil }
        guard let container = try? decoder.singleValueContainer() else { return nil }
        
        if let value = try? container.decode(type) { return value }
        
        return nil
    }
}
