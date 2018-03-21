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
