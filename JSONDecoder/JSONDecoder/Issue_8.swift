//
//  Issue_8.swift
//  JSONDecoder
//
//  Created by 韦烽传 on 2021/9/29.
//

import Foundation

/**
 网络返回固定参数，结果参数类型结构多样性
    方案一：多样性类型结构参数使用`Decoder?`解码类型接收
    方案二：外部传入类型
 */

/**
 网络响应（方案一）
 */
struct NetworkResponse: Decodable {
    
    static let data_dict =
    """
    {
        "status": 200,
        "message": "成功",
        "result": {"a": 1}
    }
    """.data(using: .utf8)!
    
    static let data_array =
    """
    {
        "status": 200,
        "message": "成功",
        "result": [{"a": 1}, {"b": "123"}]
    }
    """.data(using: .utf8)!
    
    static let data_int =
    """
    {
        "status": 200,
        "message": "成功",
        "result": 1
    }
    """.data(using: .utf8)!
    
    /// 状态
    var status: Int
    /// 消息
    var message: String
    /// 结果（`Decoder`只符合`Decodable`协议，所以`NetworkResponse`只能继承`Decodable`）
    var result: Decoder?
    
    /**
     `Codable`协议才默认有`CodingKeys`枚举，所以需要重新实现
     */
    enum CodingKeys: String, CodingKey {
        
        case status
        case message
        case result
    }
    
    /**
     从解码器初始化
     */
    init(from decoder: Decoder) throws {
        
        /// 获取容器
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        /// 获取容器值
        status = try container.decode(Int.self, forKey: .status)
        message = try container.decode(String.self, forKey: .message)
        
        /// 获取参数值解码器
        result = try? container.superDecoder(forKey: .result)
    }
}

/**
 网络响应结果（方案二）
 */
struct NetworkResponseResult<Result>: Codable where Result: Codable {
    
    /// 状态
    var status: Int
    /// 消息
    var message: String
    /// 结果
    var result: Result?
}
