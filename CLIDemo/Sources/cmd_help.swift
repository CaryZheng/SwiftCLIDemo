
struct Help: Command {
	static var id = "help"

	static func execute(args: [String], directory: String) {
        print("Command - help execute success, args = \(args) , directory = \(directory)")
	}
}