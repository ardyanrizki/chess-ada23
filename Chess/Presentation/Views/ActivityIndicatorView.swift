//
//  ActivityIndicatorView.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 17/07/23.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {

    let isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    let color: Color
    
    init(isAnimating: Bool = true, style: UIActivityIndicatorView.Style, color: Color = Color.actionText) {
        self.isAnimating = isAnimating
        self.style = style
        self.color = color
    }

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: style)
        view.color = UIColor(color)
        return view
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
