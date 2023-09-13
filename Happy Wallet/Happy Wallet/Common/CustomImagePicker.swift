//
//  CustomImagePicker.swift
//  TabBarBaseProject
//
//  Created by Vipul  on 15/05/21.
//

import UIKit
import MobileCoreServices
import AVKit
import Photos
import Lottie

enum mediaType {
    case MediaTypeImage
    case MediaTypeVideo
}


class CustomImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    static let shared = CustomImagePicker()
    var allowsEditing: Bool!
    var imagePicker : UIImagePickerController!
    var currentMediaType: [mediaType] = [.MediaTypeImage]
    var completion: ((_ index: Int,_ success: Bool, _ dicMedia: [String: Any]?) -> ())?
    
    
    func openImagePickerWith(mediaType: mediaType = .MediaTypeImage,allowsEditing: Bool = true, actionSheetTitle: String? = nil, message: String? = nil, cancelButtonTitle: String = "Cancel", cameraButtonTitle: String = "Camera", galleryButtonTitle: String = "Gallery", completion: ((_ index: Int,_ success: Bool, _ dicMedia: [String: Any]?) -> ())?) {
        
        self.allowsEditing = allowsEditing
        self.completion = completion
        currentMediaType = [mediaType]
        let actionSheetController = UIAlertController(title: actionSheetTitle, message: message, preferredStyle: .actionSheet)
        let cancelActionButton = UIAlertAction(title: cancelButtonTitle, style: .cancel) { action -> Void in
            print(cancelButtonTitle)
        }
        actionSheetController.addAction(cancelActionButton)
        let cameraActionButton = UIAlertAction(title: cameraButtonTitle, style: .default) { action -> Void in
            print(cameraButtonTitle)
            self.checkAccess()
        }
        actionSheetController.addAction(cameraActionButton)
        let galleryActionButton = UIAlertAction(title: galleryButtonTitle, style: .default) { action -> Void in
            print(galleryButtonTitle)
            self.checkAccessForPhotoLibrary()
        }
        actionSheetController.addAction(galleryActionButton)
        DispatchQueue.main.async {
            GlobalUtility.shared.currentTopViewController().present(actionSheetController, animated: true, completion: nil)
        }
        
    }
    
    func openImagePickerWithMoreOptions(mediaType: mediaType = .MediaTypeImage,allowsEditing: Bool = true, actionSheetTitle: String? = nil, message: String? = nil, cancelButtonTitle: String = "Cancel", cameraButtonTitle: String = "Camera", galleryButtonTitle: String = "Gallery", completion: ((_ index: Int,_ success: Bool, _ dicMedia: [String: Any]?) -> ())?) {
        
        self.allowsEditing = allowsEditing
        self.completion = completion
        currentMediaType = [mediaType]
        let actionSheetController = UIAlertController(title: actionSheetTitle, message: message, preferredStyle: .actionSheet)
        
        let cancelActionButton = UIAlertAction(title: cancelButtonTitle, style: .cancel) { action -> Void in
            print(cancelButtonTitle)
            
        }
        actionSheetController.addAction(cancelActionButton)
        
        
        let viewImageActionButton = UIAlertAction(title: "View", style: .default) { action -> Void in
            self.completion!(1,true, nil)
            
        }
        actionSheetController.addAction(viewImageActionButton)
        
        let cameraActionButton = UIAlertAction(title: cameraButtonTitle, style: .default) { action -> Void in
            print(cameraButtonTitle)
            self.checkAccess()
        }
        actionSheetController.addAction(cameraActionButton)
        
        let galleryActionButton = UIAlertAction(title: galleryButtonTitle, style: .default) { action -> Void in
            print(galleryButtonTitle)
            self.checkAccessForPhotoLibrary()
        }
        actionSheetController.addAction(galleryActionButton)
        
        let removeImageActionButton = UIAlertAction(title: "Remove", style: .destructive) { action -> Void in
            self.completion!(2,true, nil)
            
        }
        actionSheetController.addAction(removeImageActionButton)
        DispatchQueue.main.async {
            GlobalUtility.shared.currentTopViewController().present(actionSheetController, animated: true, completion: nil)
        }
    }
    

    func openCameraWith(mediaType: mediaType = .MediaTypeImage, completion: ((_ index: Int,_ success: Bool, _ dicMedia: [String: Any]?) -> ())?) {
        self.completion = completion
        currentMediaType = [mediaType]
        self.checkAccess()
        
    }
    
    func openGalleryWith(mediaType: [mediaType] = [.MediaTypeImage], completion: ((_ index: Int,_ success: Bool, _ dicMedia: [String: Any]?) -> ())?) {
        self.completion = completion
        currentMediaType = mediaType
        self.checkAccessForPhotoLibrary()
    }
    
    func checkAccess()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            if let _ = imagePicker
            {
                imagePicker = nil
            }
            if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
                self.openCamera()
            } else {
                AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
                    if granted == true {
                        self.openCamera()
                        
                    } else {
                        DispatchQueue.main.async {
                            GlobalUtility.shared.currentTopViewController().displayAlert(msg: "To capture photos, allow \(AppConstants.appName) to access camera. Please allow it from settings", ok: "Settings", cancel: "Cancel", okAction: {
                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                                
                            }, cancelAction: nil)
                        }
                    }
                })
            }
            
            
        } else {
            if self.completion != nil {
                self.completion!(3,false, nil)
            }
            let alert  = UIAlertController(title: "Warning", message: "Device has no camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            DispatchQueue.main.async {
                GlobalUtility.shared.currentTopViewController().present(alert, animated: true, completion: nil)
            }
            
        }
    }
    

    func checkAccessForPhotoLibrary()
    {
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                self.openGallery()
            case .denied:
                DispatchQueue.main.async {
                    GlobalUtility.shared.currentTopViewController().displayAlert(msg: "To pick photos, allow \(AppConstants.appName) to access photo library. Please allow it from settings", ok: "Settings", cancel: "Cancel", okAction: {
                        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                        
                    }, cancelAction: nil)
                }
            default:
                print("default")
            }
        }
    }
    
    func openCamera() {
        DispatchQueue.main.async {
            self.imagePicker = UIImagePickerController()
            self.imagePicker.sourceType = .camera
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = self.allowsEditing
            
            var arr  = [String]()
            for aMediatype in self.currentMediaType
            {
                if aMediatype == .MediaTypeImage
                {
                    arr.append(kUTTypeImage as String)
                }
                else
                {
                    arr.append(kUTTypeMovie as String)
                }
            }
            
            self.imagePicker.mediaTypes = arr
            
            GlobalUtility.shared.currentTopViewController().present(self.imagePicker, animated: true, completion: nil)
        }
        
    }
    

    func openGallery() {
        DispatchQueue.main.async {
            if let _ = self.imagePicker
            {
                self.imagePicker = nil
            }
            
            self.imagePicker = UIImagePickerController()
            self.imagePicker.sourceType = .photoLibrary
            self.imagePicker.delegate = self
            self.imagePicker.allowsEditing = self.allowsEditing
            self.imagePicker.videoMaximumDuration = TimeInterval(60.0)
            
            
            var arr  = [String]()
            for aMediatype in self.currentMediaType
            {
                if aMediatype == .MediaTypeImage
                {
                    arr.append(kUTTypeImage as String)
                }
                else
                {
                    arr.append(kUTTypeMovie as String)
                }
            }
            
            self.imagePicker.mediaTypes = arr
            
            GlobalUtility.shared.currentTopViewController().present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
  
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var dic = [String: Any]()
        if let _ = info[UIImagePickerController.InfoKey.originalImage] {
            dic["image"] = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            if let infor = info[UIImagePickerController.InfoKey.editedImage] {
                dic["edited_image"] = infor as! UIImage
            }
            dic["url"] = info[UIImagePickerController.InfoKey.imageURL]
            if let infor = info[UIImagePickerController.InfoKey.imageURL] {
                if let url = infor as? URL {
                    dic["stringUrl"] = url
                }
            }
            
        } else {
            dic["video"] = info[UIImagePickerController.InfoKey.mediaURL] as! URL
        }
        imagePicker.dismiss(animated: false) {
            if self.completion != nil {
                self.completion!(3,true, dic)
            }
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: false) {
            if self.completion != nil {
                self.completion!(3,false, nil)
            }
        }
    }
    
}

