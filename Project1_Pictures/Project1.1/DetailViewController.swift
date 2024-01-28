//
//  DetailViewController.swift
//  Project1.1
//
//  Created by Zach Nazarov on 31/10/2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var selectedImage:String?
    var imageTitle:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageTitle = self.imageTitle { title = imageTitle
        }
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.hidesBarsOnTap = false 
    }
    
}

