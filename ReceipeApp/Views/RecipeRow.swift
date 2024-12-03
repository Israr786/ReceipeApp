//
//  RecipeRow.swift
//  ReceipeApp
//
//  Created by Israrul on 12/3/24.
//

import SwiftUI

struct RecipeRow: View {
    let recipe: Recipe

    var body: some View {
        HStack {
            if let photoUrl = recipe.photoUrlSmall {
                AsyncImageView(url: photoUrl, placeholder: {
                    AnyView(ProgressView())
                })
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            }
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
