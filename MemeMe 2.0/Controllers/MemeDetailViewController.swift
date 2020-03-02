//
//  MemeDetailViewController.swift
//  MemeMe 2.0
//
//  Created by Wolfgang Sigel on 02.03.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var memeImageView: UIImageView!
    
    var meme: Meme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let meme = self.meme {
            memeImageView.image = meme.memedImage
        }
    }
}
