#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import Foundation

let version = "0.1.0"

print("CLI-Demo \(version)")

struct MyCLI {
	static let commands: [Command.Type] = {
		var c = [Command.Type]()
		c.append(Help)
        c.append(Run)
        c.append(Update)

		return c
	}()
}

var iterator = Process.arguments.makeIterator()

guard let directory = iterator.next() else {
    fail(message: "no directory")
}

guard let commandID = iterator.next() else {
    print("Usage: CLI-Demo [\(MyCLI.commands.map({$0.id}).joined(separator: "|"))]")
    
    fail(message: "no command")
}

guard let command = getCommand(id: commandID, commands: MyCLI.commands) else {
    fail(message: "command \(commandID) doesn't exist")
}

let arguments = Array(iterator)

command.execute(args: arguments, directory: directory)