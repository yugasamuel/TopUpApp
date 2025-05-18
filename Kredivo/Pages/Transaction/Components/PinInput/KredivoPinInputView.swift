//
//  KredivoPinInputView.swift
//  Kredivo
//
//  Created by Yuga Samuel on 18/05/25.
//

import SwiftUI

struct KredivoPinInputView: View {
    
    @StateObject var viewModel: KredivoPinInputViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20.0) {
            Text("PIN Kredivo")
                .font(.headline)
            
            HStack {
                VStack {
                    if viewModel.isPinVisible {
                        TextField("Masukkan PIN", text: $viewModel.pin)
                            .keyboardType(.numberPad)
                    } else {
                        SecureField("Masukkan PIN", text: $viewModel.pin)
                            .keyboardType(.numberPad)
                    }
                }
                .frame(height: 24.0)
                
                Button(action: {
                    viewModel.isPinVisible.toggle()
                }) {
                    Image(systemName: viewModel.isPinVisible ? "eye.slash.fill" : "eye.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30.0)
                        .foregroundColor(.gray)
                }
            }
            .padding(16.0)
            .overlay(
                RoundedRectangle(cornerRadius: 8.0)
                    .stroke(KredivoColor.blue.toColor, lineWidth: 2.0)
            )
            .overlay(
                Text("PIN")
                    .font(.subheadline)
                    .padding(4.0)
                    .background(Color.white)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
                    .offset(x: 16.0, y: -12.0)
            )
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
    }
}

#Preview {
    KredivoPinInputView(viewModel: KredivoPinInputViewModel())
        .padding()
}
