//
//  ViewController.swift
//  BeaconFreeRoomSearch
//
//  Created by hirauchi.shinichi on 2017/01/20.
//  Copyright © 2017年 SAPPOROWORKS. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate{


    @IBOutlet weak var roomsTableView: UITableView!
    var base: Base = .hatudai
    let repository = RoomRepository()
    var ibeacon = Ibeacon()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初期化
        repository.appnedRoom(room: Room(name: "会議室A", uuid: "ID", base: .hatudai))
        repository.appnedRoom(room: Room(name: "会議室B", uuid: "ID", base: .hatudai))
        repository.appnedRoom(room: Room(name: "会議室C", uuid: "ID", base: .hatudai))
        repository.appnedRoom(room: Room(name: "会議室D", uuid: "ID", base: .hatudai))
        repository.appnedRoom(room: Room(name: "会議室E", uuid: "ID", base: .hatudai))
        repository.appnedRoom(room: Room(name: "いぬ", uuid: "ID", base: .nagayama))
        repository.appnedRoom(room: Room(name: "ねこ", uuid: "ID", base: .nagayama))
        repository.appnedRoom(room: Room(name: "ライオン", uuid: "ID", base: .nagayama))
        repository.appnedRoom(room: Room(name: "らくだ", uuid: "ID", base: .nagayama))
        repository.appnedRoom(room: Room(name: "かめ", uuid: "ID", base: .nagayama))
        repository.appnedRoom(room: Room(name: "サメ", uuid: "ID", base: .nagayama))
        repository.appnedRoom(room: Room(name: "くじら", uuid: "ID", base: .nagayama))
        repository.appnedRoom(room: Room(name: "カンガルー", uuid: "ID", base: .nagayama))
        repository.appnedRoom(room: Room(name: "柴犬", uuid: "ID", base: .nagayama))
        
        // DEBUG
        for room in repository.getRooms(base: .hatudai) {
            room.lasttime = Date().addingTimeInterval(-60*5)
        }
        for room in repository.getRooms(base: .nagayama) {
            room.lasttime = Date()//.addingTimeInterval()
        }

        roomsTableView.dataSource = self
        
    }

    @IBAction func tapTest(_ sender: Any) {
        
        if !ibeacon.start(uuidString: "AFF046AD-A89A-4386-A747-1678E5FEE73B", identifier: "name")  {
            let alert:UIAlertView? = UIAlertView(title: "エラー",message: "この端末ではiBeaconを利用できません。", delegate: self, cancelButtonTitle: nil, otherButtonTitles: "OK")
            alert?.show()
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func changeBaseSegmentedControll(_ sender: UISegmentedControl) {
        base = sender.selectedSegmentIndex == 0 ? .hatudai : .nagayama
        roomsTableView.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository.getRooms(base: base).count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let room = repository.getRooms(base: base)[indexPath.row]
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
        cell.detailTextLabel?.text = room.isFree ? "" : "使用中"
        cell.textLabel?.text = room.name
        return cell
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        //cell.textLabel!.text = "\(repository.getRooms(base: base)[indexPath.row].name)"
    }
    
}

