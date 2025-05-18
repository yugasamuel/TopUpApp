//
//  KredivoTopUpPageView.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import SwiftUI

struct KredivoTopUpPageView: View {
    
    @StateObject var viewModel: KredivoTopUpPageViewModel
    
    var body: some View {
        VStack(spacing: .zero) {
            createTabBarView()
            
            ScrollView(.vertical, showsIndicators: false) {
                if viewModel.tabSelection == 0 {
                    createMobileCreditView()
                }
                else {
                    createDataPackageView()
                }
            }
        }
        .padding(.top, 8.0)
    }
}

private extension KredivoTopUpPageView {
    func createTabBarView() -> some View {
        HStack(spacing: .zero) {
            Text("Pulsa")
                .font(.body)
                .foregroundColor(viewModel.tabSelection == 0 ? KredivoColor.orange.toColor : .secondary)
                .fontWeight(viewModel.tabSelection == 0 ? .bold : nil)
                .frame(maxWidth: .infinity)
                .padding(.bottom)
                .overlay(
                    Rectangle()
                        .frame(height: 3.0)
                        .foregroundColor(viewModel.tabSelection == 0 ? KredivoColor.orange.toColor : .clear)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.setTabSelection(to: 0)
                }
            
            Text("Data Package")
                .font(.body)
                .foregroundColor(viewModel.tabSelection == 1 ? KredivoColor.orange.toColor : .secondary)
                .fontWeight(viewModel.tabSelection == 1 ? .bold : nil)
                .frame(maxWidth: .infinity)
                .padding(.bottom)
                .overlay(
                    Rectangle()
                        .frame(height: 3.0)
                        .foregroundColor(viewModel.tabSelection == 1 ? KredivoColor.orange.toColor : .clear)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.setTabSelection(to: 1)
                }
        }
        .padding(.vertical, 8.0)
    }
    
    func createMobileCreditView() -> some View {
        VStack(spacing: 8.0) {
            KredivoMobileNumberInputView(viewModel: viewModel.mobileNumberInputViewModel) { isValid in
                if isValid {
                    Task {
                        await viewModel.fetchMobileCredits()
                    }
                }
                else {
                    viewModel.updateStateForInvalidMobileNumber()
                }
            }
            
            KredivoMobileCreditListView(
                viewModel: viewModel.mobileCreditListViewModel,
                onSelectProduct: { product in
                    viewModel.onTapProduct(product)
                },
                onTapTryAgain: {
                    Task {
                        await viewModel.fetchMobileCredits()
                    }
                }
            )
            
            KredivoPromoBannerView(viewModel: viewModel.promoBannerViewModel) { voucher in
                viewModel.onTapVoucher(voucher)
            }
        }
        .background(KredivoColor.gray.toColor)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    func createDataPackageView() -> some View {
        Text("Data package is currently not available.")
            .padding()
    }
}

#Preview {
    KredivoTopUpPageView(
        viewModel: KredivoTopUpPageViewModel(
            mobileCreditFetcher: KredivoMobileCreditFetcherMock(),
            voucherFetcher: KredivoVoucherFetcherMock()
        )
    )
}
