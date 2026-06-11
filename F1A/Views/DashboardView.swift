import SwiftUI

struct DashboardView: View {
    @Binding var showDashboard: Bool
    @State private var scrubberPosition: CGFloat = 0.52
    @State private var currentLap: Int = 24
    @State private var selectedDriver1 = "VER"
    @State private var selectedDriver2 = "HAM"
    @State private var currentFrameIndex = 0
    
    var currentFrame: RaceFrame {
        AbuDhabiReplay.frames[currentFrameIndex]
    }
    var driver1Tyre: String {
        selectedDriver1 == "HAM" ? "Medium" : "Hard"
    }

    var driver2Tyre: String {
        selectedDriver2 == "HAM" ? "Medium" : "Hard"
    }

    var driver1TyreAge: Int {
        Int(12 + scrubberPosition * 8)
    }

    var driver2TyreAge: Int {
        Int(10 + scrubberPosition * 6)
    }

    var comparisonGap: String {
        String(
            format: "+%.3f",
            abs(currentFrame.delta - rivalPosition)
        )
    }

    var driver1Strategy: String {
        scrubberPosition > 0.6 ? "Attack" : "Manage"
    }

    var driver2Strategy: String {
        scrubberPosition > 0.6 ? "Defend" : "Push"
    }
    var displayTurn: Int {

        let totalTurns = 14

        return min(
            Int(
                scrubberPosition *
                CGFloat(totalTurns)
            ) + 1,
            totalTurns
        )
    }
    var replayTime: String {

        let totalSeconds = Int(scrubberPosition * 168)

        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60

        return String(
            format: "%02d:%02d",
            minutes,
            seconds
        )
    }

    var speedValue: String {
        "\(currentFrame.speed)"
    }

    var throttleValue: String {
        "\(currentFrame.throttle)"
    }

    var brakeValue: String {
        "\(currentFrame.brake)"
    }

    var deltaValue: String {
        String(format: "+%.3f", currentFrame.delta)
    }
    var rivalSpeedValue: String {
        "\(Int(210 + (rivalPosition * 115)))"
    }

    var rivalThrottleValue: String {
        "\(Int(rivalPosition * 100))"
    }

    var rivalBrakeValue: String {
        "\(Int((1 - rivalPosition) * 55))"
    }

    var rivalDeltaValue: String {
        String(format: "+%.3f", rivalPosition * 1.1)
    }
    var rivalPosition: CGFloat {

        max(
            0,
            min(
                scrubberPosition - 0.08,
                1
            )
        )
    }

    let drivers = [
        ("VER", Color.blue),
        ("HAM", Color.yellow),
        ("NOR", Color.orange),
        ("LEC", Color.red),
        ("PIA", Color.cyan)
    ]

