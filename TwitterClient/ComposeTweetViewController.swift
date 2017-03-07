//
//  ComposeTweetViewController.swift
//  Birdhouse-TwitterClient
//
//  Created by Sean Nam on 3/6/17.
//  Copyright © 2017 Sean Nam. All rights reserved.
//

import UIKit

class ComposeTweetViewController: UIViewController {

    @IBOutlet weak var characterCountLabelAsButton: UIBarButtonItem!
    @IBOutlet weak var tweetTextField: UITextField!
    
    let TWEETMAX = 140
    var status: String = "testing"
    
    override func viewDidLoad() {

        super.viewDidLoad()
        tweetTextField.becomeFirstResponder()
        tweetTextField.addTarget(self, action: #selector(textFieldDidChange(tweetTextField:)), for: .editingChanged)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onTweetButton(_ sender: Any) {
        print("[DEBUG] tweeted: \(self.status)")
        
        let params: NSDictionary = ["status": status]
        TwitterClient.sharedInstance?.composeStatus(params: params, completion: { (error) in
            
        })
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldDidChange(tweetTextField: UITextField) {
        //var charCount: Int = 0
        //var tweetCount = tweetTextField.text?.lengthOfBytes(using: String.Encoding)
        
        //charCount = MAXTWEET - tweetCount
        
        status = tweetTextField.text!
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
