//
//  ViewController.swift
//  Project4.1
//
//  Created by Zach Nazarov on 20/12/2023.
//

import UIKit
import WebKit
class ViewController: UITableViewController {

    let websites = ["google.com","apple.com","hackingwithswift.com","yandex.ru","github.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WebAddress", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "WebPage") as? WebViewController {
            
            vc.url = URL(string:"https://"+websites[indexPath.row])
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }


}

