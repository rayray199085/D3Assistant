//
//  Double+extension.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 6/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import Foundation

extension Double {
    func roundedDecimal(to scale: Int = 0, mode: NSDecimalNumber.RoundingMode = .plain) -> Decimal {
        var decimalValue = Decimal(self)
        var result = Decimal()
        NSDecimalRound(&result, &decimalValue, scale, mode)
        return result
    }
}
