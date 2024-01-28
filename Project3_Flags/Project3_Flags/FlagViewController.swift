//
//  FlagViewController.swift
//  Project3
//
//  Created by Zach Nazarov on 14/11/2023.
//

import UIKit

class FlagViewController: UIViewController {

    // connecting the imageView from the storyboard to our code
    @IBOutlet var flagImageView: UIImageView!
    
    var flagImage:UIImage?
    var flagTitleString:String?
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // assigning an image to the imageView ( if any image is provided )
        if let flagImage = self.flagImage {
            flagImageView.image = flagImage
            
            
        }
        if let flagTitleString = self.flagTitleString {
            name = flagTitleString
        }
        // creating an arrow-pointing-out-of-box (.action) button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(sharedTapped))
        
    }
    
    @objc func sharedTapped(){
        // compressing the imageView's image into a jpeg file ready to be shared
        guard let image = flagImageView.image?.jpegData(compressionQuality: 0.8) else{
            print("no image found")
            return
        }
        // initializing and presenting a UIActivity controller that contains various sharing options
        let shareFlagController = UIActivityViewController(activityItems: [image,name], applicationActivities: nil)
       present(shareFlagController,animated: true)
        
    }
    
}
                                                                
                                                                
                                                                
        
                                                                
     
                                                                
                                                                
                                                                
                                                                
