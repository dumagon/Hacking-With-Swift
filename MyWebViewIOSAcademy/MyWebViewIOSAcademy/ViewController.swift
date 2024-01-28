

import UIKit


class ViewController: UIViewController {
    
    private let button:UIButton = {
        let button = UIButton()
        button.setTitle("Open page", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .link
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonDidTapped), for: .touchUpInside)
        button.frame = CGRect(x: 0  , y: 0, width: 220, height: 50)
        button.center = view.center

    }
    @objc private func buttonDidTapped(){
        guard let url = URL(string:"https://www.apple.com") else {return}
        let  vc = WebViewController(url: url, title: "apple")
        let nVC = UINavigationController(rootViewController: vc)
        present(nVC,animated: true)
    }

}

