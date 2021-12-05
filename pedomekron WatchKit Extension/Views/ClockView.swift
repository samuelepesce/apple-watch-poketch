//
//  ClockView.swift
//  pedomekron WatchKit Extension
//
//  Created by Samuele Pesce on 01/12/21.
//

import SwiftUI


struct ClockView: View {
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
            .foregroundColor(Color(UIColor(hexString: "#102818")))
            .padding()
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
