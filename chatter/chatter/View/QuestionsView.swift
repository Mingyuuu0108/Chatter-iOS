//
//  QuestionsView.swift
//  chatter
//
//  Created by 이민규 on 11/21/23.
//

import SwiftUI
import Alamofire

struct QuestionsView: View {
    
    @StateObject var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss
    
    @State private var text: String = ""
    @State private var question: String = ""
    @State private var answer: String = ""
    
    // LifeCycle
    var body: some View {
        view()
    }
}

// View
extension QuestionsView {
    
    @ViewBuilder
    private func view() -> some View {
        VStack {
            Button {
                dismiss()
            } label: {
                VStack(spacing: 4) {
                    Text("돌아가기")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(Color.white)
                    
                    Rectangle()
                        .fill(Color.white)
                        .frame(width: 140, height: 0.7)
                    
                    Text("최근 10회의 대화를 다시 볼 수 있습니다.")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(Color.white)
                }
            }
            .padding(.top, 20)
            
            ScrollView {
                
                ForEach(Array(zip(viewModel.questionsList.reversed(), viewModel.answersList.reversed())), id: \.0) { (q, a) in
                    VStack(spacing: 8) {
                        Text("Q: \(q)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text("A: \(a)")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal, 30)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 10)
            
            Spacer()
        }
        .background(Color.background)
    }
}

// Function
extension QuestionsView {
    
}
