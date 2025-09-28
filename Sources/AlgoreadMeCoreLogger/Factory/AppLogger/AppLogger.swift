//
//  AppLogger.swift
//  AlgoreadMeCoreLogger
//
//  Created by @algoreadme on 06/08/25.
//

import Foundation
import os

/// A configurable logging utility for structured and filtered application logging.
///
/// `AppLogger` provides:
/// - Configurable logging subsystems and categories (`AppLoggerConfiguration`)
/// - Log visibility and level filtering (`AppLoggerVisibility`)
/// - Support for both structured (`LogRecord`) and free-form logging
/// - Integration with Apple's `os.Logger` (iOS 14+) and `os_log` (iOS 13 and below)
///
/// ## Overview
/// The logger supports multiple log levels (`LogLevel`) such as `.debug`, `.info`, `.warning`, `.error`, and more.
/// It ensures only logs that meet the configured minimum level will be recorded, based on the provided
/// `AppLoggerVisibility` settings.
///
/// ## Example
/// ```swift
/// let logger = AppLogger(
///     config: AppLoggerConfiguration(
///         subsystemLogger: "com.myapp",
///         categoryLogger: "Networking"
///     ),
///     visibility: AppLoggerVisibility(minimumLogLevel: .debug)
/// )
///
/// let record = LogRecord(
///     module: "UserAPI",
///     code: "USR001",
///     layer: "Network",
///     function: "fetchUserProfile",
///     messageByDev: "Request started",
///     messageBySystem: "",
///     messageLocalized: "Memuat profil pengguna",
///     file: #file,
///     line: #line,
///     version: "1.0.0"
/// )
///
/// logger.log(level: .debug, record: record, emoji: "🔍")
/// logger.log(level: .error, message: "Unable to connect to server")
/// ```
public class AppLogger: @unchecked Sendable {
    
    // MARK: - Properties
    
    /// The logging configuration, including subsystem and category.
    private(set) var config: AppLoggerConfiguration
    
    /// The visibility settings that determine log level thresholds and enablement.
    private(set) var visibility: AppLoggerVisibility
    
    // MARK: - Initialization
    
    /// Creates a new `AppLogger` instance with the provided configuration and visibility rules.
    ///
    /// - Parameters:
    ///   - config: The logger configuration (`AppLoggerConfiguration`), defining subsystem and category.
    ///   - visibility: The logger visibility settings (`AppLoggerVisibility`), controlling filtering and enablement.
    public init(
        config: AppLoggerConfiguration,
        visibility: AppLoggerVisibility
    ) {
        self.config = config
        self.visibility = visibility
    }
    
    // MARK: - Level Filtering
    
    /// Determines if the given log level meets the minimum logging threshold.
    ///
    /// - Parameter level: The log level to check.
    /// - Returns: `true` if the level should be logged; otherwise `false`.
    fileprivate func shouldLog(level: LogLevel) -> Bool {
        level.priority >= visibility.minimumLogLevel.priority
    }
    
    /// Checks whether logging is enabled and the log level meets the threshold.
    ///
    /// - Parameter level: The log level to evaluate.
    /// - Returns: `true` if logging should occur; otherwise `false`.
    private func isEnableLogging(level: LogLevel) -> Bool {
        visibility.isLoggingEnabled && shouldLog(level: level)
    }
    
    // MARK: - Foundation Logging
    
    /// Logs a structured `LogRecord` entry.
    ///
    /// - Parameters:
    ///   - level: The log level (`LogLevel`).
    ///   - record: The structured log record (`LogRecord`).
    ///   - emoji: An optional emoji to prefix the log message.
    ///   - category: The category under which the log is recorded. Defaults to `"AppLogger"`.
    ///   - privacy: The privacy level (`PrivacyOption`) for the log message. Defaults to `.public`.
    public func log(
        level: LogLevel,
        record: LogRecord,
        emoji: String? = nil,
        category: String = "AppLogger",
        privacy: PrivacyOption = .public
    ) {
        guard isEnableLogging(level: level) else { return }
        let prefix = emoji ?? level.defaultEmoji()
        let message = "\(prefix) \(level.rawValue): \(record.description)"
        _log(message, level: level, category: category)
    }
    
    // MARK: - Flexible Logging
    
    /// Logs a free-form message with optional context.
    ///
    /// - Parameters:
    ///   - level: The log level (`LogLevel`).
    ///   - message: The log message to record.
    ///   - module: An optional module name to include in the log output.
    ///   - emoji: An optional emoji to prefix the log message.
    ///   - function: The function name where the log is generated. Defaults to `#function`.
    ///   - file: The file path where the log is generated. Defaults to `#file`.
    ///   - line: The line number where the log is generated. Defaults to `#line`.
    ///   - category: The category under which the log is recorded. Defaults to `"AppLogger"`.
    ///   - privacy: The privacy level (`PrivacyOption`) for the log message. Defaults to `.public`.
    public func log(
        level: LogLevel,
        message: String,
        module: String? = nil,
        emoji: String? = nil,
        function: String = #function,
        file: String = #file,
        line: Int = #line,
        category: String = "AppLogger",
        privacy: PrivacyOption = .public
    ) {
        guard isEnableLogging(level: level) else { return }
        
        let prefix = emoji ?? level.defaultEmoji()
        let fileName = (file as NSString).lastPathComponent
        let moduleInfo = module.map { "[\($0)]" } ?? ""
        let formatted = "\(prefix) \(level.rawValue): \(moduleInfo) \(fileName):\(line) \(function) → \(message)"
        _log(formatted, level: level, category: category)
    }
    
    // MARK: - Internal Logging
    
    /// Performs the actual logging using Apple's unified logging system (`Logger` for iOS 14+, `os_log` for older versions).
    ///
    /// - Parameters:
    ///   - message: The formatted message to log.
    ///   - level: The log level (`LogLevel`).
    ///   - category: The category under which the log is recorded.
    ///   - privacy: The privacy level (`PrivacyOption`) for the log message. Defaults to `.public`.
    private func _log(
        _ message: String,
        level: LogLevel,
        category: String,
        privacy: PrivacyOption = .public
    ) {
        if #available(iOS 14.0, *) {
            let logger = Logger(
                subsystem: Bundle.main.bundleIdentifier ?? "com.default.AppLogger",
                category: category
            )
            switch level {
            case .debug:
                DebugMessageLogger(logger: logger, logLevel: level, message: message, privacy: privacy).createMessage()
            case .info:
                InfoMessageLogger(logger: logger, logLevel: level, message: message, privacy: privacy).createMessage()
            case .notice:
                NoticeMessageLogger(logger: logger, logLevel: level, message: message, privacy: privacy).createMessage()
            case .warning:
                WarningMessageLogger(logger: logger, logLevel: level, message: message, privacy: privacy).createMessage()
            case .error:
                ErrorMessageLogger(logger: logger, logLevel: level, message: message, privacy: privacy).createMessage()
            case .critical:
                CriticalMessageLogger(logger: logger, logLevel: level, message: message, privacy: privacy).createMessage()
            case .fault:
                FaultMessageLogger(logger: logger, logLevel: level, message: message, privacy: privacy).createMessage()
            }
        } else {
            // Fallback for iOS 13 and below
            let logType: OSLogType = level.osLogType
            let log = OSLog(
                subsystem: Bundle.main.bundleIdentifier ?? "com.default.AppLogger",
                category: category
            )
            os_log("%{public}@", log: log, type: logType, message)
        }
    }
}
