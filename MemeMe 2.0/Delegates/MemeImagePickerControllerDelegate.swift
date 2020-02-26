//
//  MemeImagePickerControllerDelegate.swift
//  MemeMe 2.0
//
//  Created by Wolfgang Sigel on 14.02.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation
import UIKit

class MemeImagePickerControllerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imageView: UIImageView!
    var shareBarButtonItem: UIBarButtonItem!
    var parentController: UIViewController!
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            imageView.image = image
            shareBarButtonItem.isEnabled = true
        }
        parentController.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        parentController.dismiss(animated: true, completion: nil)
    }
}

