//
//  AppDelegate.swift
//  MaryVilleHS
//
//  Created by Jevon Mao on 10/16/22.
//

import SwiftUI
import Firebase
import FirebaseRemoteConfig
import FirebaseMessaging

final class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Configure Firebase Suite
        FirebaseApp.configure()
        setupFirebaseRemoteConfig()
        setupPushNotifications()
        setupFirebaseMessaging()

        return true
    }

    // Lock app to portrait mode only
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

}

// MARK: - UNUserNotification
extension AppDelegate: UNUserNotificationCenterDelegate {
    // Helper method
    func setupPushNotifications() {
        UNUserNotificationCenter.current().delegate = self

        // Request authorization for push notifications
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        DispatchQueue.main.async {
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    // MARK: Delegate methods
    // Receive displayed notifications for iOS 10 devices
    // Called for when app is in background
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
                                -> Void) {
        // Change this to your preferred presentation option
        completionHandler([.banner, .sound, .list])
    }

    // Receive notification for when app is in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}

// MARK: Firebase Messaging
extension AppDelegate: MessagingDelegate {
    // Helper method
    func setupFirebaseMessaging() {
        Messaging.messaging().delegate = self
    }

    // Helper method, intializes Remote Config
    func setupFirebaseRemoteConfig() {
        // Remote config fetch
        // Allows developer to remotely update small
        // pieces of data that will change app behavior
        let config = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        #if DEBUG
        settings.minimumFetchInterval = 0
        #else
        let sixHours = 60 * 60 * 6
        settings.minimumFetchInterval = TimeInterval(sixHours)
        #endif

        config.configSettings = settings
        Constants.remoteConfig = config
        Constants.remoteConfig.fetch {status, error in
            if status == .success {
                config.activate {_, _ in}
            } else {
        #if DEBUG
                debugPrint("Config not fetched")
                debugPrint("Error: \(error?.localizedDescription ?? "No error available.")")
        #endif
            }

        }

    }

    // MARK: Delegate methods
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        debugPrint("FCM Token: \(fcmToken ?? "")")
    }
}
