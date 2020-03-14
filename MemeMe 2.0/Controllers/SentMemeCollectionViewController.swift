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
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func configureSentMemesFlowLayout() {
        let numberOfColumns: CGFloat = 3.0
        sentMemesFlowLayout.scrollDirection = UICollectionView.ScrollDirection.vertical
        sentMemesFlowLayout.minimumInteritemSpacing = 2.0
        sentMemesFlowLayout.minimumLineSpacing = 2.0
        let minimumInterimSpacingTotal = sentMemesFlowLayout.minimumInteritemSpacing * (numberOfColumns - 1)
        let viewWidth = view.frame.size.width
        let widthDimension = (viewWidth - (minimumInterimSpacingTotal)) / numberOfColumns
        let heightDimension = view.frame.size.height * widthDimension / view.frame.size.width
        sentMemesFlowLayout.itemSize = CGSize(width: widthDimension, height: heightDimension)
        self.collectionView.collectionViewLayout = sentMemesFlowLayout
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
}
