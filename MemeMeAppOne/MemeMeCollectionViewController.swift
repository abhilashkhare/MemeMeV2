//
//  MemeMeCollectionViewController.swift
//  MemeMeAppOne
//
//  Created by Abhilash Khare on 12/24/17.
//  Copyright © 2017 Abhilash Khare. All rights reserved.
//

import UIKit
import Foundation


class MemeMeCollectionViewController: UICollectionViewController {
    
    var  memes = [Meme]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        memes = appDelegate.memes
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath)
            as!  MemeCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.memeImage.image = meme.memedImage
        cell.top.text = meme.topTextField.text
        cell.bottom.text = meme.bottomTextField.text
    
        return cell
        
        
    }
    
    

}
