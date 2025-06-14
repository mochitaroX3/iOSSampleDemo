//
//  LoadingOverlay.swift
//  TaipeiTravelDemo
//
//  Created by user on 2025/6/14.
//

import UIKit
import SwiftUI
import Combine

class LoadingViewModel: ObservableObject {
    @Published var isRotating: Bool = false
    
    func startRotating() {
        DispatchQueue.main.async {
            self.isRotating = true
        }
    }
    
    func stopRotating() {
        DispatchQueue.main.async {
            self.isRotating = false
        }
    }
}

class LoadingOverlay {
    static let shared = LoadingOverlay()

    private var hostingController: UIHostingController<LoadingView>?

    private init() {}

    /// 顯示 Loading
    func show(in viewController: UIViewController) {
        // 若已顯示，避免重複加入
        guard hostingController == nil else { return }

        let loadingView = LoadingView()
        let host = UIHostingController(rootView: loadingView)
        hostingController = host

        host.view.backgroundColor = .clear
        host.modalPresentationStyle = .overFullScreen
        host.view.translatesAutoresizingMaskIntoConstraints = false

        viewController.addChild(host)
        viewController.view.fill(with: host.view)
        host.didMove(toParent: viewController)
    }

    /// 隱藏 Loading
    func hide() {
        guard let host = hostingController else { return }

        host.willMove(toParent: nil)
        host.view.removeFromSuperview()
        host.removeFromParent()
        hostingController = nil
    }
}
