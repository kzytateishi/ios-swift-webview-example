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
    
    var toolBar: UIToolbar?
    var rewindButton = UIBarButtonItem()
    var fastForwardButton = UIBarButtonItem()
    var refreshButton = UIBarButtonItem()
    var openInSafari = UIBarButtonItem()

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
        
        // ツールバーを生成する
        self.toolBar = self.createToolBar(frame: CGRectMake(0, height-44, width, 40.0), position: CGPointMake(width/2, height-20.0))
        
        // サブビューを追加する
        self.view.addSubview(self.toolBar!)
        
        // リクエストを生成する
        var url = NSURL(string: targetURL)
        var request = NSURLRequest(URL: url!)
        
        // 指定したページを読み込む
        self.webView?.loadRequest(request)
        
        // インジケータを表示する
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        // 前のページに戻れるかどうか
        self.rewindButton.enabled = self.webView!.canGoBack
        // 次のページに進めるかどうか
        self.fastForwardButton.enabled = self.webView!.canGoForward
        self.refreshButton.enabled = false
        self.openInSafari.enabled = false
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
    
    // ツールバーを生成する
    func createToolBar(#frame: CGRect, position: CGPoint) -> UIToolbar {
        // UIWebViewのインスタンスを生成
        let _toolBar = UIToolbar()
        
        // ツールバーのサイズを決める.
        _toolBar.frame = frame
        
        // ツールバーの位置を決める.
        _toolBar.layer.position = position
        
        // 文字色を設定する
        _toolBar.tintColor = UIColor.blueColor()
        // 背景色を設定する
        _toolBar.backgroundColor = UIColor.whiteColor()
        
        // 各ボタンを生成する
        // UIBarButtonItem(style, デリゲートのターゲットを指定, ボタンが押されたときに呼ばれるメソッドを指定)
        let spacer: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
        self.rewindButton = UIBarButtonItem(barButtonSystemItem: .Rewind, target: self, action: "back:")
        self.fastForwardButton = UIBarButtonItem(barButtonSystemItem: .FastForward, target: self, action: "forward:")
        self.refreshButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refresh:")
        self.openInSafari = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: "safari:")
        
        // ボタンをツールバーに入れる.
        _toolBar.items = [rewindButton, fastForwardButton, refreshButton, spacer, openInSafari]
        
        return _toolBar
    }
    
    // ビューが再レイアウトされるときに呼び出される
    override func viewWillLayoutSubviews() {
        let statusBarHeight: CGFloat! = UIApplication.sharedApplication().statusBarFrame.height
        self.webView?.frame = CGRectMake(0, statusBarHeight, self.view.bounds.width, self.view.bounds.height)
    }
    
    // WebViewがコンテンツの読み込みを開始した時に呼ばれる
    func webViewDidStartLoad(webView: UIWebView) {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        self.rewindButton.enabled = self.webView!.canGoBack
        self.fastForwardButton.enabled = self.webView!.canGoForward
        self.refreshButton.enabled = true
        self.openInSafari.enabled = true
    }
    
    // WebView がコンテンツの読み込みを完了した後に呼ばれる
    func webViewDidFinishLoad(webView: UIWebView) {
        // インジケータを非表示にする
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        
        self.rewindButton.enabled = self.webView!.canGoBack
        self.fastForwardButton.enabled = self.webView!.canGoForward
    }
    
    // 戻るボタンの処理
    @IBAction func back(AnyObject) {
        self.webView?.goBack()
    }
    
    // 進むボタンの処理
    @IBAction func forward(AnyObject) {
        self.webView?.goForward()
    }
    
    // 再読み込みボタンの処理
    @IBAction func refresh(AnyObject) {
        self.webView?.reload()
    }
    
    // safari で開く
    @IBAction func safari(AnyObject) {
        let url = self.webView?.request?.URL
        UIApplication.sharedApplication().openURL(url!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}