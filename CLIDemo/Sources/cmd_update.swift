
struct Update: Command {
	static var id = "update"

	static func execute(args: [String], directory: String) {
        print("Command - update execute success, args = \(args) , directory = \(directory)")
	}
}