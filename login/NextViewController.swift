
//
//  NextViewController.swift
//  login
//
//  Created by 早坂彪流 on 2015/03/15.
//  Copyright (c) 2015年 TakeruHayasaka. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {
    
    @IBOutlet weak var createname: UITextField!
    @IBOutlet weak var createpass: UITextField!
    @IBOutlet weak var createsend: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //ボタンとの関連
        createsend.addTarget(self, action: "sendcreate:", forControlEvents: UIControlEvents.TouchUpInside)
        //記憶する
        var uid = NSUserDefaults.standardUserDefaults().stringForKey("uid")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendcreate(sender:UIButton){
        //Request
        let URLStr = "http://49.212.91.93/appcreate"
        //let URLStr = "http://192.168.7.244:3000/appcreate"
        var createRequest = NSMutableURLRequest(URL: NSURL(string:URLStr)!)
        //set　HTTP-POST
        createRequest.HTTPMethod = "POST"
        //set the header
        createRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        createRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //中身書かれてるか確認
        if createname.text != nil && createpass.text != nil {
            //set requestbody on data(JSON)
            var logincreate = ["name":createname.text,"password":createpass.text]
            
            //bodyにいれる。
            createRequest.HTTPBody = NSJSONSerialization.dataWithJSONObject(logincreate, options: nil, error: nil)
            println("ionw")
            //セクションの設定
            var task = NSURLSession.sharedSession().dataTaskWithRequest(createRequest, completionHandler: {data,response,error in
                if error == nil {
                    //ジェイソンさんにパース
                    let json:NSDictionary = NSJSONSerialization.JSONObjectWithData(data,options: NSJSONReadingOptions.AllowFragments, error: nil) as NSDictionary
                    var result = NSString(data: data, encoding: NSUTF8StringEncoding)!//確認のための単純にストリング
                    println(result) ;println(json);
                   
                }else {
                    print(error)
                }
            })
            //taskが中断されているなら再開
             task.resume()
        }
        
    }
    
}

//let storage = NSHTTPCookieStorage.sharedHTTPCookieStorage()//cookieのストレージを管理シングルトンオブジェクト.共有クッキーストレージオブジェクトを取得する
// let cookies = NSHTTPCookieStorage.cookiesForURL(storage)(NSURL(string: URLStr)!)//cookieのストレージを管理シングルトンオブジェクト.指定されたURLに送信されるすべてのCookieの保存のクッキーを返します
//  NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookies(cookies!, forURL:NSURL(string: URLStr)!, mainDocumentURL: NSURL(string: URLStr)!)
// for cookie : NSHTTPCookie in NSHTTPCookieStorage.sharedHTTPCookieStorage().cookiesForURL(NSURL(string: URLStr)!) as [NSHTTPCookie] {
//    NSHTTPCookieStorage.sharedHTTPCookieStorage().setCookie(cookie)
//   println(cookie)
//  }

// uidを端末に記録
//  NSUserDefaults.standardUserDefaults().setObject(,forKey:"uid")