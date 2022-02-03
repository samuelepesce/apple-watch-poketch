//
//  ClockView.swift
//  pedomekron WatchKit Extension
//
//  Created by Samuele Pesce on 01/12/21.
//

import SwiftUI


struct ClockView: View {
    @EnvironmentObject var colors: GlobalColors
    
    
    let dF : DateFormatter
    @State private var today = Date()
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    init(){
        dF = DateFormatter()
        dF.dateFormat = "HH:mm"
    }

    var body: some View {
        Text( dF.string(from: today))
            .onReceive(timer, perform: { _input in
                today = _input
            })
            .font(Font.custom("poketch-clock-numeral", size: 40))
            .padding(16)
            .foregroundColor(Color(UIColor(hexString: colors.Foreground())))
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous).fill(Color(UIColor(hexString: colors.Background())))
            )
            .overlay(RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(UIColor(hexString: colors.Border())), lineWidth: 4)
            )
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
