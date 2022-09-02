//
//  ViewController.swift
//  testNityaDemo
//
//  Created by Arun Sinthanaisirrpi on 2/9/2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let label = UILabel()
    private let button = UIButton(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Hello World"
        label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
        label.accessibilityIdentifier = "HelloWorld"
    }


}

