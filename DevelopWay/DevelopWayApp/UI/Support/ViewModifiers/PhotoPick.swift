//
//  PhotoPick.swift
//  DevelopWayApp
//
//  Created by Diana Sargsyan on 19.10.21.
//

import Foundation
import SwiftUI
import UIKit

struct PhotoPick: ViewModifier {
    @Binding var showSheet: Bool
    @Binding var pickerShow: Bool
    @State var image: UIImage?
    let completionHandler: (UIImage?, URL?) -> Void
    let preferFrontCam: Bool
    
    @State private var sourceType = UIIPick.SourceType.photoLibrary
    
    func body(content: Content) -> some View {
        content
            .actionSheet(isPresented: $showSheet) {
                ActionSheet(title: Text(""), buttons: buttonList(showRemove: image != nil))
        }
            .sheet(isPresented: $pickerShow, content: {
                ImagePicker(sourceType: sourceType, completionHandler: completionHandler)
            })
    }
    
    private func buttonList(showRemove: Bool) -> [ActionSheet.Button] {
        var list = [ActionSheet.Button]()
        if let b = checkAndGetButton(type: .camera, title: "Take Photo") {
            list.append(b)
        }
        if let b = checkAndGetButton(type: .photoLibrary,
                                     title: "Choose Photo") {
            list.append(b)
        }
        if showRemove {
            list.append(.destructive(Text("Remove Photo")) {
                self.image = nil
            })
        }
        list.append(.cancel(Text("Cancel")))
        return list
    }
    
    private typealias UIIPick = UIImagePickerController
    private func checkAndGetButton(type: UIIPick.SourceType, title: String) -> ActionSheet.Button? {
        guard UIIPick.isSourceTypeAvailable(type) else {
            return nil
        }
        return ActionSheet.Button.default(Text(title)) {
            self.sourceType = type
            self.pickerShow = true
        }
    }
}


struct ImagePicker: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIImagePickerController
    typealias SourceType = UIImagePickerController.SourceType

    let sourceType: SourceType
    let completionHandler: (UIImage?, URL?) -> Void
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let viewController = UIImagePickerController()
        viewController.delegate = context.coordinator
        viewController.sourceType = sourceType
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(completionHandler: completionHandler)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let completionHandler: (UIImage?, URL?) -> Void
        
        init(completionHandler: @escaping (UIImage?, URL?) -> Void) {
            self.completionHandler = completionHandler
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            let image: UIImage? = {
                if let image = info[.editedImage] as? UIImage {
                    return image
                }
                return info[.originalImage] as? UIImage
            }()
            completionHandler(image, info[.imageURL] as? URL)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            completionHandler(nil, nil)
        }
    }
}


//struct ImagePicker: UIViewControllerRepresentable {
//
//    var sourceType: UIImagePickerController.SourceType = .photoLibrary
//
//    @Binding var selectedImage: UIImage
//    @Environment(\.presentationMode) private var presentationMode
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//
//        let imagePicker = UIImagePickerController()
//        imagePicker.allowsEditing = false
//        imagePicker.sourceType = sourceType
//        imagePicker.delegate = context.coordinator
//
//        return imagePicker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
//
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator(self)
//    }
//
//    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//
//        var parent: ImagePicker
//
//        init(_ parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//
//            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//                parent.selectedImage = image
//            }
//
//            parent.presentationMode.wrappedValue.dismiss()
//        }
//    }
//}

