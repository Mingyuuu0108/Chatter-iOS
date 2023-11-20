//
//  HomeView.swift
//  chatter
//
//  Created by 이민규 on 11/20/23.
//

import SwiftUI
import AVFoundation

struct HomeView: View {
    
    @State private var showLaunchView = true
    @State private var isSpeaking = false
    @State private var text: String = ""
    
    private let synthesizer = AVSpeechSynthesizer()

    var body: some View {
        VStack {
            Text("텍스트 : \"\(text)\"")
                .padding()
            
            TextField("텍스틀 입력해주세요", text: $text)

            Button(action: {
                self.speakText("\(text)")
            }) {
                Text("Speak")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }

            Button(action: {
                self.stopSpeaking()
            }) {
                Text("Stop")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .overlay {
            if showLaunchView {
                LaunchView()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation(.easeInOut) {
                    showLaunchView = false
                }
            }
        }
    }

    func speakText(_ text: String) {
        if !isSpeaking {
            let speechUtterance = AVSpeechUtterance(string: text)
            speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate
            synthesizer.speak(speechUtterance)
            isSpeaking = true
        }
    }

    func stopSpeaking() {
        if isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
            isSpeaking = false
        }
    }
}

#Preview {
    HomeView()
}
