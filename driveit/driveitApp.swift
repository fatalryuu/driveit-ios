//
//  driveitApp.swift
//  driveit
//
//  Created by Ivan Shatko on 12.02.24.
//

import SwiftUI
import Firebase

@main
struct driveitApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        FirebaseApp.configure();
        
        return true;
    }
}