    var body: some View {

        GeometryReader { geometry in

            ZStack {

                Color.black
                    .ignoresSafeArea()

                VStack(spacing: 18) {

                    // TOP SECTION
                    HStack(spacing: 24) {

                        // LEFT - DRIVER TOWER
                        VStack(alignment: .leading, spacing: 20) {

                            Text("DRIVERS")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)

                            ForEach(drivers, id: \.0) { driver in

                                Button {

                                    if selectedDriver1 == driver.0 {
                                        return
                                    }

                                    if selectedDriver2 == driver.0 {
                                        return
                                    }

                                    selectedDriver2 = selectedDriver1
                                    selectedDriver1 = driver.0

                                } label: {

                                    HStack(spacing: 12) {

                                        Circle()
                                            .fill(driver.1)
                                            .frame(width: 10, height: 10)

                                        Text(driver.0)
                                            .foregroundColor(.white)
                                            .fontWeight(.semibold)

                                        Spacer()

                                        if selectedDriver1 == driver.0 {

                                            Text("P1")
                                                .foregroundColor(.red)
                                                .font(.caption)
                                                .fontWeight(.bold)
                                        }

                                        if selectedDriver2 == driver.0 {

                                            Text("P2")
                                                .foregroundColor(.yellow)
                                                .font(.caption)
                                                .fontWeight(.bold)
                                        }
                                    }
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 8)
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(
                                                selectedDriver1 == driver.0 ||
                                                selectedDriver2 == driver.0
                                                ? Color.white.opacity(0.06)
                                                : Color.clear
                                            )
                                    )
                                }
                                .buttonStyle(.plain)
                            }

                            Spacer()
                        }
                        .padding(24)
                        .frame(width: 220, height: 390)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.white.opacity(0.04))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.white.opacity(0.05))
                                )
                        )


                        // CENTER - TRACK REPLAY
                        ZStack {

                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.white.opacity(0.04))

                            // Premium dark background
                            LinearGradient(
                                colors: [
                                    Color.black,
                                    Color(red: 0.06, green: 0.06, blue: 0.07)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )

                            // Red ambient glow
                            Circle()
                                .fill(Color.red.opacity(0.18))
                                .blur(radius: 120)
                                .offset(x: 220, y: -40)

                            VStack(spacing: 22) {

                                // Header
                                HStack {

                                    VStack(alignment: .leading, spacing: 6) {

                                        Text("TRACK REPLAY")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(.gray)

                                        Text("Abu Dhabi 2021")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)

                                        HStack(spacing: 12) {

                                            Button {
                                                if currentLap > 1 {
                                                    currentLap -= 1
                                                }
                                            } label: {
                                                Image(systemName: "chevron.left")
                                                    .foregroundColor(.white)
                                                    .frame(width: 30, height: 30)
                                                    .background(Color.white.opacity(0.08))
                                                    .clipShape(Circle())
                                            }

                                            Text(
                                                "Lap \(currentFrame.lap) • TURN \(currentFrame.turn)"
                                            )
                                            .foregroundColor(.gray)
                                            .font(.subheadline)

                                            Button {
                                                if currentLap < 58 {
                                                    currentLap += 1
                                                }
                                            } label: {
                                                Image(systemName: "chevron.right")
                                                    .foregroundColor(.white)
                                                    .frame(width: 30, height: 30)
                                                    .background(Color.white.opacity(0.08))
                                                    .clipShape(Circle())
                                            }
                                        }
                                    }

                                    Spacer()

                                    Text("LIVE")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundColor(.red)
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 8)
                                        .background(Color.red.opacity(0.15))
                                        .cornerRadius(14)
                                }

                                Spacer()

                                // Track Placeholder
                                // TRACK VISUALIZATION
                                GeometryReader { trackGeo in

                                    ZStack {

                                        // Track Path
                                        Path { path in

                                            let w = trackGeo.size.width
                                            let h = trackGeo.size.height

                                            path.move(to: CGPoint(x: w * 0.22, y: h * 0.75))

                                            path.addCurve(
                                                to: CGPoint(x: w * 0.35, y: h * 0.28),
                                                control1: CGPoint(x: w * 0.15, y: h * 0.50),
                                                control2: CGPoint(x: w * 0.24, y: h * 0.20)
                                            )

                                            path.addCurve(
                                                to: CGPoint(x: w * 0.72, y: h * 0.22),
                                                control1: CGPoint(x: w * 0.50, y: h * 0.18),
                                                control2: CGPoint(x: w * 0.65, y: h * 0.18)
                                            )

                                            path.addCurve(
                                                to: CGPoint(x: w * 0.78, y: h * 0.72),
                                                control1: CGPoint(x: w * 0.85, y: h * 0.28),
                                                control2: CGPoint(x: w * 0.88, y: h * 0.58)
                                            )

                                            path.addCurve(
                                                to: CGPoint(x: w * 0.22, y: h * 0.75),
                                                control1: CGPoint(x: w * 0.60, y: h * 0.85),
                                                control2: CGPoint(x: w * 0.35, y: h * 0.90)
                                            )
                                        }
                                        .stroke(
                                            Color.white.opacity(0.12),
                                            style: StrokeStyle(
                                                lineWidth: 10,
                                                lineCap: .round
                                            )
                                        )

                                        // Moving Car Dot
                                        GeometryReader { dotGeo in
                                            let points: [CGPoint] = [

                                                CGPoint(x: dotGeo.size.width * 0.22,
                                                         y: dotGeo.size.height * 0.75),

                                                CGPoint(x: dotGeo.size.width * 0.28,
                                                         y: dotGeo.size.height * 0.55),

                                                CGPoint(x: dotGeo.size.width * 0.35,
                                                         y: dotGeo.size.height * 0.28),

                                                CGPoint(x: dotGeo.size.width * 0.52,
                                                         y: dotGeo.size.height * 0.20),

                                                CGPoint(x: dotGeo.size.width * 0.72,
                                                         y: dotGeo.size.height * 0.22),

                                                CGPoint(x: dotGeo.size.width * 0.80,
                                                         y: dotGeo.size.height * 0.45),

                                                CGPoint(x: dotGeo.size.width * 0.78,
                                                         y: dotGeo.size.height * 0.72),

                                                CGPoint(x: dotGeo.size.width * 0.58,
                                                         y: dotGeo.size.height * 0.84),

                                                CGPoint(x: dotGeo.size.width * 0.35,
                                                         y: dotGeo.size.height * 0.88),

                                                CGPoint(x: dotGeo.size.width * 0.22,
                                                         y: dotGeo.size.height * 0.75)
                                            ]


                                            let replayProgress =
                                            scrubberPosition

                                            let pathProgress =
                                            replayProgress *
                                            CGFloat(points.count - 1)

                                            let lowerIndex =
                                            Int(pathProgress)

                                            let upperIndex =
                                            min(
                                                lowerIndex + 1,
                                                points.count - 1
                                            )

                                            let interpolation =
                                            pathProgress -
                                            CGFloat(lowerIndex)

                                            let startPoint =
                                            points[lowerIndex]

                                            let endPoint =
                                            points[upperIndex]

                                            let currentX =
                                            startPoint.x +
                                            (
                                                (endPoint.x - startPoint.x)
                                                * interpolation
                                            )

                                            let currentY =
                                            startPoint.y +
                                            (
                                                (endPoint.y - startPoint.y)
                                                * interpolation
                                            )

                                            // Main Driver Car (VER)
                                            Circle()
                                                .fill(
                                                    drivers.first(where: {
                                                        $0.0 == selectedDriver1
                                                    })?.1 ?? .red
                                                )
                                                .frame(width: 18, height: 18)
                                                .shadow(color: .red.opacity(0.7), radius: 12)
                                                .position(
                                                    x: currentX,
                                                    y: currentY
                                                )
                                                .animation(
                                                    .interactiveSpring(
                                                        response: 0.35,
                                                        dampingFraction: 0.85
                                                    ),
                                                    value: scrubberPosition
                                                )

                                            // Rival Driver Car (HAM)
                                            let rivalX =
                                            max(
                                                currentX - 35,
                                                20
                                            )

                                            let rivalY =
                                            currentY + 10

                                            Circle()
                                                .fill(
                                                    drivers.first(where: {
                                                        $0.0 == selectedDriver2
                                                    })?.1 ?? .yellow
                                                )
                                                .frame(width: 18, height: 18)
                                                .shadow(color: .yellow.opacity(0.7), radius: 10)
                                                .position(
                                                    x: rivalX,
                                                    y: rivalY
                                                )
                                                .animation(
                                                    .interactiveSpring(
                                                        response: 0.35,
                                                        dampingFraction: 0.85
                                                    ),
                                                    value: scrubberPosition
                                                )
                                            
                                        }
                                    }
                                }
                                .frame(height: 180)

                                Spacer()

                                // Playback Bar
                                VStack(spacing: 10) {

                                    HStack {

                                        Image(systemName: "play.fill")
                                            .foregroundColor(.white)

                                        Text("Replay Timeline")
                                            .foregroundColor(.gray)

                                        Spacer()

                                        Text("\(replayTime) / 02:48")
                                            .foregroundColor(.white.opacity(0.7))
                                            .font(.caption)
                                    }

                                    Capsule()
                                        .fill(Color.white.opacity(0.08))
                                        .frame(height: 8)
                                        .overlay(
                                            HStack {
                                                Capsule()
                                                    .fill(Color.red)
                                                    .frame(width: 180 * scrubberPosition)

                                                Spacer()
                                            }
                                        )
                                }
                            }
                            .padding(.horizontal, 28)
                            .padding(.bottom, 28)
                            .padding(.top, 40)
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 390)
                        .clipShape(RoundedRectangle(cornerRadius: 30))
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.white.opacity(0.04), lineWidth: 1)
                        )


                        // RIGHT - RACE CONTEXT
                        VStack(alignment: .leading, spacing: 22) {

                            Text("RACE CONTEXT")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundColor(.gray)

                            HStack {

                                Spacer()

                                Text(selectedDriver1)
                                    .foregroundColor(.white)
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .frame(width: 70)

                                Text(selectedDriver2)
                                    .foregroundColor(.white.opacity(0.7))
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .frame(width: 70)
                            }

                            ComparisonContextColumnRow(
                                title: "Tyre",
                                value1: driver1Tyre,
                                value2: driver2Tyre
                            )

                            ComparisonContextColumnRow(
                                title: "Tyre Age",
                                value1: "\(driver1TyreAge)",
                                value2: "\(driver2TyreAge)"
                            )

                            ComparisonContextColumnRow(
                                title: "Gap",
                                value1: comparisonGap,
                                value2: "Leader"
                            )

                            ComparisonContextColumnRow(
                                title: "DRS",
                                value1:
                                    scrubberPosition > 0.5
                                    ? "Enabled"
                                    : "Disabled",
                                value2:
                                    scrubberPosition > 0.65
                                    ? "Enabled"
                                    : "Disabled"
                            )

                            ComparisonContextColumnRow(
                                title: "Strategy",
                                value1: driver1Strategy,
                                value2: driver2Strategy
                            )

                            Spacer()
                        }
                        .padding(24)
                        .frame(width: 300, height: 390)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.white.opacity(0.04))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.white.opacity(0.05))
                                )
                        )
                    }
                    .frame(height: 390)

                    // TELEMETRY WORKSPACE
                    VStack(spacing: 18) {

                        Text("TELEMETRY WORKSPACE")
                            .foregroundColor(.gray)
                            .font(.headline)

                        LazyVGrid(
                            columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ],
                            spacing: 12
                        ) {

                            ComparisonTelemetryCard(
                                title: "SPEED",
                                driver1: selectedDriver1,
                                driver2: selectedDriver2,
                                value1: speedValue,
                                value2: rivalSpeedValue,
                                unit: "km/h",
                                icon: "speedometer",
                                scrubberPosition: scrubberPosition,
                                rivalPosition: rivalPosition,
                            )

                            ComparisonTelemetryCard(
                                title: "THROTTLE",
                                driver1: selectedDriver1,
                                driver2: selectedDriver2,
                                value1: throttleValue,
                                value2: rivalThrottleValue,
                                unit: "%",
                                icon: "bolt.fill",
                                scrubberPosition: scrubberPosition,
                                rivalPosition: rivalPosition,
                            )

                            ComparisonTelemetryCard(
                                title: "BRAKE",
                                driver1: selectedDriver1,
                                driver2: selectedDriver2,
                                value1: brakeValue,
                                value2: rivalBrakeValue,
                                unit: "%",
                                icon: "stop.fill",
                                scrubberPosition: scrubberPosition,
                                rivalPosition: rivalPosition,
                            )

                            ComparisonTelemetryCard(
                                title: "DELTA",
                                driver1: selectedDriver1,
                                driver2: selectedDriver2,
                                value1: deltaValue,
                                value2: rivalDeltaValue,
                                unit: "sec",
                                icon: "clock.fill",
                                scrubberPosition: scrubberPosition,
                                rivalPosition: rivalPosition,
                            )
                        }
                    }

                    // TIMELINE
                    // TIMELINE + SCRUBBER
                    VStack(spacing: 18) {

                        HStack {

                            VStack(alignment: .leading, spacing: 4) {

                                Text("Lap \(currentFrame.lap) / 58")
                                    .foregroundColor(.white)
                                    .font(.headline)

                                Text("\(selectedDriver1) vs \(selectedDriver2)")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }

                            Spacer()

                            Text("TURN \(displayTurn)")
                                .foregroundColor(.red)
                                .fontWeight(.bold)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 8)
                                .background(Color.red.opacity(0.12))
                                .cornerRadius(14)

                            Spacer()

                            VStack(alignment: .trailing, spacing: 4) {

                                Text(replayTime)
                                    .foregroundColor(.white)

                                Text("Replay Time")
                                    .foregroundColor(.gray)
                                    .font(.caption)
                            }
                        }

                        GeometryReader { geo in

                            ZStack(alignment: .leading) {

                                Capsule()
                                    .fill(Color.white.opacity(0.08))
                                    .frame(height: 10)

                                Capsule()
                                    .fill(Color.red)
                                    .frame(
                                        width: geo.size.width * scrubberPosition,
                                        height: 10
                                    )

                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 20, height: 20)
                                    .shadow(color: .red.opacity(0.5), radius: 10)
                                    .offset(
                                        x: (geo.size.width * scrubberPosition) - 10
                                    )
                                    .gesture(
                                        DragGesture()
                                            .onChanged { value in

                                                withAnimation(.interactiveSpring(
                                                    response: 0.25,
                                                    dampingFraction: 0.85
                                                )) {

                                                    scrubberPosition = min(
                                                        max(
                                                            value.location.x / geo.size.width,
                                                            0
                                                        ),
                                                        1
                                                    )
                                                    currentFrameIndex = min(
                                                        Int(
                                                            scrubberPosition *
                                                            CGFloat(AbuDhabiReplay.frames.count - 1)
                                                        ),
                                                        AbuDhabiReplay.frames.count - 1
                                                    )
                                                }
                                            }
                                    )
                            }
                        }
                        .frame(height: 22)

                        HStack {

                            TimelineMarker("T1")

                            Spacer()

                            TimelineMarker("T5")

                            Spacer()

                            TimelineMarker("T9", active: true)

                            Spacer()

                            TimelineMarker("T14")
                        }
                    }
                    .padding(.horizontal, 14)
                }
                .padding(24)
            }
        }
    }
}

