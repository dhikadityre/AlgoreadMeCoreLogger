//
//  CriticalMessageLogger.swift
//  AlgoreadMeCoreLogger
//
//  Created by @algoreadme on 07/08/25.
//

import os

@available(iOS 14.0, *)
struct CriticalMessageLogger: FactoryMessageProtocol {
    var logger: Logger
    var logLevel: LogLevel
    var message: String
    var privacy: PrivacyOption
    
    func createMessage() {
        switch privacy {
        case .auto:
            logger.critical("\(message, privacy: .auto)")
        case .public:
            logger.critical("\(message, privacy: .public)")
        case .private:
            logger.critical("\(message, privacy: .private)")
        case .sensitive:
            logger.critical("\(message, privacy: .sensitive)")
        case let .mask(value):
            switch value {
            case .autoMask:
                logger.critical("\(message, privacy: .auto(mask: .hash))")
            case .privateMask:
                logger.critical("\(message, privacy: .private(mask: .hash))")
            case .sensitiveMask:
                logger.critical("\(message, privacy: .sensitive(mask: .hash))")
            }
        }
    }
}
