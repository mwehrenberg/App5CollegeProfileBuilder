//
//  DetailViewController.swift
//  App 5 - CollegeProfileBuilder
//
//  Created by John Wehrenberg on 7/3/17.
//  Copyright © 2017 Molly Wehrenberg. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var enrollmentTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var websiteTextField: UITextField!
    var urlForButton = String()
    let realm = try! Realm()
    
    var detailItem: College? {
        didSet {
            configureView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func configureView() {
        if let college = self.detailItem {
            if nameTextField != nil {
                nameTextField.text = college.name
                locationTextField.text = college.location
                enrollmentTextField.text = String(college.enrollment)
                imageView.image = UIImage(data : college.image)
                websiteTextField.text = college.websiteUrl
            }
        }
    }
    
    @IBAction func onGoButtonToSafari(_ sender: Any) {
        urlForButton = websiteTextField.text!
        let url = URL(string : urlForButton)!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func onTappedSaveButton(_ sender: Any) {
        if let college = self.detailItem {
            try! realm.write ({
                college.name = nameTextField.text!
                college.location = locationTextField.text!
                college.enrollment = Int(enrollmentTextField.text!)!
                college.image = UIImagePNGRepresentation(imageView.image!)!
                college.websiteUrl = websiteTextField.text!
            })
        }
    }
    
}

