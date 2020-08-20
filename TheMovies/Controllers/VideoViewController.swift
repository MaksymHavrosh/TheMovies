//
//  VideoViewController.swift
//  TheMovies
//
//  Created by MG on 20.08.2020.
//  Copyright © 2020 MG. All rights reserved.
//

import UIKit
import WebKit

class VideoViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var urlVideo: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = urlVideo else { return }
        webView.load(URLRequest(url: url))
    }

}
