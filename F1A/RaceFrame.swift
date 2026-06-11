//
//  RaceFrame.swift
//  F1A
//
//  Created by Dhan on 29/05/26.
//

import Foundation
import CoreGraphics

struct RaceFrame: Codable {

    let lap: Int
    let turn: Int

    let speed: Int
    let throttle: Int
    let brake: Int

    let delta: Double

    let x: CGFloat
    let y: CGFloat
}
