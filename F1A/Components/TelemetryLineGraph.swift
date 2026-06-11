//
//  TelemetryLineGraph.swift
//  F1A
//
//  Created by Dhan on 29/05/26.
//

import SwiftUI

struct TelemetryLineGraph: View {
    

    let progress: CGFloat
    let rivalProgress: CGFloat
    let driver1Color: Color
    let driver2Color: Color
    let telemetryType: String

    var body: some View {

        GeometryReader { geo in

            ZStack {

                // Driver 2 Line
                Path { path in

                    let width = geo.size.width
                    let height = geo.size.height

                    let rivalBaseY = height * 0.68

                    path.move(
                        to: CGPoint(
                            x: 0,
                            y: rivalBaseY
                        )
                    )

                    for i in stride(from: 0, through: width, by: 8) {

                        let normalized =
                        i / width

                        let wave: CGFloat

                        switch telemetryType {

                        case "speed":
                            wave =
                            sin(normalized * .pi * 1.2)
                            * (18 + rivalProgress * 16)

                        case "throttle":
                            wave =
                            cos(normalized * .pi * 0.9)
                            * (12 + rivalProgress * 10)

                        case "brake":
                            wave =
                            sin(normalized * .pi * 4)
                            * (6 + rivalProgress * 20)

                        default:
                            wave =
                            sin(normalized * .pi * 2)
                            * 10
                        }

                        path.addLine(
                            to: CGPoint(
                                x: i,
                                y: rivalBaseY
                                    - (wave * 0.35)
                            )
                        )
                    }
                }
                .stroke(
                    driver2Color.opacity(0.85),
                    lineWidth: 2.5
                )

                // Driver 1 Line
                Path { path in

                    let width = geo.size.width
                    let height = geo.size.height

                    let leadBaseY = height * 0.38

                    path.move(
                        to: CGPoint(
                            x: 0,
                            y: leadBaseY
                        )
                    )

                    for i in stride(from: 0, through: width, by: 8) {

                        let normalized =
                        i / width

                        let wave: CGFloat

                        switch telemetryType {

                        case "speed":
                            wave =
                            cos(normalized * .pi * 1.2)
                            * (18 + progress * 16)

                        case "throttle":
                            wave =
                            sin(normalized * .pi * 0.9)
                            * (12 + progress * 10)

                        case "brake":
                            wave =
                            cos(normalized * .pi * 4)
                            * (6 + progress * 20)

                        default:
                            wave =
                            cos(normalized * .pi * 2)
                            * 10
                        }

                        path.addLine(
                            to: CGPoint(
                                x: i,
                                y: leadBaseY
                                    - (wave * 0.35)
                            )
                        )
                    }
                }
                .stroke(
                    driver1Color.opacity(0.9),
                    lineWidth: 2.8
                )
            }
        }
        .frame(height: 54)
    }
}
