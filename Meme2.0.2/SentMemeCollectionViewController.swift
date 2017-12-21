//
//  SentMemeCollectionViewController.swift
//  Meme2.0.2
//
//  Created by HarryZen on 2017/12/15.
//  Copyright © 2017年 harry. All rights reserved.
//

import Foundation
import UIKit

class SentMemeCollectionViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource  {
    var memes = [Meme]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = appDelegate.memes
        self.collectionView.reloadData()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    @IBAction func addMeme(_ sender:Any) {
        let editorView = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        present(editorView, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionCell", for: indexPath) as! MemeCollectionCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.imageView.image = meme.memedImage
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        
        detailView.meme = self.memes[(indexPath as NSIndexPath).row]
        
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    
}
