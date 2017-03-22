//
//  StoriesTableViewController.swift
//  SimpleZhihuDaily
//
//  Created by Mingyu Cui on 06/12/2016.
//  Copyright © 2016 CuiMingyu. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class StoriesTableViewController: UITableViewController {

    var entries = [Entry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let cacheManager = CacheManager(realm: appDelegate.mainRealm)
        cacheManager.entriesOfDate(Date.init(timeIntervalSinceNow: -100000)) { [weak self] (result) in
            if let values = result.value {
                self?.entries = values
                self?.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = entries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TempEntryCell", for: indexPath)
        cell.textLabel?.text = entry.title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let entry = entries[indexPath.row]
            
            if let contentVC = segue.destination as? ContentViewController {
                contentVC.id = entry.id
            }
        }
    }

}
