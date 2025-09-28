//
//  PrivacyOption.swift
//  AlgoreadMeCoreLogger
//
//  Created by @algoreadme on 07/08/25.
//

import os

public enum PrivacyOption {
    case `auto`
    case `public`
    case `private`
    case `sensitive`
    case mask(PrivacyOptionMask)
    
    @available(iOS 14.0, *)
    var osLogPrivacy: OSLogPrivacy {
        switch self {
            case .auto:
                return .auto
            case .public:
                return .public
            case .private:
                return .private
            case .sensitive:
                return .sensitive
            case let .mask(value):
                return value.toOsLogPrivacy()
        }
    }
}

public enum PrivacyOptionMask {
    case `autoMask`
    case `privateMask`
    case `sensitiveMask`
    
    @available(iOS 14.0, *)
    func toOsLogPrivacy() -> OSLogPrivacy {
        switch self {
            case .autoMask: return .auto(mask: .hash)
            case .privateMask: return .private(mask: .hash)
            case .sensitiveMask: return .sensitive(mask: .hash)
        }
    }
}
