//
//  ErrorStateView.swift
//  ReceipeApp
//
//  Created by Israrul on 12/3/24.
//


import SwiftUI

struct ErrorStateView: View {
    let message: String
    let retryAction: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text(message)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()

            Button(action: retryAction) {
                Text("Retry")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }
}
