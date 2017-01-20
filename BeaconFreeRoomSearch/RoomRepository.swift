//
//  　RoomRepository.swift
//  BeaconFreeRoomSearch
//
//  Created by hirauchi.shinichi on 2017/01/20.
//  Copyright © 2017年 SAPPOROWORKS. All rights reserved.
//

import Foundation

class RoomRepository {
    
    fileprivate var rooms:[Room] = []
    
    func appnedRoom(room: Room) {
        rooms.append(room)
    }
    
    func update(name: String, lastTime: Date) -> Bool {
        if let i = rooms.index(where: { $0.name == name }) {
            rooms[i].lasttime = lastTime
            return true
        }
        return false
    }
    
    func getRooms(base: Base) -> [Room] {
        return rooms.filter({ $0.base == base })
    }
}
