//
//  ActivityView.swift
//  Alert-SwiftUI
//
//  Created by cladendas on 11.12.2021.
//

import SwiftUI

//ActivityView - некоторое меню, в котором можно выбрать, что делать с указанным контентом: отправить, скопировать, сохранить
///Т.к. планируется использование именно контроллера, то подписываемся на UIViewControllerRepresentable
struct ActivityView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIActivityViewController
    
    public var activityItems: [Any]
    public var applicationActivities: [UIActivity]?
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let vc = UIActivityViewController(activityItems: activityItems,
                                          applicationActivities: applicationActivities)
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
    }
    
    
}
