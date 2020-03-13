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
        configureSentMemesFlowLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    func configureSentMemesFlowLayout() {
        let numberOfColumns: CGFloat = 2.0
        let insets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        sentMemesFlowLayout.sectionInset = insets
        sentMemesFlowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        sentMemesFlowLayout.minimumInteritemSpacing = 10
        sentMemesFlowLayout.minimumLineSpacing = 10
        sentMemesFlowLayout.sectionInsetReference = .fromContentInset
        let insetsLeftAndRight = insets.left + insets.right
        let minimumInterimSpacingTotal = sentMemesFlowLayout.minimumInteritemSpacing * (CGFloat)(numberOfColumns - 1)
        let viewWidth = self.collectionView.contentSize.width //view.frame.size.width
        let dimension = (viewWidth - (insetsLeftAndRight) - (minimumInterimSpacingTotal)) / numberOfColumns
        sentMemesFlowLayout.itemSize = CGSize(width: dimension, height: dimension)
        self.collectionView.collectionViewLayout = sentMemesFlowLayout
        self.collectionView.collectionViewLayout.invalidateLayout()

    }
}
