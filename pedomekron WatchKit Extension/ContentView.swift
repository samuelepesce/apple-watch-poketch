//
//  ContentView.swift
//  pedomekron WatchKit Extension
//
//  Created by Samuele Pesce on 22/11/21.
//  Follow me on tiktok @samuele_pe <3
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var colors: GlobalColors

    @State private var showingAlert = true
    @State private var showingClock = false
    @State private var showingArceusAlert = false
    
    var body: some View {
        ZStack{
            Color(UIColor(hexString: colors.BG())).ignoresSafeArea()
            HStack{
                Spacer()
                if(showingClock){
                    StepView()
                        .transition(AnyTransition.scale.animation(.linear(duration: 0.1)))
                        .environmentObject(colors)
                } else {
                    ClockView()
                        .transition(AnyTransition.scale.animation(.linear(duration: 0.1)))
                        .environmentObject(colors)
                }
                Spacer()
            }
        }
        .background(Color(UIColor(hexString: "#70B070")).ignoresSafeArea())
        .alert("Made with ❤️ by @samuele_pe", isPresented: $showingAlert) {
                   Button("💕💕", role: .cancel) { }
               }
        .alert(colors.text(), isPresented: $showingArceusAlert) {
                   Button("😮😮", role: .cancel) {
                       colors.arceusWatch.toggle()
                   }
               }
        .onTapGesture {
            showingClock.toggle();
        }
        .onLongPressGesture(minimumDuration: 1) {
            WKInterfaceDevice.current().play( colors.arceusWatch ? .stop : .success)
            showingArceusAlert = true
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
