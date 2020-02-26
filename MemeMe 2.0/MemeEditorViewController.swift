//
//  MemeEditorViewController.swift
//  MemeMe 2.0
//
//  Created by Wolfgang Sigel on 06.02.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var photoBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var textFieldTop: UITextField!
    @IBOutlet weak var textFieldBottom: UITextField!
    @IBOutlet weak var shareBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var cancelBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    let memeTextFieldDelegate = MemeTextFieldDelegate()
    let memeImagePickerControllerDelegate = MemeImagePickerControllerDelegate()
    let imagePickerController = UIImagePickerController()
    
    // used to prevent that imageview doesn't slide up twice
    // since keyboardWillShow() initially fires twice:
    // (1) when textfield is selected (2) when first character entered
    var keyboardIsShown: Bool = false
    
    var meme: Meme?
    
    
    // MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup textfield properties
        configureMemeTextFields(textField: textFieldTop, textFieldDelegate: memeTextFieldDelegate)
        configureMemeTextFields(textField: textFieldBottom, textFieldDelegate: memeTextFieldDelegate)
        
        //setuo ImagePickerController & its delegate
        imagePickerController.delegate = memeImagePickerControllerDelegate
        memeImagePickerControllerDelegate.imageView = self.imageView
        memeImagePickerControllerDelegate.shareBarButtonItem = self.shareBarButtonItem
        memeImagePickerControllerDelegate.parentController = self
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        photoBarButtonItem.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        shareBarButtonItem.isEnabled = imageView.image != nil
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: TextField configuration
    
    // IMPORTANT: set defaultTextAttributes BEFORE textAlignment. Otherwise the alignment doesn't work!!!
    func configureMemeTextFields( textField: UITextField, textFieldDelegate: MemeTextFieldDelegate)
    {
        textField.delegate = textFieldDelegate
        textField.defaultTextAttributes = configureMemeTextAttributes()
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 17.0
        
    }
    
    func configureMemeTextAttributes() -> [NSAttributedString.Key: Any] {
        return [
            NSAttributedString.Key.strokeColor: UIColor.black,
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedString.Key.strokeWidth: 0
        ]
    }
    

    // MARK: Keyboard notifications, events & functions
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if textFieldBottom.isFirstResponder && !keyboardIsShown {
            view.frame.origin.y -= getKeyboardHeight(notification)
            keyboardIsShown = true
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if textFieldBottom.isFirstResponder && keyboardIsShown {
            view.frame.origin.y = 0
            keyboardIsShown = false
        }
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    // MARK: Button Actions
    
    @IBAction func bottomToolbarBarButtonItemClick(_ sender: Any){
        if (sender as! UIBarButtonItem).tag == 1 {
            imagePickerController.sourceType = .photoLibrary
        }
        else {
            imagePickerController.sourceType = .camera
        }
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonClick(_ sender: Any) {
        imageView.image = nil
        textFieldTop.text = "TOP"
        textFieldBottom.text = "BOTTOM"
        shareBarButtonItem.isEnabled = false
    }
    
    @IBAction func shareMemeButtonClick(_ sender: Any) {
        let currentMemedImage = generateMemedImage()
        let imageToShare = [ currentMemedImage ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {
            (activityType: UIActivity.ActivityType?, completed: Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if !completed {
                return
            } else {
                self.save(_topText: self.textFieldTop.text ?? "", _bottomText: self.textFieldBottom.text ?? "", _originalImage: self.imageView.image!, _memedImage: currentMemedImage)
                return
            }
        }
        present(activityViewController, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
        return memedImage
    }
    
    func save(_topText: String, _bottomText: String, _originalImage: UIImage, _memedImage: UIImage){
        self.meme = Meme(topText: _topText, bottomText: _bottomText, originalImage: _originalImage, memedImage: _memedImage)
        print(self.meme!.bottomText)
    }
}

