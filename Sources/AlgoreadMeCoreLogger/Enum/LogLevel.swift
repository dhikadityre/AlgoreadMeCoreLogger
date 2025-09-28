//
//  LogLevel.swift
//  AlgoreadMeCoreLogger
//
//  Created by @algoreadme on 06/08/25.
//

import OSLog

public enum LogLevel: String {
    case debug   = "DEBUG"
    case info    = "INFO"
    case notice  = "NOTICE"
    case warning = "WARNING"
    case error   = "ERROR"
    case critical = "CRITICAL"
    case fault   = "FAULT"

    public func defaultEmoji() -> String {
        switch self {
        case .debug: return "🐛"
        case .info: return "ℹ️"
        case .notice: return "📌"
        case .warning: return "⚠️"
        case .error: return "❌"
        case .critical: return "🔥"
        case .fault: return "💥"
        }
    }

    public var priority: Int {
        switch self {
        case .debug: return 1
        case .info: return 2
        case .notice: return 3
        case .warning: return 4
        case .error: return 5
        case .critical: return 6
        case .fault: return 7
        }
    }

    public var osLogType: OSLogType {
        switch self {
        case .debug: return .debug
        case .info: return .info
        case .notice: return .default
        case .warning: return .default
        case .error: return .error
        case .critical: return .fault
        case .fault: return .fault
        }
    }
}
