//
//  ViewController.swift
//  Notification
//
//  Created by Késia Silva Viana on 09/10/25.
//
//
import UIKit
import UserNotifications // Importa o framework necessário para lidar com notificações locais

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Removemos a chamada aqui, pois agora a notificação será agendada pelo botão
    }
    
    // MARK: - Verificar permissão antes de enviar a notificação
    func checkforPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
                
            case .authorized:
                // Se já tiver permissão, agenda a notificação
                self.dispatchNotification()
                
            case .denied:
                // Se o usuário tiver negado, apenas mostra um alerta informando
//                DispatchQueue.main.async {
//                    let alert = UIAlertController(title: "Permissão Negada",
//                                                  message: "Ative as notificações nas configurações para usar este recurso.",
//                                                  preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "OK", style: .default))
//                    self.present(alert, animated: true)
//                }
                return
                
            case .notDetermined:
                // Se ainda não foi perguntado, solicita a permissão
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispatchNotification()
                    } else {
                        print("Usuário negou a permissão.")
                    }
                }
                
            default:
                return
            }
        }
    }
    
    // MARK: - Criar e agendar a notificação
    func dispatchNotification() {
        let identifier = "custom-notification"
        
        // Conteúdo da notificação
        let title = "Oi Késia :)"
        let body = "Vai responder o CBL!!"
        
        // Acessa o centro de notificações
        let notificationCenter = UNUserNotificationCenter.current()
        
        // Cria o conteúdo
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        //Aqui agenda para disparar **5 segundos depois de clicar**
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // Cria o pedido da notificação
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // Remove possíveis notificações antigas com o mesmo ID
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        
        // Adiciona o novo agendamento
        notificationCenter.add(request)
        
        print("Notificação agendada para daqui 5 segundos.")
    }
    
    // MARK: - Ação do botão (ligado ao Storyboard)
    @IBAction func notification(_ sender: Any) {
        // Ao clicar no botão, verifica permissão e agenda a notificação
        checkforPermission()
    }
}
