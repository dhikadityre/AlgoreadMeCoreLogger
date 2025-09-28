//
//  AppLoggerConfiguration.swift
//  AlgoreadMeCoreLogger
//
//  Created by @algoreadme on 07/08/25.
//

/// A configuration object for customizing the application's logging behavior.
///
/// `AppLoggerConfiguration` defines the logging subsystem and category that will be used
/// when creating log entries within the application.
/// - The **subsystem** typically represents your application's bundle identifier or a unique
///   string to identify the logging source.
/// - The **category** represents the logical module or feature name associated with the log.
///
/// This configuration can be passed to your logging system to ensure that logs
/// are grouped and filtered consistently.
///
/// Example:
/// ```swift
/// let config = AppLoggerConfiguration(
///     subsystemLogger: "com.mycompany.MyApp",
///     categoryLogger: "Networking"
/// )
/// ```
///
/// In this example, all log entries from the networking layer will be categorized under
/// `"Networking"` and associated with the subsystem `"com.mycompany.MyApp"`.
public class AppLoggerConfiguration: @unchecked Sendable {
    
    // MARK: - Properties
    
    /// The logging subsystem identifier, typically set to the application's bundle ID.
    ///
    /// This value is used to group related log entries together.
    /// Defaults to `"com.algoreadme.AlgoreadMeCoreLogger"`.
    public var subsystemLogger: String = "com.algoreadme.AlgoreadMeCoreLogger"
    
    /// The logging category, typically representing the module or feature name.
    ///
    /// This value helps organize log messages by specific areas of the app.
    /// Defaults to `"AppLogger"`.
    public var categoryLogger: String = "AppLogger"
    
    // MARK: - Initializer
    
    /// Creates a new logging configuration instance.
    ///
    /// - Parameters:
    ///   - subsystemLogger: The logging subsystem identifier, usually the bundle ID.
    ///   - categoryLogger: The logging category name, representing a specific module or feature.
    public init(
        subsystemLogger: String = "com.algoreadme.AlgoreadMeCoreLogger",
        categoryLogger: String = "AppLogger"
    ) {
        self.subsystemLogger = subsystemLogger
        self.categoryLogger = categoryLogger
    }
}
