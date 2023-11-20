//
//  LaunchView.swift
//  chatter
//
//  Created by 이민규 on 11/20/23.
//

import SwiftUI

struct LaunchView: View {
    
    var body: some View {
        VStack(spacing: 20) {
            Image("icon")
                .resizable()
                .foregroundStyle(Color.white)
                .frame(width: 80, height: 80)
            
            Group {
                Text("나만의 AI 비서, ")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.white)
                +
                Text("채터")
                    .font(.system(size: 20, weight: .black))
                    .foregroundStyle(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}

#Preview {
    LaunchView()
}
