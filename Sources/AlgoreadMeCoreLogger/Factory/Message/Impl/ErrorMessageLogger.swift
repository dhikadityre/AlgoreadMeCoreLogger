//
//  ErrorMessageLogger.swift
//  AlgoreadMeCoreLogger
//
//  Created by @algoreadme on 07/08/25.
//

import os

@available(iOS 14.0, *)
struct ErrorMessageLogger: FactoryMessageProtocol {
    var logger: Logger
    var logLevel: LogLevel
    var message: String
    var privacy: PrivacyOption
    
    func createMessage() {
        switch privacy {
        case .auto:
            logger.error("\(message, privacy: .auto)")
        case .public:
            logger.error("\(message, privacy: .public)")
        case .private:
            logger.error("\(message, privacy: .private)")
        case .sensitive:
            logger.error("\(message, privacy: .sensitive)")
        case let .mask(value):
            switch value {
            case .autoMask:
                logger.error("\(message, privacy: .auto(mask: .hash))")
            case .privateMask:
                logger.error("\(message, privacy: .private(mask: .hash))")
            case .sensitiveMask:
                logger.error("\(message, privacy: .sensitive(mask: .hash))")
            }
        }
    }
}
