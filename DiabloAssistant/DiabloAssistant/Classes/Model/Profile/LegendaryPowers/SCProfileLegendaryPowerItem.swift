//
//  SCProfileLegendaryPower.swift
//  DiabloAssistant
//
//  Created by Stephen Cao on 2/6/19.
//  Copyright © 2019 Stephen Cao. All rights reserved.
//

import UIKit

class SCProfileLegendaryPowerItem: NSObject {
    @objc var id: String?
    @objc var name: String?
    @objc var slug: String?{
        guard let s = name?.lowercased()  else {
            return nil
        }
        return (s as NSString).replacingOccurrences(of: "-", with: "").replacingOccurrences(of: "'", with: "").replacingOccurrences(of: " ", with: "-").replacingOccurrences(of: ",", with: "")
    }
    @objc var icon: String?
    @objc var displayColor: String?
    @objc var iconImage: UIImage?
    
    override var description: String{
        return yy_modelDescription()
    }
}
