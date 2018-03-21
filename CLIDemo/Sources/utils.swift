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
