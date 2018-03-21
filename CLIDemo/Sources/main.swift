#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

import Foundation

let version = "0.2.0"

print("CLI-Demo \(version)")

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

guard let directory = iterator.next() else {
    fail(message: "no directory")
    exit(1)
}

guard let commandID = iterator.next() else {
    print("Usage: CLI-Demo [\(MyCLI.commands.map({$0.id}).joined(separator: "|"))]")
    
    fail(message: "no command")
    exit(1)
}

guard let command = getCommand(id: commandID, commands: MyCLI.commands) else {
    fail(message: "command \(commandID) doesn't exist")
    exit(1)
}

let arguments = Array(iterator)

command.execute(args: arguments, directory: directory)
