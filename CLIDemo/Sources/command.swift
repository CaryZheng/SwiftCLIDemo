// Command 协议，所有命令均遵从该协议
protocol Command {
    // 命令ID
	static var id: String {get}
    // 执行方法
	static func execute(args: [String], directory: String)
}
