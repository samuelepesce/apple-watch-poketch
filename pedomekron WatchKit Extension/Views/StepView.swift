//
//  StepView.swift
//  pedomekron WatchKit Extension
//
//  Created by Samuele Pesce on 01/12/21.
//

import SwiftUI
import CoreMotion

struct StepView: View {
    @EnvironmentObject var colors: GlobalColors
    
    private let pedometer = CMPedometer()
    @State private var steps: Int?
    @State private var hasQueried = false
    
    // startUpdates crea un thread in bg che viene chiamato automaticamente quando ci sono nuovi dati
    private func startQueryingPedometer(){
        if(!hasQueried){
            pedometer.startUpdates(from: Calendar(identifier: .gregorian).startOfDay(for: Date())) { pedometerData, error in
                guard let pedometerData = pedometerData, error == nil else { return }
                steps = pedometerData.numberOfSteps.intValue
                print("Nuovi dati disponibili, passi: \(steps ?? 0)")
                hasQueried = true
            }
        }
    }
    

    var body: some View {
        Text("\(steps ?? 0)")
            .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
            .font(Font.custom("poketch-clock-numeral", size: 30))
            .foregroundColor(Color(UIColor(hexString: colors.Foreground())))
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color(UIColor(hexString: colors.Background())))
            )
            .overlay(RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(UIColor(hexString: "#508050")), lineWidth: 4)
            )
            .onAppear {
                startQueryingPedometer()
            }
    }
}

struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        StepView()
    }
}
