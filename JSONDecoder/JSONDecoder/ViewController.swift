//
//  ViewController.swift
//  JSONDecoder
//
//  Created by 韦烽传 on 2021/9/28.
//

/**
 `JSONDecoder`
 
 解决解析问题：
 
 1.`JSON`没有某个字段
    方案：设置属性为可选值`?`，例如`String?`
 
 2.`JSON`没有该字段，属性为必须值，需加上一个默认值（仅基本类型：`String`、`Int`、`Bool`、`Double`、`Float`）
    方案一：扩展`KeyedDecodingContainer`重新实现`decode`（属性是必须值调用）
    方案二：`class`或`struct`内，重写`init(from decoder: Decoder) throws`解析方法
 
 3.`JSON`字段类型可能多个（仅基本类型：`String`、`Int`、`Bool`、`Double`、`Float`）
    方案：扩展`KeyedDecodingContainer`重新实现`decode`（属性是必须值调用）、`decodeIfPresent`（属性是可选值 `?`调用）方法
 
 4.`JSON`字段名称和属性名称不一致
    方案：`class`或`struct`内，重写`enum CodingKeys: String, CodingKey`，`case`名与属性名相同，值与字段名一致
 
 5.`JSON`嵌套太多，`class`、`struct`仅需要其中的层次里的一些字段
    方案：`class`或`struct`内，重写`init(from decoder: Decoder) throws`解析方法，实现一个继承`CodingKey`的`class`或`struct`
 
 6.属性需要以其它格式展示
    方案一：添加一个计算属性进行转换
    方案二：添加方法进行转换
    方案三：添加`@propertyWrapper`（属性包装器）进行转换（注意：属性对应字段必须存在）
 
 7.`Swift5.5`新增`enum`类型解析
    原理：每个`case`即是一个`class`、`struct`，如果`enum`已设置类型，则`case`就为该类型
 
 8.网络返回固定参数，结果参数类型结构多样性
    方案：多样性类型结构参数使用`Decoder?`解码类型接收
 
 
 为方便使用，基本类型设置为必须值，其它类型设置为可选值
 */

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        testIssue_1()
        testIssue_2()
        testIssue_3()
        testIssue_4()
        testIssue_5()
        testIssue_6()
        testIssue_7()
        testIssue_8()
    }
    
    /**
     测试问题1
     `JSON`没有某个字段
     */
    func testIssue_1() {
        
        do {
            let model = try JSONDecoder().decode(Model_1.self, from: Model_1.data)
            print(model)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /**
     测试问题2
     `JSON`没有该字段，属性为必须值，需加上一个默认值（仅基本类型：`String`、`Int`、`Bool`、`Double`、`Float`）
     */
    func testIssue_2() {
        
        do {
            let model = try JSONDecoder().decode(Model_2.self, from: Model_2.data)
            print(model)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /**
     测试问题3
     `JSON`字段类型可能多个（仅基本类型：`String`、`Int`、`Bool`、`Double`、`Float`）
     */
    func testIssue_3() {
        
        do {
            let model = try JSONDecoder().decode(Model_3.self, from: Model_3.data)
            print(model)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /**
     测试问题4
     `JSON`字段名称和属性名称不一致
     */
    func testIssue_4() {
        
        do {
            let model = try JSONDecoder().decode(Model_4.self, from: Model_4.data)
            print(model)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /**
     测试问题5
     `JSON`嵌套太多，`class`、`struct`仅需要其中的层次里的一些字段
     */
    func testIssue_5() {
        
        do {
            let model = try JSONDecoder().decode(Model_5.self, from: Model_5.data)
            print(model)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /**
     测试问题6
     属性需要以其它格式展示
     */
    func testIssue_6() {
        
        do {
            let model = try JSONDecoder().decode(Model_6.self, from: Model_6.data)
            print(model)
            print(model.uppercasedA)
            print(model.uppercasedB())
            print(model.c)
            print(model.d)
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /**
     测试问题7
     `Swift5.5`新增`enum`类型解析
     */
    func testIssue_7() {
        
        do {
            let model = try JSONDecoder().decode(Model_7.self, from: Model_7.data)
            print(model)
        } catch {
            print(error.localizedDescription)
        }
        
        /**
         结构编码（查看数据结构，以便编写测试数据）
         */
        
        let forecast: [Weather] = [
            .sun,
            .wind(speed: 10),
            .sun,
            .rain(amount: 5, chance: 50)
        ]
        
        do {
            let result = try JSONEncoder().encode(forecast)
            let jsonString = String(data: result, encoding: .utf8)!//String(decoding: result, as: UTF8.self)
            print(jsonString)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /**
     测试问题8
     网络返回固定参数，结果参数类型结构多样性
     */
    func testIssue_8() {
        
        /**
         多样结构类型：字典
         */
        do {
            let model = try JSONDecoder().decode(NetworkResponse.self, from: NetworkResponse.data_dict)
            print(model)
            
            if let result = model.result {
                
                let resultModel = try Model_1.init(from: result)
                print(resultModel)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        /**
         多样结构类型：数组
         */
        do {
            let model = try JSONDecoder().decode(NetworkResponse.self, from: NetworkResponse.data_array)
            print(model)
            
            if let result = model.result {
                
                let resultModel = try [Model_1].init(from: result)
                print(resultModel)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        /**
         多样结构类型：基本类型
         */
        do {
            let model = try JSONDecoder().decode(NetworkResponse.self, from: NetworkResponse.data_int)
            print(model)
            
            if let result = model.result {
                
                let resultModel = try Int.init(from: result)
                print(resultModel)
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

