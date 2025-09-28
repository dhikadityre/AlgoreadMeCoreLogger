//
//  DebugMessageLogger.swift
//  AlgoreadMeCoreLogger
//
//  Created by @algoreadme on 07/08/25.
//

import os

@available(iOS 14.0, *)
struct DebugMessageLogger: FactoryMessageProtocol {
    var logger: Logger
    var logLevel: LogLevel
    var message: String
    var privacy: PrivacyOption
    
    func createMessage() {
        switch privacy {
        case .auto:
            logger.debug("\(message, privacy: .auto)")
        case .public:
            logger.debug("\(message, privacy: .public)")
        case .private:
            logger.debug("\(message, privacy: .private)")
        case .sensitive:
            logger.debug("\(message, privacy: .sensitive)")
        case let .mask(value):
            switch value {
            case .autoMask:
                logger.debug("\(message, privacy: .auto(mask: .hash))")
            case .privateMask:
                logger.debug("\(message, privacy: .private(mask: .hash))")
            case .sensitiveMask:
                logger.debug("\(message, privacy: .sensitive(mask: .hash))")
            }
        }
    }
}
