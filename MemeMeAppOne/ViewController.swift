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
    
    var savedMeme : UIImage!
    let memeTextAttribute : [String : Any] = [
   
   
         NSAttributedStringKey.strokeColor.rawValue : UIColor.black,
         NSAttributedStringKey.strokeWidth.rawValue : NSNumber(value : -5.0),
        NSAttributedStringKey.foregroundColor.rawValue : UIColor.white,
        NSAttributedStringKey.font.rawValue : UIFont.init(name: "HelveticaNeue-CondensedBlack", size: 20)!
    ]
    
    func configText(textField : UITextField)
    {
        textField.defaultTextAttributes = memeTextAttribute
        textField.textAlignment = .center
        textField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        configText(textField: topText)
        configText(textField: bottomText)

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
        if(bottomText.isFirstResponder)
        {
          
        let keyboardSize = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue
       self.view.frame.origin.y -= (keyboardSize?.cgRectValue.height)!
       
        }
    }

    
    @objc func keyboardWillHide(notification : NSNotification)
    {
        if(bottomText.isFirstResponder==true)
        {
          
            self.view.frame.origin.y = 0
        
        }
    }
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let imageSelected = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageDisplay.image = imageSelected
        dismiss(animated: true, completion: nil)
    }

   func configPickImage(sourceType: UIImagePickerControllerSourceType)
    {
          let imagePicker = UIImagePickerController()
            imagePicker.sourceType = sourceType
           imagePicker.delegate = self
           present(imagePicker, animated: true, completion: nil)

    }
    
    @IBAction func pickImagePhoto(_ sender: Any) {
     configPickImage(sourceType: .photoLibrary)
  
    }
    
    
    @IBAction func pickImageCamera(_ sender: Any) {
        configPickImage(sourceType: .camera)
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

    
    func save(){
        let meme = Meme(topTextField : topText, bottomTextField : bottomText, originalimage : imageDisplay.image, memedImage : savedMeme)
  
    }

    func configValueBarButton(textField : UIBarButtonItem, value : Bool, color : UIColor)
    {
        
        textField.isEnabled = value
        textField.tintColor = color
    }
    
    func configToolbar(toolbar : UIToolbar, value : Bool)
    {
        toolbar.isHidden = value
    }
    
    @IBAction func generateMemedImage()  {
        
        // TODO: Hide toolbar and navbar
   
        configValueBarButton(textField: albumButton, value: false, color: UIColor.clear)
        configValueBarButton(textField: cameraButton, value: false, color: UIColor.clear)
        configValueBarButton(textField: share, value: false, color: UIColor.clear)
        configToolbar(toolbar: topToolbar, value: true)
        configToolbar(toolbar: bottomToolbar, value: true)
        
        let origColor:UIColor! = self.albumButton.tintColor
      
  
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        savedMeme = memedImage
        // TODO: Show toolbar and navbar
        
        configValueBarButton(textField: albumButton, value: true, color: origColor)
        configValueBarButton(textField: cameraButton, value: true, color: origColor)
        configValueBarButton(textField: share, value: true, color: origColor)
        
        configToolbar(toolbar: topToolbar, value: false)
        configToolbar(toolbar: bottomToolbar, value: false)
       
        let ac : UIActivityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        self.present(ac, animated: true, completion: nil)
        
        ac.completionWithItemsHandler =
            {
                (activityType,completed,items,errors) in
                if(completed)
                {
                 self.save()
                }
        
            }
     
    
    }
    
}

