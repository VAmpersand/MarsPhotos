//
//  SafariView.swift
//  MarsPhotos
//
//  Created by Viktor Prokolota on 02.11.2021.
//

import SwiftUI
import SafariServices

// MARK: - SafariView
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController,
                                context: UIViewControllerRepresentableContext<SafariView>) {
    }
}
