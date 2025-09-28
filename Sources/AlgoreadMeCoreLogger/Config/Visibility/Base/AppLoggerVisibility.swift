//
//  AppLoggerVisibility.swift
//  AlgoreadMeCoreLogger
//
//  Created by @algoreadme on 07/08/25.
//

public protocol AppLoggerVisibility {
    var isLoggingEnabled: Bool { get }
    
    /// minimumLogLevel for production (.error, .critical, .fault)
    var minimumLogLevel: LogLevel { get }
}
