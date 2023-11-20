//
//  HomeView.swift
//  chatter
//
//  Created by 이민규 on 11/20/23.
//

import SwiftUI
import AVFoundation
import Alamofire

struct HomeView: View {
    
    @State private var showLaunchView = true
    @State private var isSpeaking = false
    @State private var text: String = ""
    @State private var question: String = ""
    @State private var enwser: String = ""
    
    private let synthesizer = AVSpeechSynthesizer()
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                Button {
                    
                } label: {
                    VStack(spacing: 4) {
                        Text("이전 질문 / 답변 다시보기")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.white)
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: 140, height: 0.7)
                    }
                }
                Spacer()
                
                Text(question == "" ? "채터에게 질문해보세요!" : enwser == "" ? "답변 중..." : "오늘 오후에 강한 비가 내릴 가능성이 매우 높아요, 우산 꼭 챙겨주세요.")
                    .font(.system(size: 28, weight: .medium))
                    .foregroundStyle(Color.white)
                
                Spacer()
                
                Text("\(question)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(Color.white)
                    .padding(.bottom, 20)
            }
            .frame(height: 240)
            .frame(maxWidth: .infinity)
            .background(Color.background)
            
            ZStack(alignment: .leading) {
                if text.count == 0 {
                    Text("텍스트를 입력해주세요")
                        .foregroundStyle(Color.subTitle)
                        .padding(.horizontal, 15)
                }
                
                TextField("", text: $text)
                    .foregroundStyle(Color.black)
                    .padding(.horizontal, 15)
            }
            .frame(height: 40)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.white)
                        .shadow(color: Color.black.opacity(0.3), radius: 4, y: 2)
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.clear)
                        .offset( y: 2)
                }
            )
            .padding(.horizontal, 30)
            .padding(.top, 20)
            
            Button(action: {
                askToGPT()
            }) {
                Text("질문하기")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color.subTitle)
            }
            .padding(.top, 20)
            
            Spacer()
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
}

extension HomeView {
    
    func askToGPT() {
        question = text
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
