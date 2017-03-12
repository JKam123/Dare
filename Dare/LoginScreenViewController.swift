//
//  LoginScreenViewController.swift
//  Dare
//
//  Created by Jan on 3/5/17.
//  Copyright © 2017 GKN. All rights reserved.
//

import UIKit
import Firebase
extension Date {
    var ticks: UInt64 {
        return UInt64((self.timeIntervalSince1970 + 62_135_596_800) * 10_000_000)
    }
}

class LoginScreenViewController: UIViewController {

    
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func testPressed(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: "test@mail.com", password: "12345678") { (user, error) in
            
        /*let L = Location(Name: "Test",Langitude: 11.22,Lattitude: 123.33,Description: "First Location", Type: 1, User: user.name, Timestamp: Date().ticks)
            
            FireBaseDataBase().addLocation(Loc: L)
 */
            //FireBaseDataBase().loadLocations()

        }
        
    }
    @IBAction func loginPressed(_ sender: Any) {
        let Mail = "test@mail.com"//mailField.text!
        let Pw = "12345678"//passwordField.text!
        print(Mail)
        print(Pw)
        FIRAuth.auth()?.signIn(withEmail: Mail, password: Pw) { (user, error) in
            if error != nil{
                let alertController = UIAlertController(title: "Login Failed", message:
                    error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)

            }
            let Status = user?.uid ?? "NONE"
            if Status != "NONE" && error == nil{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let mainController = storyboard.instantiateInitialViewController()
                self.present(mainController!, animated:true, completion:nil)
                
            }
            else{
                let alertController = UIAlertController(title: "Login Failed", message:
                    "The entered mail and/or password in wrong! Please try again.", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
                
                self.present(alertController, animated: true, completion: nil)
                
            }
            
        }

    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
