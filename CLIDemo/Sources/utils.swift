#if os(OSX)
    import Darwin
#else
    import Glibc
#endif

func getCommand(id: String, commands: [Command.Type]) -> Command.Type? {
    return commands
        .lazy
        .filter { $0.id == id }
        .first
}

func fail(message: String) {
    print()
    print("Error: \(message)")
}
