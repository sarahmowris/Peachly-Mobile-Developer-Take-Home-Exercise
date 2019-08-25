//
//  ViewController.swift
//  Peachly Mobile Exercise
//
//  Created by Sarah Mowris on 8/22/19.
//  Copyright © 2019 Sarah Mowris. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var firstnameValidation: UILabel!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var lastnameValidation: UILabel!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var emailValidation: UILabel!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var messageCount: UILabel!
    @IBOutlet weak var messageValidation: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        message.delegate = self
        message.text = "Message"
        message.textColor = UIColor.lightGray
        messageCount.text = "0/500"
        emailValidation.isHidden = true
        firstnameValidation.isHidden = true
        lastnameValidation.isHidden = true
        messageValidation.isHidden = true
    }
    
    
    //Character Count
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let countCharacter = (textView.text?.count)! + text.count - range.length
        if (countCharacter <= 500) {
            self.messageCount.text = "\(0 + countCharacter)/500"
            return true
        } else {
            return false
        }
    }
    
    //Email Validation
    func validEmail(email : String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let check = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return check.evaluate(with:email)
    }
    
    
    func submit() {
        firstnameValidation.isHidden = true
        lastnameValidation.isHidden = true
        emailValidation.isHidden = true
        messageValidation.isHidden = true
        
        if firstName.text!.count == 0  {
            firstnameValidation.isHidden = false
            firstnameValidation.text = "Required Field"
        }
        if lastName.text!.count == 0  {
            lastnameValidation.isHidden = false
            lastnameValidation.text = "Required Field"
        }
        if messageCount.text == "0/500" {
            messageValidation.isHidden = false
            messageValidation.text = "Required Field"
        }
        if email.text!.count == 0 {
            emailValidation.isHidden = false
            emailValidation.text = "Required Field"
        } else if validEmail(email: email.text!) == false {
            emailValidation.isHidden = false
            emailValidation.text = "Please enter a valid email address"
        }
    }
    
    //Creating Placeholder in Text View
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Message"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
    //POST Request
    @IBAction func submitButton(_ sender: UIButton) {
        
        self.submit()
        
        var validMessage : String = ""
        if  messageCount.text != "0/500" {
            validMessage = message.text!
        }
        
        var validateEmail : String = ""
        if validEmail(email: email.text!) {
            validateEmail = email.text!
        }
        
        
        let parameters = [
            "first" : firstName.text!,
            "last" : lastName.text!,
            "email" : validateEmail,
            "message" : validMessage
            ]
        
        //create URL
        let url = URL(string : "http://52.15.184.142:80/feedback")
        
        //create URL Request
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do  {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch let error {
            print(error.localizedDescription)
        }
        
        //create session
        let session = URLSession.shared
        
        
        //create dataTask
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {return}
            guard let data = data else {return}
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions())  as? [String: String] {
                    print(json)
                }
            } catch {
                print(error)
            }
        }.resume()
    }
    
}

