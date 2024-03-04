//
//  ContentView.swift
//  NewsIOS15PartII
//
//  Created by Aguid Ramirez Sanchez on 03/03/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showModal = false
    var body: some View {
        NavigationView{
            Button("Abrir ventana"){
                showModal.toggle()
            }.navigationTitle("Ventana Modal media")
                .mediaModal(showModal: $showModal) {
                    Text("Soy la ventana Modal")
                }
        }
    }
}

extension View{
    func mediaModal<ModalView : View>(showModal: Binding<Bool>, @ViewBuilder modalView: @escaping () -> ModalView ) -> some View{
        return self
            .background{
                mediaModalHelper(modalView: modalView(), showModal: showModal)
            }
    }
 
}

struct mediaModalHelper<ModalView: View> : UIViewControllerRepresentable{
    var modalView : ModalView
    @Binding var showModal: Bool
    
    let controller = UIViewController()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        if showModal{
            let modalController = CustomHostingController(rootView: modalView)
            uiViewController.present(modalController, animated: true) {
                DispatchQueue.main.async {
                    self.showModal.toggle()
                }
            }
        }
    }
}

class CustomHostingController<Content: View> : UIHostingController<Content>{
  
    override func viewDidLoad(){
        if let presentation = presentationController as? UISheetPresentationController{
            presentation.detents = [
                .medium(),
                .large()
            ]
            
            presentation.prefersGrabberVisible = true
        }
        
    }
}

