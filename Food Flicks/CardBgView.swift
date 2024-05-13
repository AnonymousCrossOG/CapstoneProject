//  CardBgView.swift
//  Food Flicks
//
//  Created by Donis, Michael - Student on 4/2/24.
//

import SwiftUI
import PhotosUI
struct CardBgView: View {
    @State var showCamera = false
    @State var showPhotos = false
    @State private var selectedImage: UIImage?
    @State var image: UIImage?
    var food: Food
    var body: some View {
        VStack {
            NavigationLink(destination: LikesViews()) {
                Image(systemName: "star.fill").font(.title).foregroundColor(.yellow)
                    .frame(maxWidth: 110, maxHeight: 75)
                    .background(.purple)
                    .clipShape(Capsule())
                    .padding()
                
            }
            .offset(CGSize(width: -160, height: 110))

            Spacer()
            
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            Spacer() //This spacer is currently allowing the buttons to show
            
            let image = Image(food.imageName)
            // MARK: - Camera Button
            HStack{
                
                Button("🎥") {
#if targetEnvironment(simulator)
//                    self.showPhotos.toggle()
                    self.showCamera.toggle()
#else
                    self.showCamera.toggle()
//                    self.showPhotos.toggle()
#endif
                    
                    
                }
                .font(.largeTitle)
                .foregroundStyle(.black)
                .frame(maxWidth: 110, maxHeight: 75)
                .background(.red)
                .clipShape(Capsule())
                .padding()
                .offset(CGSize(width: -20, height: -200))
                .fullScreenCover(isPresented: self.$showCamera) {
                    accessCameraView(selectedImage: self.$selectedImage)
                }
                .fullScreenCover(isPresented: self.$showPhotos) {
                    accessPhotosView(selectedImage: self.$selectedImage)
                }
                NavigationLink(destination: FavoriteView(userfood: .Brownie, food: .Brownie )) {
                    Image(systemName: "heart.fill").font(.title).foregroundColor(.red)
                        .frame(maxWidth: 110, maxHeight: 75)
                        .background(.green)
                        .clipShape(Capsule())
                        .padding()
                    
                }
                .offset(CGSize(width: 0, height: -200))
                
               
                
                
                
                Text("     ")
                ShareLink(item: image, preview: SharePreview("Food Stuff", image: image)) {
                    Label("", systemImage: "paperplane.fill").font(.largeTitle)
                    
                }
                .font(.largeTitle)
                .foregroundStyle(.white)
                .frame(maxWidth: 110, maxHeight: 75)
                .background(.blue)
                .clipShape(Capsule())
                .padding()
                .offset(CGSize(width: 0, height: -200))
            }
            
            
            .ignoresSafeArea(.keyboard, edges: .bottom)
            
            
        }
        
        
        
    }
    
    
    //import PhotosUI
    // MARK: - Camera Struct and stuff
    struct CamerasView: View {
        @State var showCamera = false
        @State private var selectedImage: UIImage?
        @State var image: UIImage?
        var body: some View {
            
            if let selectedImage{
                Image(uiImage: selectedImage)
                    .resizable()
                    .scaledToFit()
            }
            
        }
    }
}
struct accessPhotosView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> PhotoCoordinator {
        return PhotoCoordinator(picker: self)
    }
}

// Coordinator will help to preview the selected image in the View.
class PhotoCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessPhotosView
    
    init(picker: accessPhotosView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}
struct accessCameraView: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

// Coordinator will help to preview the selected image in the View.
class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}


#Preview {
    CardBgView(food: .Brownie)
}
