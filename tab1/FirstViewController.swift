//
//  FirstViewController.swift
//  tab1
//
//  Created by Jim Hsu on 2019/5/17.
//  Copyright © 2019 shark.com.tw. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .salt
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.title = "first"
        
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        setupLayout()
    }
    
    let leftBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Left Item", style: .plain, target: self, action: nil)
        barButtonItem.tintColor = UIColor.red
        return barButtonItem
    }()
    let rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Right Item", style: .plain, target: self, action: nil)
        barButtonItem.tintColor = UIColor.blue
        return barButtonItem
    }()
    
    let thirdVC = ThirdViewController()
    func sequesToThirdVC(){
        self.navigationController?.pushViewController(thirdVC, animated: true)
    }
    var stack1:UIStackView!
    func setupLayout(){
        
        button1.addTarget(self, action: #selector(handler1), for: .touchUpInside)
        button2.addTarget(self, action: #selector(handler2), for: .touchUpInside)
        button3.addTarget(self, action: #selector(handler3), for: .touchUpInside)
        button4.addTarget(self, action: #selector(handler4), for: .touchUpInside)
        stack1 = UIStackView(arrangedSubviews: [button1, button2, button3, button4])
        stack1.axis = .vertical
        stack1.spacing = 10.0
        view.addSubview(stack1)
        stack1.centerInSuperview()
    
    }
    @objc func handler1(sender: UIButton!) {
        //var alertView = UIAlertView()
        print("1 pressed")
        sequesToThirdVC()
    }
    @objc func handler2(sender: UIButton!) {
        //var alertView = UIAlertView()
        print("2 pressed")
    //navigationController?.setNavigationBarHidden(!navigationController!.isNavigationBarHidden, animated: true)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .black
    }
    @objc func handler3(sender: UIButton!) {
        //var alertView = UIAlertView()
        print("3 pressed")
        navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    @objc func handler4(sender: UIButton!) {
        //var alertView = UIAlertView()
        print("4 pressed")
        navigationController?.popViewController(animated: true)
    }
    let button1:UIButton = {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 180)
        let button = UIButton(frame: frame)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25 )
        button.setTitle("Seques", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.grape
        button.setTitleColor(.lace, for: .normal)
        button.tintColor = UIColor.calpoly
        button.layer.cornerRadius = 10
        return button
    }()
    let button2:UIButton = {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 180)
        let button = UIButton(frame: frame)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25 )
        button.setTitle("toggle NavBar", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.sepia
        button.setTitleColor(.lace, for: .normal)
        button.tintColor = UIColor.calpoly
        button.layer.cornerRadius = 10
        return button
    }()
    
    let button3:UIButton = {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 180)
        let button = UIButton(frame: frame)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25 )
        button.setTitle("push", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.iron
        button.setTitleColor(.lace, for: .normal)
        button.tintColor = UIColor.calpoly
        button.layer.cornerRadius = 10
        return button
    }()
    
    let button4:UIButton = {
        let frame = CGRect(x: 0, y: 0, width: 200, height: 180)
        let button = UIButton(frame: frame)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25 )
        button.setTitle("pop", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor.moss
        button.setTitleColor(.lace, for: .normal)
        button.tintColor = UIColor.calpoly
        button.layer.cornerRadius = 10
        return button
    }()
}

