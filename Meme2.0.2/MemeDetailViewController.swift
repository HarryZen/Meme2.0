//
//  MemeDetailViewController.swift
//  Meme2.0.2
//
//  Created by HarryZen on 2017/12/19.
//  Copyright © 2017年 harry. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController, UINavigationControllerDelegate {
    var meme: Meme!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.image = meme.memedImage
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .edit
            , target: self, action:#selector(editMemeFromDetail) )
    }
    
    @objc func editMemeFromDetail() {
        let editorView = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        
        editorView.sentMeme = self.meme
        
        present(editorView, animated: true, completion: nil)
    }
    
    
    
}
