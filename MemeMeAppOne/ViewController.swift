//
//  ViewController.swift
//  MemeMeAppOne
//
//  Created by Abhilash Khare on 10/8/17.
//  Copyright © 2017 Abhilash Khare. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var imageDisplay: UIImageView!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var albumButton : UIBarButtonItem!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var share : UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    let memeTextAttribute : [String : Any] = [
   
    // MARK: TODO - need improvement, black outline, white text
         NSAttributedStringKey.strokeColor.rawValue : UIColor.black,
         NSAttributedStringKey.strokeWidth.rawValue : NSNumber(value : -5.0),
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

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(true)

         NotificationCenter.default.removeObserver(self,  name: NSNotification.Name.UIKeyboardWillShow, object: nil)
         NotificationCenter.default.removeObserver(self,  name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    

    
    @objc func keyboardWillShow(notification : NSNotification)
    {
        if(bottomText.isFirstResponder == true)
        {
        let keyboardSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue
       self.view.frame.origin.y -= (keyboardSize?.cgRectValue.height)!
        }
    }

    
    @objc func keyboardWillHide(notification : NSNotification)
    {
        if(bottomText.isFirstResponder==true)
        {
    let keyboardSize = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue
    self.view.frame.origin.y += (keyboardSize?.cgRectValue.height)!
        }
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    struct Meme {
        let topTextField : UITextField!
        let bottomTextField : UITextField!
        let originalimage : UIImage!
        let memedImage : UIImage!
    }

    
  //  func save(){
        
    //    let meme = Meme(topTextField : topText.text!, bottomTextField : bottomText.text!, originalimage : imageDisplay.image!, memedImage : generateMemedImage()!)
   //}

    @IBAction func generateMemedImage()  {
        
        // TODO: Hide toolbar and navbar
   
        self.albumButton.isEnabled = false
        let origColor:UIColor! = self.albumButton.tintColor
        self.albumButton.tintColor = UIColor.clear
        self.cameraButton.tintColor = UIColor.clear
        self.topToolbar.isHidden = true
        self.bottomToolbar.isHidden = true
        self.share.isEnabled = false
        self.share.tintColor = UIColor.clear
        
        
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        
        self.albumButton.isEnabled = true
        self.albumButton.tintColor = origColor
        self.cameraButton.tintColor = origColor
        self.topToolbar.isHidden = false
        self.bottomToolbar.isHidden = false
        self.share.isEnabled = true
        self.share.tintColor = origColor
      
        let ac : UIActivityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        self.present(ac, animated: true, completion: nil)
   
       // ac.completionWithItemsHandler =
         //   {
           //     (activityType,completed,items,errors) in
             //   if(completed)
               // {
                 //print ("shared")
                //}
        
       //     }
    
    }
    
}

