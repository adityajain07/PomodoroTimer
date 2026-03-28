import SwiftUI

@main
struct PomodoroTimerApp: App {
    @StateObject private var vm = TimerViewModel()

    var body: some Scene {
        MenuBarExtra {
            MenuView(vm: vm)
        } label: {
            Image(systemName: vm.isRunning ? "clock.fill" : "clock")
        }
        .menuBarExtraStyle(.window)
    }
}
