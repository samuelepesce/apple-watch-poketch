//
//  ContentView.swift
//  pedomekron WatchKit Extension
//
//  Created by Samuele Pesce on 22/11/21.
//  Follow me on tiktok @samuele_pe <3
//

import SwiftUI


struct ContentView: View {
    @State private var showingAlert = true
    @State private var showingClock = false
    
    var body: some View {
        ZStack{
            Color(UIColor(hexString: "#70B070")).ignoresSafeArea()
            HStack{
                Spacer()
                if(showingClock){
                    StepView()
                        .transition(AnyTransition.scale.animation(.linear(duration: 0.1)))
                } else {
                    ClockView()
                        .transition(AnyTransition.scale.animation(.linear(duration: 0.1)))
                }
                Spacer()
            }
        }
        .background(Color(UIColor(hexString: "#70B070")).ignoresSafeArea())
        .alert("Made with ❤️ by @samuele_pe", isPresented: $showingAlert) {
                   Button("💕💕", role: .cancel) { }
               }
        .onTapGesture {
            showingClock = !showingClock
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
