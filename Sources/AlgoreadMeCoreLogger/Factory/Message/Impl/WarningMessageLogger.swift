//
//  WarningMessageLogger.swift
//  AlgoreadMeCoreLogger
//
//  Created by @algoreadme on 07/08/25.
//

import os

@available(iOS 14.0, *)
struct WarningMessageLogger: FactoryMessageProtocol {
    var logger: Logger
    var logLevel: LogLevel
    var message: String
    var privacy: PrivacyOption
    
    func createMessage() {
        switch privacy {
        case .auto:
            logger.warning("\(message, privacy: .auto)")
        case .public:
            logger.warning("\(message, privacy: .public)")
        case .private:
            logger.warning("\(message, privacy: .private)")
        case .sensitive:
            logger.warning("\(message, privacy: .sensitive)")
        case let .mask(value):
            switch value {
            case .autoMask:
                logger.warning("\(message, privacy: .auto(mask: .hash))")
            case .privateMask:
                logger.warning("\(message, privacy: .private(mask: .hash))")
            case .sensitiveMask:
                logger.warning("\(message, privacy: .sensitive(mask: .hash))")
            }
        }
    }
}
