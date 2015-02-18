//
//  ViewController.swift
//  WebViewExample
//
//  Created by Kazuya Tateishi on 2015/02/18.
//  Copyright (c) 2015年 kzy52. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
    
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
        
        // インジケータを表示する
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    // WebView を生成する
    func createWebView(#frame: CGRect) -> UIWebView {
        // UIWebViewのインスタンスを生成
        let _webView = UIWebView()
        
        // デリゲートを指定する
        _webView.delegate = self;
        
        // 画面サイズを設定する
        _webView.frame = frame
        
        // ビューサイズの自動調整
        _webView.autoresizingMask = UIViewAutoresizing.FlexibleRightMargin |
            UIViewAutoresizing.FlexibleTopMargin |
            UIViewAutoresizing.FlexibleLeftMargin |
            UIViewAutoresizing.FlexibleBottomMargin |
            UIViewAutoresizing.FlexibleWidth |
            UIViewAutoresizing.FlexibleHeight
        
        return _webView
    }
    
    // ビューが再レイアウトされるときに呼び出される
    override func viewWillLayoutSubviews() {
        let statusBarHeight: CGFloat! = UIApplication.sharedApplication().statusBarFrame.height
        self.webView?.frame = CGRectMake(0, statusBarHeight, self.view.bounds.width, self.view.bounds.height)
    }
    
    
    // WebView がコンテンツの読み込みを完了した後に呼ばれる
    func webViewDidFinishLoad(webView: UIWebView) {
        // インジケータを非表示にする
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}