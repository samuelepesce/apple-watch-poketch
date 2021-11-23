//
//  pedomekronApp.swift
//  pedomekron WatchKit Extension
//
//  Created by Samuele Pesce on 22/11/21.
//

import SwiftUI

@main
struct pedomekronApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
