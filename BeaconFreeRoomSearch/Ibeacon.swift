//
//  Ibeacon.swift
//  BeaconFreeRoomSearch
//
//  Created by hirauchi.shinichi on 2017/01/20.
//  Copyright © 2017年 SAPPOROWORKS. All rights reserved.
//

import UIKit
import CoreLocation

// info.plistにNSLocationAlwaysUsageDescriptionの記述が必要

class Ibeacon: NSObject, CLLocationManagerDelegate {
    
    fileprivate var locationManager:CLLocationManager?
    //fileprivate var proximityUUID:UUID?
    //fileprivate var beaconRegion:CLBeaconRegion?
    fileprivate var nearestBeacon:CLBeacon?
    
    override init() {
        super.init()
        
        if(CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self)) {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            if locationManager?.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) != nil {
                locationManager?.requestAlwaysAuthorization()
            }
        }
    }
    
    func start(uuidString: String, identifier: String) -> Bool {
        if locationManager != nil {
        
            if let proximityUUID = UUID(uuidString: uuidString) {
                let beaconRegion = CLBeaconRegion(proximityUUID: proximityUUID, identifier: identifier)
                locationManager?.startMonitoring(for: beaconRegion)
                print("startMoonitaring2")
                return true
            }
        }
        return false
    }
    
    // 許可状態の変更
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("didChangeAuthorization \(status)")
    }

    // 開始
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        print("start")
    }
    
    // 領域内への移動
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("enter")
        locationManager?.startRangingBeacons(in: region as! CLBeaconRegion)
    }
    
    // 領域外への移動
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("exit")
        locationManager?.stopRangingBeacons(in: region as! CLBeaconRegion)
    }
    
    // 領域内にいるかどうか
    func locationManager(_ manager: CLLocationManager, didDetermineState state: CLRegionState, for region: CLRegion) {
        print(state)
    }
    
    // 距離計測
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print("didRangeBeacons")
    }
    
}
