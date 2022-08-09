//
//  SecondViewController.swift
//  myProject
//
//  Created by prasanna on 11/08/21.
//  Copyright © 2021 prasanna. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UINavigationControllerDelegate {
    

    @IBOutlet weak var table: UITableView!
    
     var arr = NSArray()
     var Dic : Userr!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "ThirdViewController")
        self.view.addSubview(table)
        self.table.register(UINib.init(nibName: "MyProjectTableViewCell", bundle: nil), forCellReuseIdentifier: "MyProjectTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.fetchData()
    }
    
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cells = tableView.dequeueReusableCell(withIdentifier: "MyProjectTableViewCell") as! MyProjectTableViewCell
        if arr.count == 0{
        }else{
            cells.nameLbl.text =  (arr[indexPath.row] as AnyObject).value(forKey: "name") as? String
            cells.dobLbl.text = (arr[indexPath.row] as AnyObject).value(forKey: "regNo") as? String
            let sampleimage = UIImage.init(data: (arr[indexPath.row] as AnyObject).value(forKey: "imagedata") as! Data)
            DispatchQueue.main.async {
                cells.imgView.image = sampleimage
            }
        }
        return cells
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let fourthViewController = storyboard!.instantiateViewController(withIdentifier: "FourthViewController") as! FourthViewController
        fourthViewController.Dic = arr[indexPath.row] as? Userr
        self.navigationController?.pushViewController(fourthViewController, animated: true)
        
}
    
    /// <#Description#>
    func fetchData() {
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Userr")
        
        do {
            arr = try! managedContext!.fetch(request) as NSArray
            if arr.count == 0{
                let alert = UIAlertController(
                    title: "Empty List",
                    message: "Click On '+' to add New Entry ",
                    preferredStyle: UIAlertController.Style.alert)
                
                let Go = UIAlertAction(title: "OK", style: .default) { (action) in
                }
                alert.addAction(Go)
                present(alert, animated: true, completion: nil)
                return
            }
        }
        table.reloadData()
    }
}



