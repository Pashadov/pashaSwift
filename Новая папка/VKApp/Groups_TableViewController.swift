//
//  List_Of_Towns_TableViewController.swift
//  WeatherApp
//
//  Created by Арсений Дорогин on 24.09.2018.
//  Copyright © 2018 AVSI. All rights reserved.
//

import UIKit
import RealmSwift
import FirebaseDatabase
import Kingfisher 

class GroupsTableViewController: UITableViewController {
    
    private let groupServ = GroupService()
    
    private var groups = [FirebaseGroup]()
    private var groupsForDownload = [FirebaseGroup]()
    
    private let ref = Database.database().reference(withPath: "users/\(Session.shared.userId)/group")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Загрузка групп из вк
        
        DispatchQueue.global().async {
             self.groupServ.loadGroupList(){ [weak self] groups, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let groups = groups, let self = self else { return }
                
                
                self.groupsForDownload = groups
                
                
                DispatchQueue.main.async {
                    //сохранение групп в Firebase
                    for i in self.groupsForDownload{
                        let groupref = self.ref.child(String(i.idGroup))
                        groupref.setValue(i.toAnyObject())
                    }
                    self.tableView?.reloadData()
                }
            }
        }
        //Загрузка групп из Firebase
        ref.observe(.value, with: { snapshot in
            var groups: [FirebaseGroup] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let group = FirebaseGroup(snapshot: snapshot) {
                    groups.append(group)
                }
            }
            
            self.groups = groups
            self.tableView.reloadData()
        })
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groups.count
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // Если была нажата кнопка «Удалить»
        if editingStyle == .delete {
            // Удаляем город из массива
            let group = groups[indexPath.row]
            group.ref?.removeValue()
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! GroupCell
        
        let url = URL(string: groups[indexPath.row].photoUrl)
        
        let resourses = ImageResource(downloadURL: url!, cacheKey: groups[indexPath.row].photoUrl) //кэштироваание
        cell.Profile_Image.kf.setImage(with: resourses)
        
        cell.Name_Label.text = groups[indexPath.row].name
        
        // Configure the cell...

        return cell
    }
    
    
    var selectedRow:IndexPath!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath
        performSegue(withIdentifier: "SeeGroup", sender: self)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let destinationVC = segue.destination as! GroupPost_ViewController
        destinationVC.GroupId = String(groups[selectedRow.row].idGroup)
        
    }
    


}

class GroupCell: UITableViewCell{
    
    @IBOutlet weak var Name_Label:UILabel!
    @IBOutlet weak var Profile_Image: UIImageView!
    
}

