
protocol Command {
	static var id: String {get}

	static func execute(args: [String], directory: String)
}
