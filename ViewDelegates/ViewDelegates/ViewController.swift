// //  ViewController.swift //  ViewDelegates //
//  Created by Zach Nazarov on 28/12/2023.
//

import UIKit

class ViewController: UIViewController,NotificationSettingViewDelegate {
   
    // ViewController is now a delegate of NotificationsSettingView
    // NotificationSettingView has a var called 'delegate'


    private var notificationsView = NotificationSettingView()
    
    override func viewDidLoad() {  
        super.viewDidLoad()
        view.addSubview(notificationsView)
        // after we asign the delegate to ViewController NotificationSettingView can tell its  delegate (ViewController ) what tasks should be performed
        notificationsView.delegate = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        notificationsView.frame = CGRect(x: 10, y: view.safeAreaInsets.top,
                                         width: view.frame.size.width - 20 ,
                                         height: view.frame.size.height - view.safeAreaInsets.top)
    }

    
    func didTapEnableButton() {
        let ac = UIAlertController(title: "Enabled Notifications", message: nil, preferredStyle: .alert )
        ac.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(ac,animated: true)
    }
}












protocol NotificationSettingViewDelegate:AnyObject{
    func didTapEnableButton()
}








class NotificationSettingView: UIView {
    
    weak var delegate:NotificationSettingViewDelegate?
    
    private let imageView:UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "bell")
        imageView.tintColor = .systemBlue
        return imageView
    }()
    
    
     let button:UIButton = {
        
       let button = UIButton()
        button.setTitle("Enable Notifications", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.addTarget(nil , action: #selector(buttonTapped), for: .touchUpInside)
         //button.addTarget(target: self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    let label:UILabel = {
       
        let label = UILabel()
        label.text = "to stay up to date enable Push notifications "
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        addSubview(button)
        addSubview(label)
        addSubview(imageView)
    
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func buttonTapped(){
        // when the button is tapped
        // this line really says , " Tell my delegate to run didTapEnableButton()
        delegate?.didTapEnableButton()
       

    }
  
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = bounds.size.width / 2
        imageView.frame = CGRect(x: (bounds.size.width - imageSize)/2, y: 30,
                                 width: imageSize, height: imageSize)
        label.frame = CGRect(x: 10, y: 30+imageSize+20, width: frame.size.width - 20 , height: 100)
        button.frame = CGRect(x: 40, y: 160+imageSize, width: frame.size.width-80, height: 60)
        
    }
    
    
    
    
}
