//
//  WebviewViewController.swift
//  TechNews
//
//  Created by Lucy Mambre on 02/02/2018.
//  Copyright © 2018 Lucy Mambre. All rights reserved.
//

import UIKit

class WebviewViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var url: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url_article:URL = URL(string: url!)!
        let urlRequest:URLRequest = URLRequest(url: url_article)
        webView.loadRequest(urlRequest)
    }
    
    
}
