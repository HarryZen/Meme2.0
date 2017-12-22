//
//  SentMemeTableViewController.swift
//  Meme2.0.2
//
//  Created by HarryZen on 2017/12/15.
//  Copyright © 2017年 harry. All rights reserved.
//

import Foundation
import UIKit

class SentMemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var memes = [Meme]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.memes = appDelegate.memes
        self.tableView.reloadData()
//        self.tableView.delegate = self
//        self.tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]
        
        cell.textLabel?.text = "\(meme.topText)...\(meme.buttomText)"
        cell.imageView?.image = meme.memedImage
        
        return cell
    }
    
    @IBAction func addMeme(_ sender: Any) {
        let editorView = self.storyboard?.instantiateViewController(withIdentifier: "MemeEditorViewController") as! MemeEditorViewController
        present(editorView, animated: true, completion: nil)
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailView = storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailView.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController?.pushViewController(detailView, animated: true)
        
    }
    
}
