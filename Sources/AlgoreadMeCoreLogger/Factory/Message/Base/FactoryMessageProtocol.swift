//
//  FactoryMessageProtocol.swift
//  AlgoreadMeCoreLogger
//
//  Created by @algoreadme on 07/08/25.
//

import os

/// A protocol defining a standardized interface for creating and logging messages
/// through Apple's unified logging system.
///
/// `FactoryMessageProtocol` is used as a blueprint for building message-specific
/// logger implementations (e.g., `DebugMessageLogger`, `ErrorMessageLogger`).
/// Implementations of this protocol determine how the message is formatted
/// and logged based on the provided log level and privacy settings.
///
/// ## Overview
/// This protocol ensures consistency in:
/// - The logger instance (`Logger`)
/// - The log level (`LogLevel`)
/// - The message content
/// - The privacy option (`PrivacyOption`)
///
/// Conforming types are responsible for implementing `createMessage()`, which
/// sends the log message to the system.
///
/// ## Example
/// ```swift
/// @available(iOS 14.0, *)
/// struct InfoMessageLogger: FactoryMessageProtocol {
///     let logger: Logger
///     let logLevel: LogLevel
///     let message: String
///     let privacy: PrivacyOption
///
///     func createMessage() {
///         logger.info("\(message, privacy: privacy.osPrivacy)")
///     }
/// }
/// ```
protocol FactoryMessageProtocol {
    
    /// The system logger used to output messages.
    ///
    /// Available only on iOS 14.0 and later.
    @available(iOS 14.0, *)
    var logger: Logger { get }
    
    /// The severity or type of the log message.
    var logLevel: LogLevel { get }
    
    /// The textual content of the log entry.
    var message: String { get }
    
    /// The privacy setting for the log message.
    ///
    /// Determines whether the message content should be public or private
    /// when displayed in system logs.
    var privacy: PrivacyOption { get }
    
    /// Creates and sends the log message to the system logger.
    ///
    /// Implementations of this method should format the message and log it
    /// according to the specified `logLevel` and `privacy` settings.
    func createMessage()
}
