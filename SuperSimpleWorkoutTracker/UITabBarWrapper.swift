//
//  UITabBarWrapper.swift
//  SuperSimpleWorkoutTracker
//
//  Created by Dathan Wong on 6/28/20.
//  Copyright © 2020 Dathan Wong. All rights reserved.
//

import SwiftUI

fileprivate struct UITabBarControllerWrapper: UIViewControllerRepresentable {
    var viewControllers: [UIViewController]
    
    // 2
    func makeUIViewController(context: UIViewControllerRepresentableContext<UITabBarControllerWrapper>) -> UITabBarController {
        let tabBar = UITabBarController()
        
        // Configure Tab Bar here, if needed
        
        return tabBar
    }
    
    // 3
    func updateUIViewController(_ uiViewController: UITabBarController, context: UIViewControllerRepresentableContext<UITabBarControllerWrapper>) {
        uiViewController.setViewControllers(self.viewControllers, animated: true)
    }
    
    // 4
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    class Coordinator: NSObject {
        var parent: UITabBarControllerWrapper
        
        init(_ controller: UITabBarControllerWrapper) {
            self.parent = controller
        }
    }
}

struct UITabBarWrapper: View {
    var controllers: [UIHostingController<TabBarElement>] // 1
    
    init(_ elements: [TabBarElement]) {
        self.controllers = elements.enumerated().map { // 2
            let hostingController = UIHostingController(rootView: $1)
            
            hostingController.tabBarItem = UITabBarItem( // 3
                title: $1.tabBarElementItem.title,
                image: nil,
                tag: $0 // 4
            )
            
            return hostingController
        }
    }
    
    var body: some View {
        UITabBarControllerWrapper(viewControllers: self.controllers) // 5
    }
}

struct UITabBarWrapper_Previews: PreviewProvider {
    static var previews: some View {
        UITabBarWrapper([
            TabBarElement(tabBarElementItem:
                TabBarElementItem(title: "Test 1")) {
                    Text("Test 1 Text")
            }
        ])
    }
}
