//
//  KredivoPromoBannerView.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import SwiftUI

struct KredivoPromoBannerView: View {
    
    @StateObject var viewModel: KredivoPromoBannerViewModel
    
    let onSelectVoucher: ((KredivoVoucherItem) -> Void)?
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let vouchers):
                VStack(alignment: .leading) {
                    Text("Promos")
                        .font(.headline)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(vouchers) { voucher in
                                createPromoBannerItemView(using: voucher)
                                    .onTapGesture {
                                        onSelectVoucher?(voucher)
                                    }
                            }
                        }
                    }
                }
                .padding()
                .background(Color.white)
            case .error(let error):
                KredivoErrorView(title: error.localizedDescription) {
                    Task {
                        await viewModel.fetchVouchers()
                    }
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchVouchers()
            }
        }
    }
}

private extension KredivoPromoBannerView {
    @ViewBuilder
    func createPromoBannerItemView(using voucher: KredivoVoucherItem) -> some View {
        let width: CGFloat = UIScreen.main.bounds.width * 0.8
        let height: CGFloat = width / 2.0
        
        KredivoImageView(
            url: voucher.imageURL,
            width: width,
            height: height
        )
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }
}

#Preview {
    KredivoPromoBannerView(viewModel: KredivoPromoBannerViewModel()) { _ in }
}
