//
//  ThirdViewController.swift
//  myProject
//
//  Created by prasanna on 11/08/21.
//  Copyright © 2021 prasanna. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation
import MapKit

class ThirdViewController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate, CLLocationManagerDelegate, MKMapViewDelegate{
    
//    @IBOutlet weak var details: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var regno: UILabel!

    
    @IBOutlet weak var imageBut: UIButton!
    @IBOutlet var saveBtn: UIButton!
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var regText: UITextField!
    
    @IBOutlet var mapView: MKMapView!
    var locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    var myLocation:CLLocationCoordinate2D?
    var userLatitude:Double = 8.713913
    var userLongitude:Double = 77.756652
    var centerMapFirstTime: Int = 0
    
    var newImageData :Data!
    var imagePicker = UIImagePickerController()
    
    var dic1: Userr!
    
    var randno = String()
    var dateTxt = String()
 
    var datePicker :UIDatePicker!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        configureView()
        createDatePicker()
        configureMapView()
        configureDatePicker()
    
        let doneButton = UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(self.datePickerDone))
        let toolBar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 44))
        toolBar.setItems([UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil), doneButton], animated: true)
        
        self.saveBtn.layer.cornerRadius = 25.0
        self.saveBtn.clipsToBounds = true
        regText.inputAccessoryView = toolBar
        
        self.hideKeyboard()
    }
    
    private func configureView(){
        nameText.delegate = self
        ageText.delegate = self
        regText.delegate = self
        imagePicker.delegate = self
        imageBut.imageView?.contentMode = . scaleAspectFit
        if dic1 == nil {
        }else{
            randno = dic1.random!
            newImageData = dic1.imagedata //image is getting as value from dictionary.
            let imageview = UIImage(data: dic1.value(forKey: "imagedata") as! Data)
            imageBut.setImage(imageview, for: .normal)
            nameText.text = dic1.name
            ageText.text = dic1.age
            regText.text = dic1.regNo
            gender.text = dic1.gender
        }
    }
    
    private func configureDatePicker(){
        datePicker = UIDatePicker.init(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 200))
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        regText.inputView = datePicker
        
        let date = Date()
        print(date)
        let formatter = DateFormatter()
        formatter.dateFormat = "DDMMYYYYHHmmSS"
        randno = formatter.string(from: date)
    }
    
    private func configureMapView(){
        mapView.delegate = self
        mapView.mapType = .standard
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isUserInteractionEnabled = true
        self.showUserLocationForGivenlatitudelongitudeWith(latitude: userLatitude, longitude: userLongitude)
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations
                            locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        
        mapView.mapType = MKMapType.standard
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "You are Here"
        mapView.addAnnotation(annotation)
    }
    
    func showUserLocationForGivenlatitudelongitudeWith(latitude:Double, longitude:Double) -> Void {
       
        let cLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let newAnotation:MKPointAnnotation = MKPointAnnotation()
        newAnotation.coordinate = cLLocationCoordinate2D
        let location = CLLocation(latitude: cLLocationCoordinate2D.latitude, longitude: cLLocationCoordinate2D.longitude)
        if (location.coordinate.latitude != 0.0) && (location.coordinate.longitude != 0.0) {
            if (centerMapFirstTime == 0) {
                mapView.setCenter(location.coordinate, animated: true)
                let newRegion = MKCoordinateRegion(center:location.coordinate , span: MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007))
                mapView.setRegion(newRegion, animated: true)
            }
            centerMapFirstTime = 1
        }
        
        self.geocoder.reverseGeocodeLocation(location) {
            (placemarks, error) -> Void in
            if let placemarks = placemarks, placemarks.count > 0 {
                let placemark = placemarks[0] as CLPlacemark
                
                var annotationTitleStr: String = ""
                var annotationSubTitleStr: String = ""
                if (placemark.name != nil) {
                    annotationTitleStr = (annotationTitleStr + placemark.name! as String)
                }
                if (placemark.subThoroughfare != nil) {
                    annotationTitleStr = (annotationTitleStr + placemark.subThoroughfare! as String + ",")
                }
                if (placemark.subLocality != nil) {
                    annotationSubTitleStr = (annotationSubTitleStr + placemark.subLocality! as String + ",")
                }
                if (placemark.administrativeArea != nil) {
                    annotationSubTitleStr = (annotationSubTitleStr + placemark.administrativeArea! as String + ",")
                }
                if (placemark.locality != nil) {
                    annotationSubTitleStr = (annotationSubTitleStr + placemark.locality! as String + "-")
                }
                if (placemark.postalCode != nil) {
                    annotationSubTitleStr = (annotationSubTitleStr + placemark.postalCode! as String + ",")
                }
                if (placemark.country != nil) {
                    annotationSubTitleStr = (annotationSubTitleStr + placemark.country! as String )
                }
                let newAnotation = MKPointAnnotation()
                newAnotation.title = annotationTitleStr
                newAnotation.subtitle = annotationSubTitleStr
                
                if self.gender != nil {
                    self.gender.text = "Location: \(annotationTitleStr + "," + annotationSubTitleStr)"
                }
            
                if self.mapView != nil {
                    self.mapView.showsUserLocation = true
                    self.mapView.removeAnnotations(self.mapView.annotations)
                    self.mapView.addAnnotation(newAnotation)
                }
            }
        }
    }
    
    @objc func datePickerDone() {
        regText.resignFirstResponder()
    }
    
    @objc func dateChanged() {
        
        let newFomat = DateFormatter()
        newFomat.dateFormat = "dd MMM yyyy"
        regText.text = newFomat.string(from: datePicker.date)
    }
    
    func createDatePicker(){
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(imageButton))
        toolBar.setItems([doneBtn], animated: true)
        
        regText.inputAccessoryView = toolBar
        regText.inputView = datePicker

    }
    
    
    @IBAction func imageButton(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallary()
        }))
        alert.addAction(UIAlertAction(title: "Album", style: .default, handler: { _ in
            self.savedPhotoAlbum()
        }))
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .destructive, handler: nil))
  
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        if nameText.text!.isEmpty || ageText.text!.isEmpty || gender.text!.isEmpty || regText.text!.isEmpty
        {
                let alert = UIAlertController(
                title: "Invalid Save",
                message: "Please fill the details",
                preferredStyle: UIAlertController.Style.alert)
            
            let Go = UIAlertAction(title: "OK", style: .default) { (action) in
                
            }
            
            alert.addAction(Go)
            present(alert, animated: true, completion: nil)
            return
            
        }else if newImageData == nil{
           
            let alert = UIAlertController(
                title: "Invalid Save",
                message: "Please Upload Profile Picture",
                preferredStyle: UIAlertController.Style.alert)
            
            let Go = UIAlertAction(title: "OK", style: .default) { (action) in
                
            }
            
            alert.addAction(Go)
            present(alert, animated: true, completion: nil)
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Userr")
        if (dic1.name != nil){
            request.predicate = NSPredicate(format: "name == %@", dic1.name!)
        }
        do {
            
            let result = try! managedContext.fetch(request)
            
            if result.count > 0{
               
                let userObj = result[0] as! NSManagedObject
                userObj.setValue(randno, forKey: "random")
                userObj.setValue(newImageData, forKey: "imagedata")
                userObj.setValue(nameText.text, forKey: "name")
                userObj.setValue(ageText.text, forKey: "age")
                userObj.setValue(regText.text, forKey:"regNo")
                userObj.setValue(gender.text , forKey: "gender")
                
                do{
                    try! managedContext.save()
                }
                
            }else{
                
                let  entityDescription = NSEntityDescription.entity(forEntityName: "Userr", in: managedContext)!
                
                let userObj = NSManagedObject(entity:  entityDescription, insertInto: managedContext)
                
                userObj.setValue(randno, forKey: "random")
                userObj.setValue(newImageData, forKey: "imagedata")
                userObj.setValue(nameText.text, forKey: "name")
                userObj.setValue(ageText.text, forKey: "age")
                userObj.setValue(regText.text, forKey:"regNo")
                userObj.setValue(gender.text , forKey: "gender")
                
                do{
                    try! managedContext.save()
                }
                
            }
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String)
            }
            
        } catch {
            print("Failed")
        }
        
        let secondViewController = storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.navigationController?.pushViewController(secondViewController, animated: true)
        secondViewController.showToast(message: "Data saved successfully", font: .systemFont(ofSize: 12.0))
//        self.navigationController?.popViewController(animated: true)
    }
    
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            imagePicker.sourceType = .camera
            imagePicker.allowsEditing = true
            imagePicker.mediaTypes = ["public.image"]
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
     func openGallary()

    {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = ["public.image"]
        self.present(imagePicker, animated: true, completion: nil)
    }
     func savedPhotoAlbum(){
        
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = true
        imagePicker.mediaTypes = ["public.image"]
        self.present(imagePicker,animated:true,completion:nil)
    }
    
     func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageBut.setImage(image, for: .normal)
        newImageData = image.jpegData(compressionQuality: 0.2)
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    private func hideKeyboard()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(ThirdViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}


