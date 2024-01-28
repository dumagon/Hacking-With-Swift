

import UIKit
import WebKit


// to be qualified for handling delegated actions a class must conform to the WKNavigationDelegate protocol
// a class can inherit from only one super class ( comes first ) and conform to many protocols ( that come after the super class's name
class ViewController: UIViewController,WKNavigationDelegate {
    
    var webView:WKWebView!
    var progressView:UIProgressView!
    var allowedWebsites = ["google.com","hackingwithswift.com","apple.com"]

    
    override func loadView() {

// setting up the view
        
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
  }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
// setting up a start page , in this case "google.com" is at allowedWebsites[0]
        
        let url = URL(string:"https://"+allowedWebsites[0])!
        webView.load(URLRequest(url:url))
        webView.allowsBackForwardNavigationGestures = true
        
        
        
// adding an observer
// observer is set to self ( this viewcontroller ) , #keyPath checks if estimatedProgress property exists
        
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), context: nil)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: .plain, target: self, action: #selector(openTapped))
        
// creating toolbar items
// creating an instance of UIProgressView and wrapping it into UIBarButtonItem type
        
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        let progressButton = UIBarButtonItem(customView: progressView)
        let forward = UIBarButtonItem(barButtonSystemItem: .fastForward, target: nil, action: #selector(webView.goForward))
        let backward = UIBarButtonItem(barButtonSystemItem: .rewind, target: nil, action: #selector(webView.goBack))
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: webView, action: #selector(webView.reload))
        
        toolbarItems = [progressButton,spacer,backward,spacer,refresh,spacer,forward]
        navigationController?.isToolbarHidden = false
        
        
           }
    
    
    
    
// ******* webView methods ***********
    
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        if let host = url?.host{
            for website in allowedWebsites {
                if host.contains(website){
                    decisionHandler(.allow)
                    return
                }
            }
        }
        decisionHandler(.cancel)
        let blockAC = UIAlertController(title: "Oops", message: "This website is blocked !", preferredStyle: .alert)
        blockAC.addAction(UIAlertAction(title: "back", style: .cancel))
        present(blockAC,animated: true)
        
        
        
      }
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }

    
    
    
    
   
 // *********** Controls methods ***********
    
 
 // provides a list of websites to open
    
    @objc func openTapped(){
        
        let ac = UIAlertController(title: "Open page", message: nil, preferredStyle: .actionSheet)
        
// ac.addAction(UIAlertAction(title: "apple.com", style: .default, handler: openPage))
// ac.addAction(UIAlertAction(title: "hackingwithswift.com", style: .default ,handler:openPage))
        
        for website in allowedWebsites {
            ac.addAction(UIAlertAction(title: website, style: .default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac,animated: true)
    }
 
// the function is called by openTapped() when one of the options gets selected
    
    func openPage(action:UIAlertAction){
        let url = URL(string:"https://"+action.title!)!
        webView.load(URLRequest(url:url))
        webView.allowsBackForwardNavigationGestures = true
    }


// Monitors the progress of loading a website
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            
        }
    }
 
}


