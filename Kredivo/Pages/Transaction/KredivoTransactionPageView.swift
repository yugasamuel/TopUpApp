//
//  KredivoTransactionPageView.swift
//  Kredivo
//
//  Created by Yuga Samuel on 18/05/25.
//

import SwiftUI

struct KredivoTransactionPageView: View {
    
    let viewModel: KredivoTransactionPageViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 8.0) {
                createMobileNumberView()
                
                KredivoTransactionDetailsView(viewModel: viewModel.transactionDetailsViewModel)
                
                KredivoVoucherInputView(viewModel: viewModel.voucherInputViewModel, onTapVoucherInput: {
                    viewModel.navigateToVoucherPage()
                }, onTapVoucherRemove: {
                    viewModel.processVoucherRemoval()
                })
                
                KredivoPinInputView(viewModel: viewModel.pinInputViewModel)
            }
            .background(KredivoColor.gray.toColor)
            .padding(.bottom, 54.0)
        }
        .overlay(
            VStack {
                Spacer()
                
                Button(action: {
                    viewModel.validateTransaction()
                }, label: {
                    Text("Bayar")
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .padding(.vertical, 16.0)
                        .frame(maxWidth: .infinity)
                        .background(
                            Rectangle()
                                .foregroundColor(KredivoColor.orange.toColor)
                        )
                })
            }
        )
    }
}

private extension KredivoTransactionPageView {
    func createMobileNumberView() -> some View {
        HStack(spacing: 8.0) {
            Image(systemName: "t.circle.fill")
                .resizable()
                .frame(width: 24.0, height: 24.0)
                .foregroundColor(.red)
                .padding(8.0)
                .overlay(
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 3.0))
                        .foregroundColor(KredivoColor.blue.toColor)
                )
                .clipShape(.circle)
            
            Text(viewModel.mobileNumber)
                .font(.body)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color.white)
    }
}

#Preview {
    KredivoTransactionPageView(
        viewModel: KredivoTransactionPageViewModel(
            mobileNumber: "081210615928",
            mobileCredit: .init(
                productCode: "101",
                billType: "mobile",
                label: "XL Rp 10.000",
                operator: "xl",
                nominal: "10000",
                description: "",
                sequence: 1,
                price: 12000
            ),
            voucherFetcher: KredivoVoucherFetcherMock()
        )
    )
}
