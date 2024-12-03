//
//  EmptyStateView.swift
//  ReceipeApp
//
//  Created by Israrul on 12/3/24.
//


import SwiftUI

struct EmptyStateView: View {
    let message: String

    var body: some View {
        VStack {
            Text(message)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}
