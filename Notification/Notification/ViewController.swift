//
//  ViewController.swift
//  Notification
//
//  Created by Késia Silva Viana on 09/10/25.
//

import UIKit
import UserNotifications //necessáro para implementar notificação

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //função responsável para verificar permissão
    func checkforPerrmission()
    {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings(completionHandler: <#T##(UNNotificationSettings) -> Void#>)
    }
    
    //função responsável para despachar a função
    func dispatchNotification()
    {
        
    }
}

