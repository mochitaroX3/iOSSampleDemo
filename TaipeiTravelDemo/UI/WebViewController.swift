//
//  WebViewController.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/12.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    static func new(with title: String = "news.section.title".localized, url: String) -> WebViewController {
        let vc = WebViewController.initInstance() as! WebViewController
        vc.titleText = title
        vc.url = url
        return vc
    }
    
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var webView: WKWebView!
    
    var titleText: String = ""
    var url: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleText
        
        loadWebView(urlStr: url)
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: [.new], context: nil)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.removeObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress))
    }
    
    func loadWebView(urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        webView.load(URLRequest(url: url))
    }
    
    @IBAction func goBack(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func goForward(_ sender: Any) {
        webView.goForward()
    }
    
    @IBAction func clickReload(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func goShared(_ sender: Any) {
        guard let url = URL(string: url) else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            if let progressValue = change?[NSKeyValueChangeKey.newKey] as? Double  {
                progress.isHidden = false
                progress.setProgress(Float(progressValue), animated: true)

                if progressValue >= 1 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.progress.progress = 0
                        self.progress.isHidden = true
                    }
                }
            }
        }
    }
}
