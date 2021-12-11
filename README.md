# JSONDecoderExtension

`JSONDecoderExtension` 解决 `JSONDecoder` 实际的解析问题
 
### 解决解析问题：
 
 1.`JSON`没有某个字段
    方案：设置属性为可选值`?`，例如`String?`
 
 2.`JSON`没有该字段，属性为必须值，需加上一个默认值（仅基本类型：`String`、`Int`、`Bool`、`Double`、`Float`、`Array`）
    方案一：扩展`KeyedDecodingContainer`重新实现`decode`（属性是必须值调用）
    方案二：`class`或`struct`内，重写`init(from decoder: Decoder) throws`解析方法
 
 3.`JSON`字段类型可能多个（仅基本类型：`String`、`Int`、`Bool`、`Double`、`Float`，`Array`必须值转为`[]`，其余做空处理）
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
    方案一：多样性类型结构参数使用`Decoder?`解码类型接收
    方案二：外部传入类型
 
 
 为方便使用，除模型属性外（避免模型包含模型无限循环），其它类型均设置为必须值
