//
//  Room.swift
//  BeaconFreeRoomSearch
//
//  Created by hirauchi.shinichi on 2017/01/20.
//  Copyright © 2017年 SAPPOROWORKS. All rights reserved.
//

import Foundation

class Room {
    let name: String
    let uuid: String
    let base: Base
    var lasttime: Date // 最終記録時間
    
    var isFree:Bool {
        get {
            let interval = Date().timeIntervalSince(lasttime) // 最終記録時間から現在時までの秒数
            print("name=\(name) \(interval)")
            return interval > (60 * 5) // ５分
        }
    }
    
    init(name: String, uuid: String, base: Base){
        self.name = name
        self.uuid = uuid
        self.base = base
        self.lasttime = Date()
    }
}
