//
//  KredivoVoucherInputView.swift
//  Kredivo
//
//  Created by Yuga Samuel on 18/05/25.
//

import SwiftUI

struct KredivoVoucherInputView: View {
    
    @StateObject var viewModel: KredivoVoucherInputViewModel
    
    let onTapVoucherInput: (() -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text("Voucher")
                .font(.headline)
            
            switch viewModel.state {
            case .empty:
                createVoucherInputEmptyState()
                    .onTapGesture {
                        onTapVoucherInput?()
                    }
            case .filled(let voucher):
                createVoucherInputFilledState(using: voucher)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
    }
}

private extension KredivoVoucherInputView {
    func createVoucherInputEmptyState() -> some View {
        HStack {
            Image(systemName: "percent")
                .resizable()
                .scaledToFit()
                .frame(width: 10.0, height: 10.0)
                .foregroundColor(Color.white)
                .padding(5.0)
                .background(
                    Circle()
                        .foregroundColor(KredivoColor.orange.toColor)
                )
            
            Text("Voucher untukmu")
                .font(.body.bold())
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text("Lihat")
                .font(.body.bold())
                .foregroundColor(KredivoColor.orange.toColor)
                .padding(.vertical, 8.0)
                .padding(.horizontal, 12.0)
                .background(
                    RoundedRectangle(cornerRadius: 6.0)
                        .foregroundColor(KredivoColor.orange.toColor.opacity(0.2))
                )
        }
        .padding(12.0)
        .overlay(
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(
                    KredivoColor.gray.toColor.opacity(0.5),
                    lineWidth: 1.0
                )
        )
    }
    
    func createVoucherInputFilledState(using voucher: KredivoVoucherItem) -> some View {
        HStack(alignment: .top) {
            Image(systemName: "checkmark")
                .resizable()
                .scaledToFit()
                .frame(width: 8.0, height: 8.0)
                .foregroundColor(Color.white)
                .padding(6.0)
                .background(
                    Circle()
                        .foregroundColor(KredivoColor.green.toColor)
                )
            
            VStack(alignment: .leading, spacing: 6.0) {
                Text(voucher.name)
                    .font(.headline)
                
                Text("Yeay! Kamu mendapatkan promo \(voucher.percentage)%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 20.0, height: 20.0)
                .foregroundColor(Color.gray)
                .onTapGesture {
                    viewModel.setVoucherState(.empty)
                }
        }
        .padding(12.0)
        .background(
            RoundedRectangle(cornerRadius: 4.0)
                .foregroundColor(KredivoColor.green.toColor.opacity(0.15))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 4.0)
                .stroke(KredivoColor.green.toColor, lineWidth: 1.0)
        )
    }
}

#Preview {
    KredivoVoucherInputView(viewModel: KredivoVoucherInputViewModel()) { }
        .padding()
}
