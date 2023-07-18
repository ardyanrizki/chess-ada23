//
//  SafariView.swift
//  Chess
//
//  Created by Muhammad Rizki Ardyan on 13/07/23.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    @Binding var url: URL?

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        guard let url else { fatalError() }
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {}
}
