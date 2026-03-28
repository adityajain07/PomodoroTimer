import SwiftUI
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .sound])
    }
}

@main
struct PomodoroTimerApp: App {
    @StateObject private var vm = TimerViewModel()
    private let notificationDelegate = NotificationDelegate()

    init() {
        UNUserNotificationCenter.current().delegate = notificationDelegate
    }

    var body: some Scene {
        MenuBarExtra {
            MenuView(vm: vm)
        } label: {
            Image(systemName: vm.isRunning ? "clock.fill" : "clock")
        }
        .menuBarExtraStyle(.window)
    }
}
