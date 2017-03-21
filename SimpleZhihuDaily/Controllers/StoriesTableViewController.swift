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

//        Alamofire.request(SRRouter.latest).responseCollection { (response: DataResponse<[Entry]>) in
//            switch response.result {
//            case .success(let stories):
//                self.stories = stories
//            case .failure(let error):
//                let alertController = UIAlertController(title: "Error", message: "Failed to fetch latest stories", preferredStyle: .alert)
//                alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .cancel, handler: nil))
//                present(alertController, animated: true, completion: nil)
//            }
//        }
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
        // #warning Incomplete implementation, return the number of rows
        return entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entry = entries[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TempEntryCell", for: indexPath)
        cell.textLabel?.text = entry.title
        return cell
    }

}
