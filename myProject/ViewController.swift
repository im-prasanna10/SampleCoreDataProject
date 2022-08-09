//
//  ViewController.swift
//  myProject
//
//  Created by prasanna on 11/08/21.
//  Copyright © 2021 prasanna. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emailid: UILabel!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordid: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    self.hideKeyboard()
    }

     
    
    @IBAction func clickButton(_ sender: Any) {
        
        if email.text!.isEmpty || password.text!.isEmpty
        {
            let alert = UIAlertController(
                title: "Invalid Login",
                message: "Please fill user and password",
                preferredStyle: UIAlertController.Style.alert)
            
            let Go = UIAlertAction(title: "ok", style: .default) { (action) in

            }
            alert.addAction(Go)
            present(alert, animated: true, completion: nil)

            return
            
        }
        
        let secondViewController = storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    private func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
    
}

extension UIView {
    
    private func applyGradient(colours: [UIColor]) -> CAGradientLayer {
        return self.applyGradient(colours: colours, locations: nil)
    }
    
    private func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {

        let firstColor =  UIColor(red: 251/255, green: 0/255, blue: 54/255, alpha: 1.0)
        let secondColor = UIColor(red: 250/255, green: 150/255, blue: 35/255, alpha: 1.00)
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
        return gradient
    }
}


extension UIViewController {

func showToast(message : String, font: UIFont) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.center.x-50, y: self.view.center.y, width: 150, height: 35))
    toastLabel.backgroundColor = UIColor.black.withAlphaComponent(1)
    toastLabel.textColor = UIColor.white
    toastLabel.font = font
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
} }

