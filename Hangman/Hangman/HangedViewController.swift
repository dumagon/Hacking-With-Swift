//
//  HangedViewController.swift
//  Hangman
//
//  Created by Zach Nazarov on 25/02/2024.
//

import UIKit

class HangedViewController: UIViewController {
    
    var imageView:UIImageView?
    var image:UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
       
    }
    
    private func configureUI(){
        
        view.backgroundColor = .black
        
        image = UIImage(named: "noose")
        imageView = UIImageView(image: image)
        imageView?.backgroundColor = .black
        imageView?.translatesAutoresizingMaskIntoConstraints = false
                
        guard let imageView = imageView else{return}
        
        self.view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
        
            imageView.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.8),
            imageView.heightAnchor.constraint(equalTo: view.layoutMarginsGuide.heightAnchor, multiplier: 0.5)
        
        ])
        
        
        
        
        
        
    }

}
