//
//  ProfileViewController.swift
//  Birdhouse-TwitterClient
//
//  Created by Sean Nam on 3/6/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var profileUser: User!
    
    @IBOutlet weak var profileTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.profileTableView.delegate = self
        self.profileTableView.dataSource = self
        
        profileTableView.reloadData()
        
        // Do any additional setup after loading the view.
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
extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = profileTableView.dequeueReusableCell(withIdentifier: "ProfileBodyCell", for: indexPath) as! ProfileBodyCell
        
        cell.user = profileUser

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection numOfRowsInSection: Int) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        
//        let view = UITableViewHeaderFooterView()
//        view.backgroundView 
//        
//        return view
//    }
}
