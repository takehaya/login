//
//  ViewController.swift
//  login
//
//  Created by TakeruHayasaka on 2015/03/13.
//  Copyright (c) 2015年 TakeruHayasaka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var passTextView: UITextView!
    @IBOutlet weak var loginButton: UIButton!
       override func viewDidLoad() {
        super.viewDidLoad()
        
        //ボタンとの関連
        loginButton.addTarget(self, action: "login:", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    func login(sender:UIButton){
        
        //Request
        let URLStr = "http://49.212.91.93/appLogin"
//      let URLStr = "http://192.168.7.244:3000/appLogin"
        var loginRequest = NSMutableURLRequest(URL: NSURL(string:URLStr)!)
        
        //set　HTTP-POST
        loginRequest.HTTPMethod = "POST"
        //set the header((本当はどんな動作してるかわからない。。。なくてもうごく。。。
        loginRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        loginRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")//application/jsonで指定しないとJSONをJSONで囲ってしまう。
       //loginRequest.addValue("/appLogin", forHTTPHeaderField: "Accept")
        //loginRequest.addValue("/appLogin", forHTTPHeaderField: "Content-Type")
       
        //中身書かれてるか確認
    if nameTextView.text != nil && passTextView.text != nil {
        
        //set requestbody on data(JSON)
        var login = ["name":nameTextView.text,"password":passTextView.text]
        
        //bodyにいれる。
        loginRequest.HTTPBody = NSJSONSerialization.dataWithJSONObject(login, options: nil, error: nil)
        println("io")
        
       //セクションの設定
            var task = NSURLSession.sharedSession().dataTaskWithRequest(loginRequest, completionHandler: {data,response,error in
            if error == nil {
                //ジェイソンさんにパース
                let json:NSDictionary = NSJSONSerialization.JSONObjectWithData(data,options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
                var result = NSString(data: data, encoding: NSUTF8StringEncoding)!//確認のための単純にストリング
                println(result)
                println(json)
            }else {
                println(error)
            }
        })
        //taskが中断されているなら再開
        task.resume()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func returnMenu(segue:UIStoryboardSegue){
    
    }
}

