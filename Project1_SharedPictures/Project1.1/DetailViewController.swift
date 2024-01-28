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
    var imageName:String?
    var name = "default"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageTitle = self.imageTitle { title = imageTitle }
        if let imageName = self.imageName { name = imageName}
      
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
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
    
    @objc  func shareTapped(){
        guard let image = imageView.image?.jpegData(compressionQuality: 1.0) else {
            print("no image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image,name], applicationActivities: nil)
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc,animated: true)
    }
}

