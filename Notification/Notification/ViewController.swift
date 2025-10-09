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
        // Assim que a tela for carregada, chama a função que verifica se o app tem permissão
//        checkforPermission()
    }
    
    // MARK: - Função de Verificação de Permissão da Notificação
    
    /// Função responsável por verificar se o app tem permissão para enviar notificações
    func checkforPermission() {
        // Obtém o centro de notificações do sistema
        let notificationCenter = UNUserNotificationCenter.current()
        
        // Verifica o status atual das permissões de notificação
        notificationCenter.getNotificationSettings { settings in
            switch settings.authorizationStatus {
                
            case .authorized:
                // Caso o usuário já tenha autorizado, agenda a notificação
                self.dispatchNotification()
                
            case .denied:
                // Caso o usuário tenha negado, não faz nada
                return
                
            case .notDetermined:
                // Caso o usuário ainda não tenha escolhido (primeiro uso do app)
                // solicita a autorização para enviar notificações
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    // Se o usuário permitir e não ocorrer erro, agenda a notificação
                    if didAllow {
                        self.dispatchNotification()
                    }
                }
                
            default:
                // Outros casos (ex: restrições de sistema)
                return
            }
        }
    }
    
    // MARK: - Função de Agendamento da Notificação
    
    /// Função responsável por criar e agendar a notificação
    func dispatchNotification() {
        // Identificador único da notificação (usado para evitar duplicatas)
        let identifier = "morning-notification"
        
        // Conteúdo da notificação
        let title = "Oi Késia :)"
        let body = "Vai responder o CBL!!"
        
        // Define o horário em que a notificação será disparada
        let hour = 17
        let minute = 24
        let isDaily = true // Se for true, a notificação se repete diariamente
        
        // Acessa o centro de notificações do sistema
        let notificationCenter = UNUserNotificationCenter.current()
        
        // Cria o conteúdo da notificação
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default // Som padrão da notificação
        
        // Define a data e hora para o disparo da notificação
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: .current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        // Cria o gatilho da notificação (nesse caso, com base no horário definido)
        // Se `repeats` for true, a notificação será repetida diariamente nesse horário
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        
        // Cria o pedido de notificação com o identificador, conteúdo e gatilho
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // Remove notificações anteriores com o mesmo identificador (evita duplicadas)
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
        
        // Adiciona o novo agendamento de notificação
        notificationCenter.add(request)
    }
    
    
}
