//
//  ContentView.swift
//  NubankMobileTest
//
//  Created by Jean Carlos on 30/11/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: URLShortenerViewModel
    
    init(viewModel: URLShortenerViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.nuBackground.ignoresSafeArea()
                
                VStack(spacing: 20) {
                    
                    Text("Encurtador de URL")
                        .font(.nuTitle)
                        .foregroundColor(.nuPurple)
                        .padding(.top, 12)
                    
                    // FIELD + BUTTON
                    HStack(spacing: 12) {
                        TextField("Cole a URL aqui...", text: $viewModel.urlInput)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.08), radius: 4, x: 0, y: 4)
                            .autocorrectionDisabled(true)
                            .textInputAutocapitalization(.never)
                            .accessibilityIdentifier("urlTextField")
                        
                        Button {
                            UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            Task { await viewModel.shortenURL() }
                        } label: {
                            ZStack {
                                if viewModel.isLoading {
                                    ProgressView()
                                } else {
                                    Text("Encurtar")
                                        .font(.headline)
                                }
                            }
                            .frame(width: 110, height: 44) // 👈 TAMANHO FIXO
                        }
                        .accessibilityIdentifier("shortenButton")
                        .buttonStyle(NuButtonStyle())
                        .disabled(viewModel.isLoading || viewModel.urlInput.isEmpty)
                    }
                    .padding(.horizontal)
                    
                    // LISTA OU EMPTY STATE
                    if viewModel.shortenedItems.isEmpty {
                        VStack(spacing: 10) {
                            Image(systemName: "scissors")
                                .font(.system(size: 50))
                                .foregroundColor(.nuPurple.opacity(0.8))
                            
                            Text("Nenhuma URL encurtada ainda")
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 60)
                        Spacer()
                        
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.shortenedItems) { item in
                                    ShortenedRowView(item: item)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .alert("Erro", isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.dismissError() } }
            )) {
                Button("OK") { viewModel.dismissError() }
            } message: {
                Text(viewModel.errorMessage ?? "Erro desconhecido")
            }
        }
    }
}

#Preview("Estado com 1 item mockado") {
    ContentView(
        viewModel: {
            let item = ShortenedItem(
                id: "xyz123",
                originalURL: "https://developer.apple.com",
                shortURL: "https://sho.rt/xyz123"
            )
            let mock = PreviewShortenURLUseCaseMock(result: item)
            return URLShortenerViewModel(shortenURLUseCase: mock)
        }()
    )
}
