//
//  MemeCell.swift
//  Meme2.0.2
//
//  Created by HarryZen on 2017/12/23.
//  Copyright © 2017年 harry. All rights reserved.
//

import UIKit
class MemeCell: UITableViewCell {
    func setupCellWith(meme:Meme) {
        self.imageView?.image = meme.memedImage
        self.textLabel?.text = "\(meme.topText) ... \(meme.buttomText)"
    }
}
