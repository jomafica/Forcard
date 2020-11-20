//
//  SafariView.swift
//  Forcard
//
//  Created by Daniel on 20/11/2020.
//

import Foundation
import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {

    let url: URL

    func makeUIViewController(context:     UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context:     UIViewControllerRepresentableContext<SafariView>) {

    }

}
