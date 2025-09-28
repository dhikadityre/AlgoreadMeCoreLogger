//
//  InfoMessageLogger.swift
//  AlgoreadMeCoreLogger
//
//  Created by @algoreadme on 07/08/25.
//

import os

@available(iOS 14.0, *)
struct InfoMessageLogger: FactoryMessageProtocol {
    var logger: Logger
    var logLevel: LogLevel
    var message: String
    var privacy: PrivacyOption
    
    func createMessage() {
        switch privacy {
        case .auto:
            logger.info("\(message, privacy: .auto)")
        case .public:
            logger.info("\(message, privacy: .public)")
        case .private:
            logger.info("\(message, privacy: .private)")
        case .sensitive:
            logger.info("\(message, privacy: .sensitive)")
        case let .mask(value):
            switch value {
            case .autoMask:
                logger.info("\(message, privacy: .auto(mask: .hash))")
            case .privateMask:
                logger.info("\(message, privacy: .private(mask: .hash))")
            case .sensitiveMask:
                logger.info("\(message, privacy: .sensitive(mask: .hash))")
            }
        }
    }
}
