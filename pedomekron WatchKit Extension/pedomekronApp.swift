//
//  pedomekronApp.swift
//  pedomekron WatchKit Extension
//
//  Created by Samuele Pesce on 22/11/21.
//

import SwiftUI

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

class GlobalColors : ObservableObject {
    @Published var arceusWatch = false
    
    func BG() -> String{
        return self.arceusWatch ? self.ArceusBG : self.KronBG
    }
    
    func Border() -> String{
        return self.arceusWatch ? self.ArceusBorder : self.KronBorder
    }
    
    func Foreground() -> String {
        return self.arceusWatch ? self.ArceusForeground : self.KronForeground
    }
    
    func Background() -> String {
        return self.arceusWatch ? self.ArceusTextBg : self.KronTextBg
    }

    func text() -> String{
        return !self.arceusWatch ? self.ArceusText : self.KronText
    }
    
    private let KronBG = "#70B070"
    private let KronBorder = "#508050"
    private let KronForeground = "102818"
    private let KronTextBg = "#70B070"
    private let KronText = "Il potere di Arceus sta svanendo..."
    
    private let ArceusBG = "#f7f7f7"
    private let ArceusBorder = "##575757"
    private let ArceusForeground = "#fce238"
    private let ArceusTextBg = "#1bad51"
    private let ArceusText = "Il potere di Arceus sta riecheggiando"
}

@main
struct pedomekronApp: App {
    @StateObject var colors = GlobalColors()
    
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(colors)
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
