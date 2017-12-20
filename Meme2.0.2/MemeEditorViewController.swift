//
//  MemeEditorViewController.swift
//  Meme2.0.2
//
//  Created by HarryZen on 2017/12/14.
//  Copyright © 2017年 harry. All rights reserved.
//

import Foundation
import UIKit

class MemeEditorViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var buttomTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    @IBOutlet weak var buttomToolBar: UIToolbar!
    
    
    let memeTextAttribute: [String: Any] = [
        NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
        NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
        NSAttributedStringKey.strokeWidth.rawValue: 3.0,
        NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
    ]
    
    let shareButton: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: #selector(share(_:)))
    let flexibleButton: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(cancel(_:)))
    let cameraButton: UIBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.camera, target: self, action: #selector(pickImageFromCamera(_:)))
    let ablumButton: UIBarButtonItem = UIBarButtonItem.init(title: "Ablum", style: UIBarButtonItemStyle.plain, target: self, action: #selector(pickImageFromAblum(_:)))
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        configTextAttribute(topTextField)
        configTextAttribute(buttomTextField)
        topTextField.text = "TOP"
        buttomTextField.text = "BUTTOM"
        
        topTextField.delegate = self
        buttomTextField.delegate = self
        
        subscribeNotificationToKeyboard()
        
//        toolbar.items?.append(shareButton)
//        toolbar.items?.append(flexibleButton)
//        toolbar.items?.append(cancelButton)
//
//        //tabBar.items?.append(cameraButton)
//        buttomToolBar.items?.append(cameraButton)
//        buttomToolBar.items?.append(flexibleButton)
//        buttomToolBar.items?.append(ablumButton)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeNotificationFromKeyboard()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolbar.items?.append(shareButton)
        toolbar.items?.append(flexibleButton)
        toolbar.items?.append(cancelButton)

        buttomToolBar.items?.append(cameraButton)
        buttomToolBar.items?.append(flexibleButton)
        buttomToolBar.items?.append(ablumButton)
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func subscribeNotificationToKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeNotificationFromKeyboard() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if self.buttomTextField.isFirstResponder {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }else {
            view.frame.origin.y = 0
        }
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let info = notification.userInfo
        let keyboard = info![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboard.cgRectValue.height
    }
    
    func configTextAttribute(_ textfield: UITextField){
        textfield.defaultTextAttributes = memeTextAttribute
        textfield.textAlignment = .center
        textfield.autocapitalizationType = .allCharacters
    }
    
    func save() {
        let meme = Meme(topText: topTextField.text!, buttomText: buttomTextField.text!, originalImage: imageView.image!, memedImage: generateMeme())
        
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
        
    }
    
    @objc func share(_ sender: Any) {
        let memeImage = generateMeme()
        let shareView = UIActivityViewController(activityItems:[memeImage], applicationActivities: nil)
        
        shareView.completionWithItemsHandler = {
            (activity, completed, items, error) in
            if (completed) {
                self.save()
            }
        }
        present(shareView, animated: true, completion: nil)
    }
    
    @objc func cancel(_ sender: Any) {
        self.imageView.image = nil
        self.topTextField.text = "TOP"
        self.buttomTextField.text = "BUTTOM"
    }
    
    @objc func pickImageFromAblum(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc func pickImageFromCamera(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            self.imageView.image = image
            picker.dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func generateMeme() -> UIImage {
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return memedImage
    }
}
