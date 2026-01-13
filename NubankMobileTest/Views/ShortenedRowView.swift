//
//  ShortenedRowView.swift
//  NubankMobileTest
//
//  Created by Jean Carlos on 30/11/25.
//

import SwiftUI

struct ShortenedRowView: View {
    let item: ShortenedItem
    @State private var copied: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(item.originalURL)
                .font(.nuBody)
                .lineLimit(1)
                .truncationMode(.tail)
            
            Text(item.shortURL)
                .font(.nuCaption)
                .foregroundColor(.nuPurple)
                .lineLimit(1)
                .truncationMode(.middle)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 3)
        .overlay(alignment: .trailing) {
            Button {
                UIPasteboard.general.string = item.shortURL
                copied = true
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                    copied = false
                }
            } label: {
                Image(systemName: copied ? "checkmark" : "doc.on.doc")
                    .foregroundColor(.nuPurple)
                    .padding(12)
                    .background(Color(.systemBackground))
            }
            .accessibilityIdentifier("copyButton_\(item.id)")
        }
    }
}
