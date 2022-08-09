//
//  FourthViewController.swift
//  myProject
//
//  Created by prasanna on 11/08/21.
//  Copyright © 2021 prasanna. All rights reserved.
//

import UIKit
import CoreData

class FourthViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var regNoLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var Dic : Userr!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = Dic.value(forKey: "name") as? String
        ageLabel.text = Dic.value(forKey:"age") as? String
        regNoLabel.text = Dic.value(forKey: "regNo") as? String
        genderLabel.text = Dic.value(forKey: "gender") as? String
        
        let sampleimage = UIImage.init(data: Dic.value(forKey: "imagedata") as! Data)
        imageView.image = sampleimage
    }
    
    @IBAction func editButton(_ sender: Any) {
        
        let thirdViewController = storyboard!.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        thirdViewController.dic1 = Dic
        self.navigationController?.pushViewController(thirdViewController, animated: true)
        
    }
    
    @IBAction func deleteButton(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        do {
            managedContext.delete(Dic)
        }
        self.navigationController?.popViewController( animated: true)
        
    }
}
