//
//  RunnerApp.swift
//  watch WatchKit Extension
//
//  Created by Christopher Elliot on 10/05/2022.
//

import SwiftUI

@main
struct RunnerApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
