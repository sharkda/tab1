//
//  SecondViewController.swift
//  tab1
//
//  Created by Jim Hsu on 2019/5/17.
//  Copyright © 2019 shark.com.tw. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .cantaloupe
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.backgroundColor = .turquiose
        navigationItem.title = "Second"
        setupButton()
    }
    let forthVC = ForthViewController() 
    func sequesToForthVC(){
        self.navigationController?.pushViewController(forthVC, animated: true)
    }
    
    func setupButton(){
        view.addSubview(button)
        button.centerInSuperview()
        button.addTarget(self, action: #selector(handler1), for: .touchUpInside)
    }
    @objc func handler1(sender: UIButton!) {
        //var alertView = UIAlertView()
        print("pressed")
        sequesToForthVC()
    }
    let button:UIButton = {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 180)
        let button = UIButton(frame: frame)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 50 )
        button.setTitle("Seques", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.mocha
        button.setTitleColor(.moonstone, for: .normal)
        button.tintColor = UIColor.calpoly
        button.layer.cornerRadius = 20
        return button
    }()

}

