//
//  KredivoTransactionDetailsView.swift
//  Kredivo
//
//  Created by Yuga Samuel on 18/05/25.
//

import SwiftUI

struct KredivoTransactionDetailsView: View {
    
    @StateObject var viewModel: KredivoTransactionDetailsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text("Rinican Pembayaran")
                .font(.headline)
            
            VStack(alignment: .leading, spacing: 12.0) {
                createMobileCreditPriceView()
                
                Divider()
                
                if let discountPrice: String = viewModel.formattedDiscountPrice {
                    createDiscountPriceView(using: discountPrice)
                    
                    Divider()
                }
                
                createTotalPriceView()
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
    }
}

private extension KredivoTransactionDetailsView {
    func createMobileCreditPriceView() -> some View {
        HStack {
            Text(viewModel.mobileCredit.label)
                .font(.body)
                .lineLimit(1)
            
            Spacer()
            
            Text(viewModel.mobileCredit.formattedPrice)
                .font(.body)
                .lineLimit(1)
        }
    }
    
    func createTotalPriceView() -> some View {
        HStack {
            Text("Bayar dalam 30 hari")
                .font(.body.bold())
            
            Spacer()
            
            Text(viewModel.finalFormattedPrice)
                .font(.body.bold())
                .foregroundColor(KredivoColor.orange.toColor)
                .lineLimit(1)
        }
    }
    
    func createDiscountPriceView(using discountedPrice: String) -> some View {
        HStack {
            Text("Kredivo Diskon")
                .font(.body.bold())
                .foregroundColor(.secondary)
                .lineLimit(1)
            
            Spacer()
            
            Text("-\(discountedPrice)")
                .font(.body.bold())
                .foregroundColor(.secondary)
                .lineLimit(1)
        }
    }
}

#Preview {
    KredivoTransactionDetailsView(
        viewModel: KredivoTransactionDetailsViewModel(
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
            voucher: .init(
                name: "VOUCHERZEROPERCENT",
                number: 4,
                percentage: 12,
                iterator: 1,
                imageURL: "https://placehold.co/1000x400/239CEC/FFFFFF/png",
                minTransactionAmount: 0,
                endDate: "1682096399",
                id: 4112,
                termsAndCondition: "text",
                howToUse: "text",
                usageCount: 1,
                startDate: "168012121",
                maxDiscount: 0,
                voucherCode: "ABCDE"
            )
        )
    )
}
