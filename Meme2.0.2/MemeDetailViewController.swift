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
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let controller = segue.destination as! MemeEditorViewController
//        
//        controller.buttomTextField.text = self.meme.buttomText
//        controller.topTextField.text = self.meme.topText
//        controller.imageView.image = self.meme.originalImage
//        
//    }
    
    
}
