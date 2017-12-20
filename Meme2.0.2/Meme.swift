//
//  Meme.swift
//  Meme2.0.2
//
//  Created by HarryZen on 2017/12/15.
//  Copyright © 2017年 harry. All rights reserved.
//

import Foundation
import UIKit
struct Meme {
    var topText: String
    var buttomText: String
    var originalImage: UIImage
    var memedImage: UIImage
    
    init(topText: String, buttomText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.buttomText = buttomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
}
