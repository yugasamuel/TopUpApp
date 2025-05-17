//
//  KredivoMobileCreditListView.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import SwiftUI

struct KredivoMobileCreditListView: View {
    
    @StateObject var viewModel: KredivoMobileCreditListViewModel
    
    let onSelectProduct: ((KredivoMobileCreditProduct) -> Void)?
    let onTapTryAgain: (() -> Void)?
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .invalidMobileNumber:
                Text("No operator found. Make sure the mobile number has at least 4 digits.")
                    .font(.body)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
            case .loading:
                ProgressView()
            case .loaded(let products):
                LazyVStack(spacing: .zero) {
                    ForEach(products) { product in
                        createMobileCreditProductView(using: product)
                            .onTapGesture {
                                onSelectProduct?(product)
                            }
                    }
                }
            case .error(let error):
                KredivoErrorView(title: error.localizedDescription) {
                    onTapTryAgain?()
                }
            }
        }
        .background(Color.white)
    }
}

private extension KredivoMobileCreditListView {
    func createMobileCreditProductView(using product: KredivoMobileCreditProduct) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Nominal: ")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(product.formattedNominal ?? product.nominal)
                    .font(.body)
            }
            
            Spacer()
            
            Text(product.formattedPrice ?? String(product.price))
                .font(.body)
                .foregroundColor(Color.white)
                .lineLimit(1)
                .frame(width: 100)
                .fixedSize()
                .padding(12.0)
                .background(KredivoColor.blue.toColor)
        }
        .background(Color.white)
        .padding()
        .overlay(
            Divider()
                .frame(maxHeight: .infinity, alignment: .bottom)
        )
    }
}

#Preview {
    KredivoMobileCreditListView(
        viewModel: KredivoMobileCreditListViewModel(),
        onSelectProduct: { _ in
            print("Select product.")
        },
        onTapTryAgain: {
            print("Try again.")
        }
    )
}