struct ContextRow: View {

    let title: String
    let value: String

    var body: some View {

        HStack {

            Text(title)
                .foregroundColor(.gray)

            Spacer()

            Text(value)
                .foregroundColor(.white)
                .fontWeight(.bold)
        }
    }
}
struct ComparisonContextColumnRow: View {
    
    let title: String
    let value1: String
    let value2: String
    
    var body: some View {
        
        HStack(alignment: .center) {
            
            Text(title)
                .foregroundColor(.gray)
                .frame(width: 90, alignment: .leading)
            
            Spacer(minLength: 0)
            
            Text(value1)
                .foregroundColor(.white.opacity(0.85))
                .fontWeight(.medium)
                .frame(width: 90, alignment: .center)
            
            Text(value2)
                .foregroundColor(.white.opacity(0.75))
                .fontWeight(.medium)
                .frame(width: 90, alignment: .center)
        }
    }
}
struct TimelineMarker: View {

    let title: String
    var active: Bool = false

    init(_ title: String, active: Bool = false) {
        self.title = title
        self.active = active
    }

    var body: some View {

        VStack(spacing: 6) {

            Circle()
                .fill(
                    active
                    ? Color.red
                    : Color.white.opacity(0.2)
                )
                .frame(
                    width: active ? 10 : 6,
                    height: active ? 10 : 6
                )

            Text(title)
                .foregroundColor(
                    active
                    ? .white
                    : .gray
                )
                .font(.caption)
        }
    }
}
struct ComparisonTelemetryCard: View {

