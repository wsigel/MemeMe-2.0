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
        Helper.showDetailView(indexPath: indexPath, parent: self)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SentMemeCell", for: indexPath) as! SentMemeCollectionViewCell
        let sentMeme = self.memes[indexPath.row]
        cell.SentMemeImageView.image = sentMeme.memedImage
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSentMemesFlowLayout()
        self.collectionView.collectionViewLayout = sentMemesFlowLayout
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func configureSentMemesFlowLayout() {
        let insets = UIEdgeInsets(top: 20, left: 25, bottom: 20, right: 25)
        sentMemesFlowLayout.sectionInset = insets
        sentMemesFlowLayout.itemSize = CGSize(width: 170, height: 170)
        sentMemesFlowLayout.minimumInteritemSpacing = 0
        sentMemesFlowLayout.minimumLineSpacing = 0
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isPortrait {
            print("portrait")
        }
        else if UIDevice.current.orientation.isLandscape {
            print("landscape")
        }
    }
}
