//
//  ContentView.swift
//  StudyPushNotification
//
//  Created by Késia Silva Viana on 12/10/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Request for Push Notification"){
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
