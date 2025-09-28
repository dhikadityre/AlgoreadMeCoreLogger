//
//  NoticeMessageLogger.swift
//  AlgoreadMeCoreLogger
//
//  Created by @algoreadme on 07/08/25.
//

import os

@available(iOS 14.0, *)
struct NoticeMessageLogger: FactoryMessageProtocol {
    var logger: Logger
    var logLevel: LogLevel
    var message: String
    var privacy: PrivacyOption
    
    func createMessage() {
        switch privacy {
        case .auto:
            logger.notice("\(message, privacy: .auto)")
        case .public:
            logger.notice("\(message, privacy: .public)")
        case .private:
            logger.notice("\(message, privacy: .private)")
        case .sensitive:
            logger.notice("\(message, privacy: .sensitive)")
        case let .mask(value):
            switch value {
            case .autoMask:
                logger.notice("\(message, privacy: .auto(mask: .hash))")
            case .privateMask:
                logger.notice("\(message, privacy: .private(mask: .hash))")
            case .sensitiveMask:
                logger.notice("\(message, privacy: .sensitive(mask: .hash))")
            }
        }
    }
}
