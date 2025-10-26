//
//  Untitled 5.swift
//  plants
//
//  Created by noura on 23/10/2025.
//

// NotificationManager.swift
// NotificationManager.swift
import UserNotifications
import SwiftUI

class NotificationManager {
    static let shared = NotificationManager()
    private init() {}

    // طلب إذن الإشعارات
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if let error = error {
                print("Error requesting notifications: \(error.localizedDescription)")
            } else {
                print("Notifications permission granted: \(granted)")
            }
        }
    }

    // جدولة إشعار للنبتة (وضع تجربة بعد 5 ثواني)
    func scheduleNotification(for plant: Plant, testMode: Bool = true) {
        let content = UNMutableNotificationContent()
        content.title = "Time to water \(plant.name) 🌱"
        content.body = "Don't forget to water your plant!"
        content.sound = UNNotificationSound.default

        let trigger: UNNotificationTrigger

        if testMode {
            // للاختبار: بعد 5 ثواني
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        } else {
            // الإشعار الحقيقي: كل يوم الساعة 9 صباحًا حسب أيام السقي
            let firstWaterDate = plant.lastWatered ?? Date()
            let calendar = Calendar.current
            let nextWaterDate = calendar.date(byAdding: .day, value: plant.wateringIntervalDays, to: firstWaterDate) ?? firstWaterDate

            var dateComponents = calendar.dateComponents([.year, .month, .day], from: nextWaterDate)
            dateComponents.hour = 9
            dateComponents.minute = 0

            trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        }

        let request = UNNotificationRequest(
            identifier: plant.id.uuidString,
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("✅ Notification scheduled for \(plant.name) (testMode: \(testMode))")
            }
        }
    }

    // إلغاء إشعارات نبتة معينة
    func cancelNotification(for plant: Plant) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])
        print("❌ Notification cancelled for \(plant.name)")
    }
}
