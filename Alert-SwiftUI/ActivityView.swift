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

///кастомный Activity
class ActivityViewCustomActivityView: UIActivity {
    
    //MARK: Properties
    var customActivityType: UIActivity.ActivityType
    var activityName: String
    var activityImageName: String
    var customActionWhenTapped: () -> Void
    
    //MARK: Initializer
    init(title: String,
         imageName: String,
         performAction: @escaping () -> Void) {
        self.activityName = title
        self.activityImageName = imageName
        self.customActivityType = UIActivity.ActivityType(rawValue: "Action \(title)")
        self.customActionWhenTapped = performAction
        super.init()
    }
    
    //MARK: Overrides
    override var  activityType: UIActivity.ActivityType? {
        return customActivityType
    }
    
    override var activityTitle: String? {
        return activityName
    }
    
    override class var activityCategory: UIActivity.Category {
        return .share
    }
    
    override var activityImage: UIImage? {
        return UIImage(named: activityImageName)
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        return true
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        //Nothing to prepare
    }
    
    override func perform() {
        customActionWhenTapped()
    }
}