    let title: String
    let driver1: String
    let driver2: String
    let value1: String
    let value2: String
    let unit: String
    let icon: String
    let scrubberPosition: CGFloat
    let rivalPosition: CGFloat

    var body: some View {

        VStack(alignment: .leading, spacing: 14) {

            HStack {

                Label(title, systemImage: icon)
                    .font(.caption)
                    .foregroundColor(.gray)

                Spacer()
            }

            VStack(alignment: .leading, spacing: 8) {

                HStack {

                    Circle()
                        .fill(driver1 == "VER" ? .blue :
                              driver1 == "HAM" ? .yellow :
                              driver1 == "NOR" ? .orange :
                              driver1 == "LEC" ? .red :
                              .cyan)
                        .frame(width: 8)

                    Text("\(driver1) \(value1) \(unit)")
                        .foregroundColor(.white)
                }

                HStack {

                    Circle()
                        .fill(driver2 == "VER" ? .blue :
                              driver2 == "HAM" ? .yellow :
                              driver2 == "NOR" ? .orange :
                              driver2 == "LEC" ? .red :
                              .cyan)
                        .frame(width: 10, height: 10)
                        .shadow(color: .yellow.opacity(0.8), radius: 6)

                    Text("\(driver2) \(value2) \(unit)")
                        .foregroundColor(.white)
                }
            }

            Spacer()

            TelemetryLineGraph(
                progress: scrubberPosition,
                rivalProgress: rivalPosition,

                driver1Color:
                    driver1 == "VER" ? .blue :
                    driver1 == "HAM" ? .yellow :
                    driver1 == "NOR" ? .orange :
                    driver1 == "LEC" ? .red :
                    .cyan,

                driver2Color:
                    driver2 == "VER" ? .blue :
                    driver2 == "HAM" ? .yellow :
                    driver2 == "NOR" ? .orange :
                    driver2 == "LEC" ? .red :
                    .cyan,
                telemetryType: title.lowercased()
            )
            .padding(.top, 6)
        }
        .padding(18)
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.white.opacity(0.04))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(Color.white.opacity(0.05))
        )
    }
}
struct TelemetryCard: View {

    let title: String
    let value: String
    let unit: String
    let icon: String
    let scrubberPosition: CGFloat
    let rivalPosition: CGFloat

    var body: some View {

        VStack(alignment: .leading, spacing: 14) {

            HStack {

                Label(title, systemImage: icon)
                    .font(.caption)
                    .foregroundColor(.gray)

                Spacer()

                Circle()
                    .fill(Color.red)
                    .frame(width: 8, height: 8)
            }

            HStack(alignment: .firstTextBaseline, spacing: 4) {

                Text(value)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)

                Text(unit)
                    .foregroundColor(.gray)
            }

            Spacer()

            HStack(alignment: .bottom, spacing: 5) {

                ForEach(0..<12, id: \.self) { index in

                    RoundedRectangle(cornerRadius: 6)
                        .fill(
                            index > 7
                            ? Color.red.opacity(0.8)
                            : Color.white.opacity(0.15)
                        )
                        .frame(
                            width: 5,
                            height: CGFloat(6 + (Double(index) * 1.5))
                        )
                }
            }
        }
        .padding(16)
        .frame(height: 110)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.white.opacity(0.04))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(Color.white.opacity(0.05))
        )
    }
}

#Preview {
    DashboardView(showDashboard: .constant(false))
}
