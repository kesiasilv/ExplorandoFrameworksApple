//
//  CustomAppDelegate.swift
//  StudyPushNotification
//
//  Created by Késia Silva Viana on 12/10/25.
//

import SwiftUI
import UserNotifications

class CustomAppDelegate: NSObject, UIApplicationDelegate{
    var app: StudyPushNotificationApp?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil)-> Bool{
        application.registerForRemoteNotifications()// Aqui acontece a notificacao remota onde ele se registra
        
        UNUserNotificationCenter.current().delegate = self // Aqui ele delega pro notification
     
        
        return true
    }

    // A partir do token ele registra essa notificacao que sera enviada, sem o token nao consegue enviar a notificacao
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()//aqui ele apenas converte o token em hexadecimal
        print("tokenString: \(tokenString)")
        
        
    }
    
}

extension CustomAppDelegate: UNUserNotificationCenterDelegate {
    // Todo esse metodo é executado a partir do momento que a notificacoa é enviada
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
        print("Notification title", response.notification.request.content.title)
    }
    // Mesmo estando dentro do app esse app é responsavel pra aparecer a notificacao mesmo dentro do app
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.badge, .banner, .list, .sound]
    }
}
