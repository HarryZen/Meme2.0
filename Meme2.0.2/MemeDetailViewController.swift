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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.imageView.image = meme.memedImage
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.edit, target: self, action: #selector(pushEditView))
    }
    
    @objc func pushEditView() {
        let editorView = storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        
        editorView.topTextField.text = self.meme.topText
        editorView.buttomTextField.text = self.meme.buttomText
        editorView.imageView.image = self.meme.originalImage
        
        self.navigationController?.pushViewController(editorView, animated: true)
    }
    
}
