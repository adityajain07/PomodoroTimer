import Foundation
import AppKit
import UserNotifications

final class TimerViewModel: ObservableObject {
    @Published var remainingSeconds: Int
    @Published var isRunning = false
    @Published var isComplete = false
    @Published var durationMinutes: Int {
        didSet {
            UserDefaults.standard.set(durationMinutes, forKey: "duration")
            if !isRunning && !isComplete {
                remainingSeconds = durationMinutes * 60
                totalSeconds = durationMinutes * 60
            }
        }
    }
    @Published var selectedSound: String {
        didSet { UserDefaults.standard.set(selectedSound, forKey: "sound") }
    }

    private(set) var totalSeconds: Int
    private var timer: Timer?

    static let availableSounds = [
        "Basso", "Blow", "Bottle", "Frog", "Funk",
        "Glass", "Hero", "Morse", "Ping", "Pop",
        "Purr", "Sosumi", "Submarine", "Tink"
    ]

    var timeString: String {
        let m = remainingSeconds / 60
        let s = remainingSeconds % 60
        return String(format: "%02d:%02d", m, s)
    }

    var progress: Double {
        guard totalSeconds > 0 else { return 0 }
        return Double(totalSeconds - remainingSeconds) / Double(totalSeconds)
    }

    init() {
        let saved = UserDefaults.standard.integer(forKey: "duration")
        let mins = saved > 0 ? saved : 25
        let sound = UserDefaults.standard.string(forKey: "sound") ?? "Glass"
        self.durationMinutes = mins
        self.selectedSound = sound
        self.remainingSeconds = mins * 60
        self.totalSeconds = mins * 60
        requestNotificationPermission()
    }

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, _ in }
    }

    private func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Pomodoro Complete"
        content.body = "Your \(durationMinutes)-minute session is done. Time for a break!"
        content.sound = .default
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }

    func toggle() {
        if isComplete {
            restart()
            return
        }
        isRunning ? pause() : start()
    }

    func start() {
        isRunning = true
        isComplete = false
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }
            DispatchQueue.main.async {
                if self.remainingSeconds > 0 {
                    self.remainingSeconds -= 1
                } else {
                    self.complete()
                }
            }
        }
    }

    func pause() {
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    func restart() {
        pause()
        isComplete = false
        remainingSeconds = durationMinutes * 60
        totalSeconds = durationMinutes * 60
    }

    func previewSound() {
        NSSound(named: NSSound.Name(selectedSound))?.play()
    }

    private func complete() {
        pause()
        isComplete = true
        NSSound(named: NSSound.Name(selectedSound))?.play()
        sendNotification()
    }
}
