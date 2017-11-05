//
//  ViewController.swift
//  MemeMeAppOne
//
//  Created by Abhilash Khare on 10/8/17.
//  Copyright © 2017 Abhilash Khare. All rights reserved.
//

import UIKit

struct Meme {
    let topTextField : UITextField!
    let bottomTextField : UITextField!
    let originalimage : UIImage!
    let memedImage : UIImage!
}

class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var imageDisplay: UIImageView!
    
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
  
    @IBOutlet weak var bottomText: UITextField!
    
    let memeTextAttribute : [String : Any] = [ // MARK: TODO - need improvement, black outline, white text
        // NSAttributedStringKey.strokeColor.rawValue : UIColor.black,
        //  NSAttributedStringKey.backgroundColor.rawValue : UIColor.black,
        NSAttributedStringKey.foregroundColor.rawValue : UIColor.white,
        
        
        NSAttributedStringKey.font.rawValue : UIFont.init(name: "HelveticaNeue-CondensedBlack", size: 20)!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topText.text = "TOP"        // MARK: TODO - move to somewhere more appropriate
        bottomText.text = "BOTTOM"  // MARK: TODO - move to somewhere more appropriate
      
        topText.defaultTextAttributes = memeTextAttribute
        bottomText.defaultTextAttributes = memeTextAttribute
        topText.textAlignment = .center
        bottomText.textAlignment = .center
        topText.delegate = self
        bottomText.delegate = self
      
//             func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String)
//            -> Bool
//        {
//            var newText = textField.text! as NSString
//
//            newText = newText.replacingCharacters(in: range, with: string) as NSString
//            return true
//        }
        
  
    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
          NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(true)
        
        print("")
        print("In  ViewController.viewWillDisappear()")
        //IsFirstResponder in UIView if ui
         NotificationCenter.default.removeObserver(self,  name: NSNotification.Name.UIKeyboardWillShow, object: nil)
         NotificationCenter.default.removeObserver(self,  name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        
    }
    

    
    @objc func keyboardWillShow(notification : NSNotification)
        
    {
        
        let keyboardSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue
       self.view.frame.origin.y -= (keyboardSize?.cgRectValue.height)!
        
        
        
    }
    
    
    
    @objc func keyboardWillHide(notification : NSNotification)
        
    {
        
    let keyboardSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue
        self.view.frame.origin.y += (keyboardSize?.cgRectValue.height)!
        
        
        
    }
    


    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageSelected = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageDisplay.image = imageSelected
        dismiss(animated: true, completion: nil)
    }

    @IBAction func pickImageAlbum(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
        
        
    }
    
    
    @IBAction func pickImageCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        present(imagePicker, animated: true, completion: nil)
    }
    
  
        
       // func save(){
           //let meme = Meme(topTextField : topText.text!, bottomTextField : BottomText.text!, originalimage : //imageDisplay.image!, memedImage : memedImage!)
  //  }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("")
        print("In  ViewController.textFieldShouldReturn()")
        
        
        textField.resignFirstResponder()
        
        return true;
    }
    

    
}

