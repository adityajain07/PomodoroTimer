import SwiftUI

struct MenuView: View {
    @ObservedObject var vm: TimerViewModel

    var body: some View {
        VStack(spacing: 14) {
            Text(vm.timeString)
                .font(.system(size: 48, weight: .ultraLight, design: .monospaced))
                .foregroundStyle(vm.isComplete ? .green : .primary)

            ProgressView(value: vm.progress)
                .tint(vm.isComplete ? .green : .accentColor)

            HStack(spacing: 24) {
                Button(action: vm.toggle) {
                    Image(systemName: vm.isComplete ? "play.fill" :
                          vm.isRunning ? "pause.fill" : "play.fill")
                        .font(.title2)
                }
                .buttonStyle(.plain)
                .help(vm.isRunning ? "Pause" : "Start")

                Button(action: vm.restart) {
                    Image(systemName: "arrow.counterclockwise")
                        .font(.title2)
                }
                .buttonStyle(.plain)
                .help("Restart")
            }
            .padding(.vertical, 4)

            Divider()

            HStack {
                Text("Duration")
                    .foregroundStyle(.secondary)
                Spacer()
                Picker("", selection: $vm.durationMinutes) {
                    ForEach([5, 10, 15, 20, 25, 30, 45, 60], id: \.self) { m in
                        Text("\(m) min").tag(m)
                    }
                }
                .labelsHidden()
                .frame(width: 100)
            }

            HStack {
                Text("Sound")
                    .foregroundStyle(.secondary)
                Spacer()
                Picker("", selection: $vm.selectedSound) {
                    ForEach(TimerViewModel.availableSounds, id: \.self) { s in
                        Text(s).tag(s)
                    }
                }
                .labelsHidden()
                .frame(width: 100)

                Button(action: vm.previewSound) {
                    Image(systemName: "speaker.wave.2")
                }
                .buttonStyle(.plain)
                .help("Preview sound")
            }

            Divider()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .buttonStyle(.plain)
            .foregroundStyle(.secondary)
        }
        .padding()
        .frame(width: 260)
    }
}
