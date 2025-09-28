//
//  FaultMessageLogger.swift
//  AlgoreadMeCoreLogger
//
//  Created by @algoreadme on 07/08/25.
//

import os

@available(iOS 14.0, *)
struct FaultMessageLogger: FactoryMessageProtocol {
    var logger: Logger
    var logLevel: LogLevel
    var message: String
    var privacy: PrivacyOption
    
    func createMessage() {
        switch privacy {
        case .auto:
            logger.fault("\(message, privacy: .auto)")
        case .public:
            logger.fault("\(message, privacy: .public)")
        case .private:
            logger.fault("\(message, privacy: .private)")
        case .sensitive:
            logger.fault("\(message, privacy: .sensitive)")
        case let .mask(value):
            switch value {
            case .autoMask:
                logger.fault("\(message, privacy: .auto(mask: .hash))")
            case .privateMask:
                logger.fault("\(message, privacy: .private(mask: .hash))")
            case .sensitiveMask:
                logger.fault("\(message, privacy: .sensitive(mask: .hash))")
            }
        }
    }
}
