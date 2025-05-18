//
//  KredivoVoucherListPageView.swift
//  Kredivo
//
//  Created by Yuga Samuel on 18/05/25.
//

import SwiftUI

struct KredivoVoucherListPageView: View {
    
    @StateObject var viewModel: KredivoVoucherListPageViewModel
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let vouchers):
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack(spacing: 32.0) {
                        ForEach(vouchers) { voucher in
                            createVoucherCardView(voucher)
                                .onTapGesture {
                                    viewModel.navigateToVoucherDetail(voucher)
                                }
                        }
                    }
                    .padding()
                }
            case .error(let error):
                KredivoErrorView(
                    title: error.localizedDescription,
                    onTryAgain: {
                        Task {
                            await viewModel.fetchVouchers()
                        }
                    }
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .onAppear {
            Task {
                await viewModel.fetchVouchers()
            }
        }
    }
}

private extension KredivoVoucherListPageView {
    func createVoucherCardView(_ voucher: KredivoVoucherItem) -> some View {
        VStack(alignment: .leading, spacing: 12.0) {
            KredivoImageView(url: voucher.imageURL)
            
            HStack {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(voucher.name)
                        .font(.headline)
                        
                    if let formattedEndDate: String = voucher.formattedEndDate {
                        Text("Berlaku hingga ")
                            .font(.body)
                        +
                        Text(formattedEndDate)
                            .font(.body.bold())
                    }
                }
                
                Spacer()
                
                Button(action: {
                    viewModel.didUseVoucher(voucher)
                }, label: {
                    Text("Pakai")
                        .font(.body.bold())
                        .foregroundColor(Color.white)
                        .padding(.vertical, 6.0)
                        .padding(.horizontal, 12.0)
                        .background(
                            RoundedRectangle(cornerRadius: 6.0)
                                .foregroundColor(KredivoColor.orange.toColor)
                        )
                })
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .clipShape(
            RoundedRectangle(cornerRadius: 8.0)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(Color.secondary, style: StrokeStyle(lineWidth: 1.0))
        )
        .background(Color.white)
        .background(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(Color.secondary, style: StrokeStyle(lineWidth: 1.0))
                .padding(.horizontal, 8.0)
                .offset(y: 12.0)
        )
    }
}

#Preview {
    KredivoVoucherListPageView(
        viewModel: KredivoVoucherListPageViewModel(
            voucherFetcher: KredivoVoucherFetcherMock(
                mockResponse: KredivoVoucherFetcherMock.loadMock()
            )
        )
    )
}
