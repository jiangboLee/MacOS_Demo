//
//  Preferences.swift
//  HelloWorld
//
//  Created by Lee on 2019/3/7.
//  Copyright © 2019 Lee. All rights reserved.
//

import Foundation

struct Preferences {
    
    var selectedTime: TimeInterval {
        get {
            let savedTime = UserDefaults.standard.double(forKey: "selectedTime")
            if savedTime > 0 {
                return savedTime
            }
            return 360
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "selectedTime")
        }
    }
}
