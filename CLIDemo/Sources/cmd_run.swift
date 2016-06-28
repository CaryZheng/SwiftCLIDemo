
struct Run: Command {
	static var id = "run"

	static func execute(args: [String], directory: String) {
        print("Command - run execute success, args = \(args) , directory = \(directory)")
	}
}