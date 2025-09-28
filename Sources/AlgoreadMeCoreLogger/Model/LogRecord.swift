//
//  LogRecord.swift
//  AlgoreadMeCoreLogger
//
//  Created by @algoreadme on 06/08/25.
//

public struct LogRecord {
    public let module: String
    public let code: String
    public let layer: String
    public let function: String
    public let messageByDev: String
    public let messageBySystem: Any
    public let messageLocalized: String
    public let file: String
    public let line: Int
    public let version: String

    public init(
        module: String,
        code: String,
        layer: String,
        function: String = #function,
        messageByDev: String = "",
        messageBySystem: Any,
        messageLocalized: String = "",
        file: String = #file,
        line: Int = #line,
        version: String
    ) {
        self.module = module
        self.code = code
        self.layer = layer
        self.function = function
        self.messageByDev = messageByDev
        self.messageBySystem = messageBySystem
        self.messageLocalized = messageLocalized
        self.file = file
        self.line = line
        self.version = version
    }

    public var description: String {
        return """
        [\(module)] [\(layer)] [\(version)] -> Log captured in \(function) (line \(line), \(file))
        - Code        : \(code)
        - Message Dev : \(messageByDev)
        - System Msg  : \(messageBySystem)
        - Localized   : \(messageLocalized)
        - Function    : \(function)
        - File        : \(file)
        - Line        : \(line)
        - Version     : \(version)
        """
    }
}
