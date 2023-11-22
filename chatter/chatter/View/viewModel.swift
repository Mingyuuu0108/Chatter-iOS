//
//  viewModel.swift
//  chatter
//
//  Created by 이민규 on 11/22/23.
//

import SwiftUI

class ViewModel: ObservableObject {
    
    @Published var questionsList: [String] = ["대구 달성군 구지의 오늘 날씨는 어때?"]
    @Published var answersList: [String] = ["오늘 오후에 강한 비가 내릴 가능성이 매우 높아요, 우산 꼭 챙겨주세요."]

    func addQuestion(_ question: String) {
        
        if questionsList.count == 10 {
            questionsList.removeLast()
        }

        questionsList.append(question)
    }
    
    func addAnswer(_ answer: String) {
        
        if answersList.count == 10 {
            answersList.removeLast()
        }

        answersList.append(answer)
    }
}
