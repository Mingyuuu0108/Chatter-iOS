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
    
    @StateObject var viewModel = ViewModel()
    
    @State private var showLaunchView = true
    @State private var showQuestionsView = false
    @State private var isSpeaking = false
    @State private var text: String = ""
    @State private var question: String = ""
    @State private var answer: String = ""
    
    private let synthesizer = AVSpeechSynthesizer()
    
    // LifeCycle
    var body: some View {
        view()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation(.easeInOut) {
                        showLaunchView = false
                    }
                }
            }
    }
}

// View
extension HomeView {
    
    @ViewBuilder
    private func view() -> some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                VStack {
                    Button {
                        showQuestionsView.toggle()
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
                    
                    Text(question == "" ? "채터에게 질문해보세요!" : answer == "" ? "답변 중..." : "\(answer)")
                        .font(.system(size: 24, weight: .medium))
                        .foregroundStyle(Color.white)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(4)
                        .padding(.horizontal, 20)
                    
                    Spacer()
                    
                    Text("\(question)")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.white)
                        .padding(.bottom, 20)
                }
                .frame(height: 240)
                .frame(maxWidth: .infinity, maxHeight: 260)
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
            .sheet(isPresented: $showQuestionsView) {
                QuestionsView(viewModel: viewModel)
            }
        }
    }
}

// Function
extension HomeView {
    
    private func askToGPT() {
        stopSpeaking()
        answer = ""
        question = text
        viewModel.addQuestion(question)
        AF.request("http://10.80.163.4:8000/question",
                   method: .post,
                   parameters: ["question": "\(question) 에 대해 띄어쓰기 포함 해서 80글자 이내로 답변해줘"],
                   encoding: JSONEncoding.default,
                   headers: ["Accept": "application/json"]
        )
        .responseDecodable(of: String.self) { response in
            guard let answer = response.value else { return }
            self.answer = answer
            speakText(answer)
            viewModel.addAnswer(answer)
        }
    }
    
    private func speakText(_ text: String) {
        if !isSpeaking {
            let speechUtterance = AVSpeechUtterance(string: text)
            speechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate
            synthesizer.speak(speechUtterance)
            isSpeaking = true
        }
    }
    
    private func stopSpeaking() {
        if isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
            isSpeaking = false
        }
    }
}

#Preview {
    HomeView()
}
