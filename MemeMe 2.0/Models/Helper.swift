//
//  Helper.swift
//  MemeMe 2.0
//
//  Created by Wolfgang Sigel on 08.03.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    static func showDetailView(indexPath: IndexPath, parent: UIViewController){
        let memeDetailVC = parent.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        let meme = appDelegate.memes[indexPath.row]
        memeDetailVC.meme = meme
        parent.navigationController!.pushViewController(memeDetailVC, animated: true)
    }
}
