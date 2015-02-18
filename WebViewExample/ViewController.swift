//
//  ViewController.swift
//  WebViewExample
//
//  Created by Kazuya Tateishi on 2015/02/18.
//  Copyright (c) 2015年 kzy52. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var webView: UIWebView?
    
    var targetURL = "http://www.yahoo.co.jp/"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 横幅、高さ、ステータスバーの高さを取得する
        let width: CGFloat! = self.view.bounds.width
        let height: CGFloat! = self.view.bounds.height
        let statusBarHeight: CGFloat! = UIApplication.sharedApplication().statusBarFrame.height
        
        // WebViewを生成する
        self.webView = self.createWebView(frame: CGRectMake(0, statusBarHeight, width, height - statusBarHeight))
        
        // サブビューを追加する
        self.view.addSubview(self.webView!)
        
        // リクエストを生成する
        var url = NSURL(string: targetURL)
        var request = NSURLRequest(URL: url!)
        
        // 指定したページを読み込む
        self.webView?.loadRequest(request)
    }
    
    // WebView を生成する
    func createWebView(#frame: CGRect) -> UIWebView {
        // UIWebViewのインスタンスを生成
        let _webView = UIWebView()
        
        // 画面サイズを設定する
        _webView.frame = frame
        
        return _webView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}