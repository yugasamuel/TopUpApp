//
//  KredivoStatusPageView.swift
//  Kredivo
//
//  Created by Yuga Samuel on 18/05/25.
//

import SwiftUI

struct KredivoStatusPageView: View {
    
    @StateObject var viewModel: KredivoStatusPageViewModel
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .loading:
                ProgressView()
            case .loaded(let response, let mobileNumber, let message):
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 16.0) {
                        createOrderDetailsView(
                            mobileNumber: mobileNumber,
                            merchantImageUrl: response.transactionContext.merchantDetails.logoURL,
                            statusDesc: response.transactionContext.transactionStatusDescription,
                            statusColor: response.transactionContext.transactionStatusColor.toColor,
                            orderId: response.transactionContext.orderId
                        )
                        
                        createTransactionDetailsView(
                            items: response.transactionContext.itemList,
                            totalAmount: response.transactionContext.amount,
                            appliedPayment: response.transactionContext.formattedAppliedPaymentType
                        )
                        
                        createPaymentMessage(using: message)
                    }
                    .padding()
                    .padding(.bottom, 54.0)
                }
                .overlay(
                    VStack {
                        Spacer()
                        
                        Button(action: {
                            viewModel.backToTopUpPage()
                        }, label: {
                            Text("Oke")
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
            case .error(let error):
                KredivoErrorView(
                    title: error.localizedDescription,
                    onTryAgain: {
                        Task {
                            await viewModel.fetchStatus()
                        }
                    }
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .onAppear {
            Task {
                await viewModel.fetchStatus()
            }
        }
    }
}

private extension KredivoStatusPageView {
    func createOrderDetailsView(
        mobileNumber: String,
        merchantImageUrl: String,
        statusDesc: String,
        statusColor: Color,
        orderId: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text("Detail Pesanan")
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(1)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(KredivoColor.gray.toColor.opacity(0.5))
            
            HStack {
                VStack {
                    KredivoImageView(
                        url: merchantImageUrl,
                        width: 40.0,
                        height: 40.0
                    )
                    .clipShape(.circle)
                    .padding(8.0)
                    .overlay(
                        Circle()
                            .stroke(style: StrokeStyle(lineWidth: 2.0))
                            .foregroundColor(KredivoColor.blue.toColor)
                    )
                }
                
                Text(mobileNumber)
                    .font(.title3)
            }
            .padding(.horizontal)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8.0) {
                HStack {
                    Text("Status")
                        .font(.body)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text(statusDesc)
                        .font(.body)
                        .foregroundColor(statusColor)
                        .lineLimit(1)
                }
                
                HStack {
                    Text("Order ID")
                        .font(.body)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text(orderId)
                        .font(.body)
                        .lineLimit(1)
                }
            }
            .padding(.horizontal)
        }
        .padding(.bottom)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(
                    KredivoColor.gray.toColor,
                    style: StrokeStyle(lineWidth: 1.0)
                )
        )
    }
    
    func createTransactionDetailsView(
        items: [KredivoTransactionItem],
        totalAmount: String,
        appliedPayment: String
    ) -> some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text("Detail Pembayaran")
                .font(.title2)
                .fontWeight(.semibold)
                .lineLimit(1)
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(KredivoColor.gray.toColor.opacity(0.5))
            
            VStack(alignment: .leading, spacing: 16.0) {
                ForEach(items) { item in
                    createTransactionItemView(
                        name: item.name,
                        totalAmount: item.totalAmount
                    )
                }
                
                createTransactionItemView(
                    name: "Subtotal",
                    totalAmount: totalAmount
                )
            }
            .padding(.horizontal)
            
            Divider()
            
            HStack {
                Text(appliedPayment)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Text("Rp \(totalAmount)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(KredivoColor.orange.toColor)
            }
            .padding(.horizontal)
        }
        .padding(.bottom)
        .frame(maxWidth: .infinity, alignment: .leading)
        .overlay(
            RoundedRectangle(cornerRadius: 8.0)
                .stroke(
                    KredivoColor.gray.toColor,
                    style: StrokeStyle(lineWidth: 1.0)
                )
        )
    }
    
    func createTransactionItemView(name: String, totalAmount: String) -> some View {
        HStack(alignment: .top, spacing: 4.0) {
            Text(name)
                .font(.body)
            
            Spacer()
            
            Text("Rp \(totalAmount)")
        }
    }
    
    func createPaymentMessage(using message: String) -> some View {
        Text(message)
            .font(.body)
            .padding()
            .background(KredivoColor.gray.toColor.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 8.0))
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(
                        KredivoColor.gray.toColor,
                        style: StrokeStyle(lineWidth: 1.0)
                    )
            )
    }
}

#Preview {
    KredivoStatusPageView(
        viewModel: KredivoStatusPageViewModel(
            mobileNumber: "081210728192",
            mobileCreditProductCode: "456",
            mobileCreditLabel: "Kredivo",
            voucherId: nil,
            statusFetcher: KredivoStatusFetcherMock(
                mockResponse: KredivoStatusFetcherMock.loadMock()
            )
        )
    )
}
