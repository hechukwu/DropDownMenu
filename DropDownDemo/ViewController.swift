//
//  ViewController.swift
//  DropDownDemo
//
//  Created by Henry Chukwu on 23/02/2021.
//

import UIKit
import DropDownMenu

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let vc = PresentingViewController()
        vc.show(view: view)
    }


}

