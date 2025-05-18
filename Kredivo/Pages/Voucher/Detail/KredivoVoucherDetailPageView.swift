//
//  KredivoVoucherDetailPageView.swift
//  Kredivo
//
//  Created by Yuga Samuel on 18/05/25.
//

import SwiftUI

struct KredivoVoucherDetailPageView: View {
    
    let viewModel: KredivoVoucherDetailPageViewModel
    
    var body: some View {
        VStack(
            alignment: .leading,
            spacing: 12.0
        ) {
            KredivoImageView(url: viewModel.voucher.imageURL)
                .scaledToFit()
            
            HStack {
                VStack(alignment: .leading, spacing: 8.0) {
                    Text(viewModel.voucher.name)
                        .font(.headline)
                        
                    if let formattedEndDate: String = viewModel.voucher.formattedEndDate {
                        Text("Berlaku hingga ")
                            .font(.body)
                        +
                        Text(formattedEndDate)
                            .font(.body.bold())
                    }
                }
                
                Spacer()
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
        .padding()
    }
}

#Preview {
    KredivoVoucherDetailPageView(
        viewModel: KredivoVoucherDetailPageViewModel(
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
