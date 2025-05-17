//
//  KredivoMobileNumberInputView.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import SwiftUI

struct KredivoMobileNumberInputView: View {
    
    @StateObject var viewModel: KredivoMobileNumberInputViewModel
    
    var body: some View {
        HStack(spacing: 8.0) {
            VStack {
                if viewModel.isValidMobileNumber {
                    Image(systemName: "t.circle.fill")
                        .resizable()
                        .frame(width: 24.0, height: 24.0)
                        .foregroundColor(.red)
                }
                else {
                    Image(systemName: "network")
                        .resizable()
                        .frame(width: 24.0, height: 24.0)
                        .foregroundColor(.orange)
                }
            }
            .padding(8.0)
            .overlay(
                Circle()
                    .stroke(style: StrokeStyle(lineWidth: 3.0))
                    .foregroundColor(.blue)
            )
            .clipShape(.circle)
            .animation(.default, value: viewModel.isValidMobileNumber)
            
            VStack(alignment: .leading, spacing: 8.0) {
                Text("Mobile number")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                TextField(
                    "Input your mobile number here...",
                    text: $viewModel.mobileNumber
                )
                .keyboardType(.numberPad)
                .font(.body)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding(.trailing, 54.0)
                .overlay(
                    HStack {
                        Button(action: {
                            viewModel.mobileNumber = ""
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .frame(width: 20.0, height: 20.0)
                                .foregroundColor(.secondary)
                                .background(Color.white)
                        })
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "person.crop.rectangle.stack.fill")
                                .resizable()
                                .frame(width: 20.0, height: 20.0)
                                .foregroundColor(.secondary)
                        })
                    }
                )
                
                Rectangle()
                    .frame(height: 2.0)
                    .foregroundColor(.secondary.opacity(0.1))
            }
        }
        .padding()
        .background(Color.white)
        .onChange(of: viewModel.mobileNumber) { mobileNumber in
            viewModel.onChangeMobileNumber(mobileNumber)
        }
    }
}

#Preview {
    KredivoMobileNumberInputView(viewModel: KredivoMobileNumberInputViewModel())
}
