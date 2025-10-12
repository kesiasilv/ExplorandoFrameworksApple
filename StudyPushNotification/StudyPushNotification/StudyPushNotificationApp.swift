//
//  StudyPushNotificationApp.swift
//  StudyPushNotification
//
//  Created by Késia Silva Viana on 12/10/25.
//

import SwiftUI

@main
struct StudyPushNotificationApp: App {
    //aqui ele chama o delegate para executar
    @UIApplicationDelegateAdaptor var appDelegate: CustomAppDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear{
                    appDelegate.app = self
                }
        }
    }
}
