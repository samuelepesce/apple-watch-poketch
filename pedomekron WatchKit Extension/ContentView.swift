//
//  ContentView.swift
//  pedomekron WatchKit Extension
//
//  Created by Samuele Pesce on 22/11/21.
//  Follow me on tiktok @samuele_pe <3
//

import SwiftUI
import CoreMotion

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

struct ContentView: View {

    private let pedometer = CMPedometer()
    @State private var steps: Int?
    @State private var showingAlert = true
    
    // startUpdates crea un thread in bg che viene chiamato automaticamente quando ci sono nuovi dati
    private func startQueryingPedometer(){
        pedometer.startUpdates(from: Calendar(identifier: .gregorian).startOfDay(for: Date())) { pedometerData, error in
            guard let pedometerData = pedometerData, error == nil else { return }
            steps = pedometerData.numberOfSteps.intValue
            print("Nuovi dati disponibili, passi: \(steps ?? 0)")
        }
    }
    
    
    var body: some View {
        ZStack {
            Color(UIColor(hexString: "#70B070")).ignoresSafeArea()
            Text("\(steps ?? 0)")
                .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                .font(Font.custom("poketch-clock-numeral", size: 30))
                .foregroundColor(Color(UIColor(hexString: "#102818")))
                .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color(UIColor(hexString: "#508050")), lineWidth: 4)
                )
        }
        .background(Color(UIColor(hexString: "#70B070")).ignoresSafeArea())
        .alert("Made with ❤️ by @samuele_pe", isPresented: $showingAlert) {
                   Button("💕💕", role: .cancel) { }
               }
        .onAppear{

            startQueryingPedometer()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
