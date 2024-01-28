//
//  ViewController.swift
//  Project6
//
//  Created by Zach Nazarov on 17/01/2024.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.9)
        
        let label_1 = UILabel()
        label_1.translatesAutoresizingMaskIntoConstraints = false
        label_1.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        label_1.text = "        THESE"
        label_1.textColor = .white
        label_1.sizeToFit()
        
        let label_2 = UILabel()
        label_2.translatesAutoresizingMaskIntoConstraints = false
        label_2.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
        label_2.text = "        ARE"
        label_2.textColor = .white
        label_2.sizeToFit()
        
        let label_3 = UILabel()
        label_3.translatesAutoresizingMaskIntoConstraints = false
        label_3.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        label_3.text = "        SOME"
        label_3.textColor = .white
        label_3.sizeToFit()
        
        let label_4 = UILabel()
        label_4.translatesAutoresizingMaskIntoConstraints = false
        label_4.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        label_4.text = "        AWESOME"
        label_4.textColor = .white
        label_4.sizeToFit()
        
        let label_5 = UILabel()
        label_5.translatesAutoresizingMaskIntoConstraints = false
        label_5.backgroundColor = UIColor.cyan.withAlphaComponent(0.5)
        label_5.text = "        LABELS"
        label_5.textColor = .white
        label_5.sizeToFit()
        
        view.addSubview(label_1)
        view.addSubview(label_2)
        view.addSubview(label_3)
        view.addSubview(label_4)
        view.addSubview(label_5)
        
        let viewsDictionary = ["label_1":label_1,"label_2":label_2,"label_3":label_3,"label_4":label_4,"label_5":label_5]
        let metrics = ["labelHeight":90,"gap":0.5]
  
// ****** setting one label at a time
    
        
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label_1]|",options: [] ,metrics: nil, views: viewsDictionary))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label_2]|",options: [] ,metrics: nil, views: viewsDictionary))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label_3]|",options: [] ,metrics: nil, views: viewsDictionary))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label_4]|",options: [] ,metrics: nil, views: viewsDictionary))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[label_5]|",options: [] ,metrics: nil, views: viewsDictionary))

        
        
// ******* the VFL way of giving views constraints
        
        
//        for label in viewsDictionary.keys {
//            view.addConstraints(NSLayoutConstraint.constraints(
//                                                                withVisualFormat: "H:|[\(label)]|",
//                                                                options: [] ,
//                                                                metrics: nil,
//                                                                views: viewsDictionary))
//
//        }
//    
//        
//        
//        
//        view.addConstraints(NSLayoutConstraint.constraints( withVisualFormat:"""
//                                                                               V:|-50-[label_1(labelHeight@999)]-(gap)-\
//                                                                               [label_2(label_1)]-(gap)-\
//                                                                               [label_3(label_2)]-(gap)-\
//                                                                               [label_4(label_3)]-(gap)-\
//                                                                               [label_5(label_4)]-(>=10)-|
//                                                                               """,
//                                                                               options: [],
//                                                                               metrics: metrics,
//                                                                               views: viewsDictionary))
//        
        // @999 - priority where @1000 is absolutely required
        // -(gap)- a gap between labels
        // [label_2(label_1)] means ," the height of label_2 should be exactly the same as the height of label_1
        // V means vertical H - horizontal positions
        // | the edge of the screen ( view )
        
        
// ********** Providing constraints with anchors
        
        var previous: UILabel?
        
        for label in [label_1,label_2,label_3,label_4,label_5] {
            
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            
          
            
          
            if let previous = previous {
            
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 0.5).isActive = true
                let heighConstraint = label.heightAnchor.constraint(equalTo: previous.heightAnchor)
                heighConstraint.priority = UILayoutPriority(999)
                heighConstraint.isActive = true
                
                if previous == label_4 {
                    label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: 20).isActive = true
                }
                
                
            }else{
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
                var heightConstraint = label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor,multiplier: 0.2,constant: -10)
                heightConstraint.priority = UILayoutPriority(999)
                heightConstraint.isActive = true
                
            }
            
            previous = label
            
        }
    }


}


