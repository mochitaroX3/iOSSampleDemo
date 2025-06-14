//
//  LoadingView.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/14.
//

import SwiftUI

struct LoadingView: View {
    
    @StateObject private var viewModel = LoadingViewModel()
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 10)
                .frame(width: 30, height: 30)
            
            Circle()
                .trim(from: 0, to: 0.4)
                .stroke(Color(.pageIndicatorColor), lineWidth: 4)
                .frame(width: 30, height: 30)
                .rotationEffect(Angle(degrees: viewModel.isRotating ? 360 : 0))
                .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false), value: viewModel.isRotating)
                .onAppear() {
                    viewModel.startRotating()
                }
                .onDisappear {
                    viewModel.stopRotating()
                }
        }
    }
}

#Preview {
    LoadingView()
}
