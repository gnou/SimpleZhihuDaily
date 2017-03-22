//
//  ContentViewController.swift
//  SimpleZhihuDaily
//
//  Created by Mingyu Cui on 22/03/2017.
//  Copyright © 2017 CuiMingyu. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
    
    // MARK: Nested Types
    
    
    
    // MARK: Project Internal Properties
    
    var id: Int?
    
    // MARK: UIViewController Properties
    
    
    
    // MARK: IBOutlet
    
    @IBOutlet weak var textView: UITextView!
    
    
    // MARK: Private Properties
    
    
    
    // MARK: Init
    
    
    
    // MARK: Project Internal Methods
    
    
    
    // MARK: UIViewController Methods
    
    
    
    // MARK: IBActions Methods
    
    
    
    // MARK: Private Methods
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let cacheManager = CacheManager(realm: appDelegate.mainRealm)
        if let id = id {
            cacheManager.story(id) { [weak self] result in
                if let story = result.value {
                    self?.textView.text = story.body
                }
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
