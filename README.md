本篇文章主要介绍 Swift CLI （命令行界面）。

# 准备

Swift Version: 4.0.3

建议使用 **[swiftenv](https://github.com/kylef/swiftenv)** 来管理 Swift 版本。

参考： **[Swift版本管理器 - swiftenv](https://www.swiftmic.com/topic/21/swift%E7%89%88%E6%9C%AC%E7%AE%A1%E7%90%86%E5%99%A8-swiftenv)**

# 开始
主要介绍 command 的设计，本示例中设计了 ```run``` 、 ```help``` 和 ```update``` 三个 command ，分别对应 ```cmd_run.swift``` 、 ```cmd_help.swift``` 和 ```cmd_update.swift``` 。

#### 目录结构
```
.
├── Sources
│   └── main.swift                    // 执行入口
│   └── command.swift                 // 命令协议
│   └── cmd_run.swift                 // run命令
│   └── cmd_help.swift                // help命令
│   └── cmd_update.swift              // update命令
│   └── utils.swift                   // 工具方法
└── Package.swift
```

#### main.swift

```
#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import Foundation

// 版本号
let version = "0.2.0"

print("CLI-Demo \(version)")

// 命令集合
struct MyCLI {
	static let commands: [Command.Type] = {
		var c = [Command.Type]()
		c.append(Help.self)
        c.append(Run.self)
        c.append(Update.self)

		return c
	}()
}

var iterator = CommandLine.arguments.makeIterator()

// 获取路径
guard let directory = iterator.next() else {
    fail(message: "no directory")
    exit(1)
}

// 获取命令
guard let commandID = iterator.next() else {
    print("Usage: CLI-Demo [\(MyCLI.commands.map({$0.id}).joined(separator: "|"))]")
    
    fail(message: "no command")
    exit(1)
}

// 获取命令所对应的 command 类型
guard let command = getCommand(id: commandID, commands: MyCLI.commands) else {
    fail(message: "command \(commandID) doesn't exist")
    exit(1)
}

let arguments = Array(iterator)

// 执行
command.execute(args: arguments, directory: directory)
```

#### command.swift

```
// Command 协议，所有命令均遵从该协议
protocol Command {
    // 命令ID
	static var id: String {get}
    // 执行方法
	static func execute(args: [String], directory: String)
}
```

#### cmd_run.swift
```
struct Run: Command {
	static var id = "run"

	static func execute(args: [String], directory: String) {
        print("Command - run execute success, args = \(args) , directory = \(directory)")
	}
}
```

#### cmd_help.swift
```
struct Help: Command {
	static var id = "help"

	static func execute(args: [String], directory: String) {
        print("Command - help execute success, args = \(args) , directory = \(directory)")
	}
}
```

#### cmd_update.swift
```
struct Update: Command {
	static var id = "update"

	static func execute(args: [String], directory: String) {
        print("Command - update execute success, args = \(args) , directory = \(directory)")
	}
}
```

#### utils.swift
```
#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

// 将用户输入的命令转换为具体的 Command 类型
func getCommand(id: String, commands: [Command.Type]) -> Command.Type? {
    return commands
        .lazy
        .filter { $0.id == id }
        .first
}

// 显示失败信息
func fail(message: String) {
    print()
    print("Error: \(message)")
}
```

# 使用
使用 ``` swift build``` 编译后即可使用。
```
$ swift build
```

#### run命令 （不带参数）
```
$ .build/debug/CLI-Demo run
CLI-Demo 0.2.0
Command - run execute success, args = [] , directory = .build/debug/CLI-Demo
```

#### run命令 （带参数）
```
$ .build/debug/CLI-Demo run a
CLI-Demo 0.2.0
Command - run execute success, args = ["a"] , directory = .build/debug/CLI-Demo
```

其它命令（help 和 update）使用方法类似。

---

完整示例代码：**[https://github.com/CaryZheng/SwiftCLIDemo](https://github.com/CaryZheng/SwiftCLIDemo)**