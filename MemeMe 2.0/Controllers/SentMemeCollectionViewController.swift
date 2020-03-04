//
//  SentMemeCollectionViewController.swift
//  MemeMe 2.0
//
//  Created by Wolfgang Sigel on 03.03.20.
//  Copyright © 2020 Wolfgang Sigel. All rights reserved.
//

import Foundation
import UIKit

class SentMemeCollectionViewController: UICollectionViewController {
    
    
    @IBOutlet weak var sentMemesFlowLayout: UICollectionViewFlowLayout!
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemeCell", for: indexPath) as! SentMemeCollectionViewCell
        let sentMeme = self.memes[indexPath.row]
        cell.SentMemeImageView.image = sentMeme.memedImage
        //cell.SentMemeImageView.backgroundColor = UIColor.blue
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let space: CGFloat = 1.0
        let dimension = (view.frame.size.width - (2 * space)) / 4.0
        sentMemesFlowLayout.minimumInteritemSpacing = space
        sentMemesFlowLayout.minimumLineSpacing = space
        
        sentMemesFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
        collectionView.collectionViewLayout = sentMemesFlowLayout
    }
}
