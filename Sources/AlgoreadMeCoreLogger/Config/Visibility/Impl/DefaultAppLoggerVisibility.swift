//
//  DefaultAppLoggerVisibility.swift
//  AlgoreadMeCoreLogger
//
//  Created by @algoreadme on 07/08/25.
//

public class DefaultAppLoggerVisibility: AppLoggerVisibility {
    public var isLoggingEnabled: Bool { true }
    public var minimumLogLevel: LogLevel { .debug }
    
    public init() {}
}
