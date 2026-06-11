//
//  ContentView.swift
//  F1A
//
//  Created by Dhan on 28/05/26.
//

import SwiftUI

struct ContentView: View {
    @State private var showDashboard = false
    var body: some View {

        Group {

            if showDashboard {
                DashboardView(
                    showDashboard: $showDashboard
                )
            } else {

            ZStack {
            
            // Background
            Color.black
                .ignoresSafeArea()
            
            GeometryReader { geometry in
                
                ScrollView {
                    
                    VStack(spacing: 0) {
                        
                        // MARK: Top Section
                        HStack(alignment: .top) {
                            
                            // LEFT SIDE
                            VStack(alignment: .leading, spacing: 8) {
                                
                                Spacer()
                                    .frame(height: 20)
                                
                                Text("F1A")
                                    .font(.system(size: 110, weight: .black))
                                    .foregroundColor(.white)
                                
                                Text("Formula 1 Analytics")
                                    .font(.system(size: 30, weight: .bold))
                                    .foregroundColor(.red)
                                
                                Text("Replay-Driven Motorsport Intelligence")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            // RIGHT UTILITY BAR
                            HStack(spacing: 14) {
                                
                                UtilityPill(
                                    icon: "magnifyingglass",
                                    title: "Search races, teams, drivers..."
                                )
                                
                                UtilityPill(
                                    icon: "checkmark.circle.fill",
                                    title: "System Ready"
                                )
                                
                                UtilityPill(
                                    icon: "clock",
                                    title: "Last Sync"
                                )
                            }
                            .padding(.top, 36)
                        }
                        .padding(.horizontal, 56)
                        
                        // MARK: Main Dashboard Area
                        HStack(alignment: .top, spacing: 28) {
                            
                            // HERO CARD
                            // HERO CARD
                            ZStack {
                                
                                // Background Image
                                Image("abuDhabiHero")
                                    .resizable()
                                    .scaledToFill()
                                    .scaleEffect(1.15)
                                    .offset(x: 155, y: 10)
                                    .brightness(0.03)
                                    .contrast(1.15)
                                    .saturation(1.05)
                                    .opacity(1.0)
                                
                                // Dark Overlay
                                LinearGradient(
                                    stops: [
                                        .init(color: .black.opacity(0.97), location: 0.0),
                                        .init(color: .black.opacity(0.88), location: 0.25),
                                        .init(color: .black.opacity(0.55), location: 0.58),
                                        .init(color: .black.opacity(0.08), location: 1.0)
                                    ],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                                
                                HStack {
                                    
                                    // LEFT CONTENT
                                    VStack(alignment: .leading, spacing: 22) {
                                        
                                        Text("CONTINUE INVESTIGATION")
                                            .font(.caption)
                                            .fontWeight(.bold)
                                            .foregroundColor(.gray)
                                        
                                        Text("Abu Dhabi 2021")
                                            .font(.system(size: 46, weight: .black))
                                            .foregroundColor(.white)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.85)
                                        
                                        Text("Lap 24 • Turn 9")
                                            .font(.title3)
                                            .foregroundColor(.gray)
                                        
                                        Text("VER vs HAM")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .foregroundColor(.red)
                                        
                                        Spacer()
                                        
                                        Button {
                                            withAnimation(.easeInOut(duration: 0.35)) {
                                                showDashboard = true
                                            }
                                        } label: {
                                            HStack(spacing: 12) {
                                                
                                                Image(systemName: "play.fill")
                                                
                                                Text("Resume Analysis")
                                                    .fontWeight(.semibold)
                                            }
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 64)
                                            .background(Color.white)
                                            .cornerRadius(18)
                                            .shadow(
                                                color: .white.opacity(0.08),
                                                radius: 10
                                            
                                            )
                                        }
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    // RIGHT VISUAL
                                    ZStack {
                                        
                                        Circle()
                                            .fill(Color.red.opacity(0.15))
                                            .frame(width: 220)
                                            .blur(radius: 40)
                                
                                    }
                                    .frame(width: 240)
                                }
                                .padding(40)
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 390)
                            .clipShape(
                                RoundedRectangle(cornerRadius: 28)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 28)
                                    .stroke(
                                        LinearGradient(
                                            colors: [
                                                Color.white.opacity(0.06),
                                                Color.red.opacity(0.04)
                                            ],
                                            startPoint: .topLeading,
                                            endPoint: .bottomTrailing
                                        ),
                                        lineWidth: 1
                                    )
                            )
                            .background(
                                RoundedRectangle(cornerRadius: 28)
                                    .fill(Color.white.opacity(0.015))
                            )
                            .shadow(
                                color: Color.red.opacity(0.04),
                                radius: 14
                            )
                            
                            // RECENT SESSIONS
                            VStack(alignment: .leading, spacing: 18) {
                                
                                Text("RECENT SESSIONS")
                                    .font(.headline)
                                    .foregroundColor(.gray)
                                
                                SessionCard(
                                    title: "Monaco 2024",
                                    subtitle: "Rain Strategy"
                                )
                                
                                SessionCard(
                                    title: "Silverstone 2023",
                                    subtitle: "Lap Comparison"
                                )
                                
                                SessionCard(
                                    title: "Abu Dhabi 2021",
                                    subtitle: "Final Battle"
                                )
                            }
                            .frame(width: 420)
                        }
                        .padding(.horizontal, 56)
                        .padding(.top, 28)
                        
                        Spacer(minLength: 28)
                    }
                    .frame(maxWidth: 1500)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 30)
                }
            }
        }
            }
        }
        .onReceive(
            NotificationCenter.default.publisher(
                for: NSNotification.Name("GoHome")
            )
        ) { _ in
            showDashboard = false
        }
    }
}

// MARK: Utility Pill

struct UtilityPill: View {
    
    let icon: String
    let title: String
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            Image(systemName: icon)
                .foregroundColor(.white)
                .font(.headline)
            
            Text(title)
                .foregroundColor(.white.opacity(0.9))
        }
        .padding(.horizontal, 22)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white.opacity(0.05))
        )
    }
}

// MARK: Session Card

struct SessionCard: View {
    
    let title: String
    let subtitle: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            
            Text(subtitle)
                .foregroundColor(.gray)
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 105)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.white.opacity(0.03))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.white.opacity(0.04))
                )
        )
        .shadow(
            color: .white.opacity(0.02),
            radius: 6
        )
    }
}

#Preview {
    ContentView()
}
