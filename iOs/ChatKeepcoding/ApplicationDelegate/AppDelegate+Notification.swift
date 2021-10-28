//
//  AppDelegate+Notification.swift
//  ChatKeepcoding
//
//  Created by Eric Risco de la Torre on 28/10/21.
//  Copyright © 2021 ERISCO. All rights reserved.
//

import Foundation
import Firebase
import FirebaseMessaging
import UserNotifications

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func registerForPushNotifications(_ application: UIApplication){
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { _, _ in }
        }else{
            let settings: UIUserNotificationSettings = UIUserNotificationSettings(types: [.alert, .badge, .sound] , categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().subscribe(toTopic: "GENERAL")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        processNotification(response.notification)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        processNotification(notification)
    }
    
    private func processNotification(_ notification: UNNotification){
        // DO SOMETHING
    }
    
    
}
