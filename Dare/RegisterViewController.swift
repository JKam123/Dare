//
//  RegisterViewController.swift
//  Dare
//
//  Created by Jan on 3/5/17.
//  Copyright © 2017 GKN. All rights reserved.
//

import UIKit
import Firebase
class RegisterViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordRetypeField: UITextField!
    @IBOutlet weak var imageViewer: UIImageView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var dateOfBirthPicker: UIDatePicker!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func choosePicture(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageViewer.contentMode = .scaleAspectFit
            imageViewer.image = pickedImage
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        let Mail = mailField.text ?? ""
        let Pw = passwordField.text ?? ""
        let PwRetype = passwordRetypeField.text ?? ""
        if ((Mail != "") && (Pw != "") && (PwRetype != "") && (Pw == PwRetype)) {
            FIRAuth.auth()?.createUser(withEmail: Mail, password: Pw) { (user, error) in
                if error != nil {
                    let alertController = UIAlertController(title: "Registration Failed", message:
                        error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)

                }
                else{
                    let Day = self.dateOfBirthPicker.date.timeIntervalSince1970
                    FireBaseDataBase().addUser(ID: (user?.uid)!,Mail: Mail, FN: self.firstNameField.text!, LN: self.lastNameField.text!, DoB: String(Day), ProfPic: self.imageViewer.image!   )
                    
                    let alertController = UIAlertController(title: "Registration Successful", message:
                        "The registration was successful! You will be forwarded to the login page now.", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                    
                    self.present(alertController, animated: true, completion: nil)
                    
                 
                    let storyboard = UIStoryboard(name: "Startup", bundle: nil)
                    let mainController = storyboard.instantiateViewController(withIdentifier: "LoginVC")
                    self.present(mainController, animated:true, completion:nil)

                }
            }

        }
        else{
            let alertController = UIAlertController(title: "Registration Failed", message:
                "The entered information is not correct!", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            
            

        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
