

import UIKit
import WebKit

class ReadMoreViewController: UIViewController {
    
    var webView:WKWebView!
    var detailedItem:Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailedItem = detailedItem else {return}
        
   
        // a URL to be displayed
        
let html = """
<html>
<head>
<meta name="viewport" content="width=device-width,initial-scale=1">
<style>
h1 { font-size: 135% ; }
p  { font-size: 127% ; }
 </style>
</head>
<body style="background-color:BlanchedAlmond;">
<h1>
\(detailedItem.title)
</h1>
<p>
\(detailedItem.body)
</p>
</body>
</html>
"""
               
webView.loadHTMLString(html, baseURL: nil)
        
      
       

        
    }
    


}
