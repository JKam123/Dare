//
//  LoginRegisterViewController.swift
//  Dare
//
//  Created by Jan on 3/5/17.
//  Copyright © 2017 GKN. All rights reserved.
//

import UIKit

class LoginRegisterViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 0.2
        registerButton.layer.cornerRadius = 0.2
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginScreenViewController
        self.navigationController?.pushViewController(myVC, animated: true)
    }

    @IBAction func registerPressed(_ sender: Any) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "RegisterVC") as! RegisterViewController
        self.navigationController?.pushViewController(myVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
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
