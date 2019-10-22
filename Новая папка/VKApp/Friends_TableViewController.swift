//
//  Friends_TableViewController.swift
//  WeatherApp
//
//  Created by Арсений Дорогин on 24.09.2018.
//  Copyright © 2018 AVSI. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

class Friends_TableViewController: UITableViewController,UISearchBarDelegate {
    
    var searchController = UISearchController(searchResultsController: nil)
    
    
    private var Friendis: Results<FriendsRealm>?
    private var notificationToken: NotificationToken?
    
    @IBOutlet weak var SearchBar: UISearchBar!
    var searchActive : Bool = false
    var filtered:[FriendsRealm] = []

    var FriendDict:Dictionary = [String:[FriendsRealm]]()
    var sections = [String]()
    
    var FriendList = [FriendsRealm]()
    
    private let FriendServ = FriendService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBar.placeholder = "Найти друзей"
        SearchBar.delegate = self
        
        self.Friendis = DatabaseService.get(FriendsRealm.self)
        
        DispatchQueue.global().async {
            self.FriendServ.loadFriendsList(){ [weak self] friends, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                
                guard let friends = friends, let self = self else { return }
                
                
                self.FriendList = friends
                
                
                DispatchQueue.main.async {
                    let RealmFriendList = self.Friendis
                    self.prepareTitleForHeader(FrList: RealmFriendList)
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        notificationToken = Friendis?.observe { [weak self] changes in
            switch changes {
            case .initial(_):
                self?.tableView.reloadData()
            case .update(_, _, _, _):
                self?.tableView.reloadData()
            case .error(let error):
                self?.showAlert(error: error)
            }
        }
    }
    
    func showAlert(error: Error) {
        let alertVC = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alertVC.addAction(cancelAction)
        
        present(alertVC, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        notificationToken?.invalidate()
    }
    
    func prepareTitleForHeader(FrList: Results<FriendsRealm>?){
        for people in FrList!{
            let index = people.firstName.index(people.firstName.startIndex, offsetBy: 0)
        
            let key = String(people.firstName[index])
            FriendDict[key] = []
        }
        for people in FrList!{
            let index = people.firstName.index(people.firstName.startIndex, offsetBy: 0)
            //print(i[index])
            let key = String(people.firstName[index])
            FriendDict[key]?.append(people)
        }
        for i in FriendDict.keys{
            sections.append(i)
        }
        sections.sort()
    }
// MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if(searchActive) {
            return 1
        }
        return sections.count
    }
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.sections
    }

    override func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(searchActive) {
            return ""
        }
        return self.sections[section] as String
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searchActive) {
            return filtered.count
        }
        return (FriendDict[sections[section]]?.count)!
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_id", for: indexPath) as! WeatherCell

        
        var PU:String!
        
        if(searchActive){
            PU = filtered[indexPath.row].photoUrl
            cell.Name_Label.text = filtered[indexPath.row].firstName+" "+filtered[indexPath.row].lastName
        } else {
            PU = FriendDict[sections[indexPath.section]]![indexPath.row].photoUrl
            let FN = FriendDict[sections[indexPath.section]]![indexPath.row].firstName
            let SN = FriendDict[sections[indexPath.section]]![indexPath.row].lastName
            cell.Name_Label.text = FN+" "+SN
        }
        let url = URL(string: PU)
        let resourses = ImageResource(downloadURL: url!, cacheKey: PU) //кэштироваание
        cell.Profile_Image.kf.setImage(with: resourses)
        

        return cell
    }
    

    
    var selectedRow:IndexPath!
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRow = indexPath
        performSegue(withIdentifier: "ShowCollectionView", sender: self)
    }


    //MARK: - SearchBar
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filtered = searchText.isEmpty ? FriendList : FriendList.filter { $0.firstName.contains(searchText) }
        
        if(filtered.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let destinationVC = segue.destination as! MyCollectionViewController
        destinationVC.UserId = String(FriendDict[sections[selectedRow.section]]![selectedRow.row].idUser)
        
        
    }
    

}
