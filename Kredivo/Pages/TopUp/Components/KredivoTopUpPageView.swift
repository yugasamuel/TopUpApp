//
//  KredivoTopUpPageView.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import SwiftUI

struct KredivoTopUpPageView: View {
    
    @StateObject private var viewModel: KredivoTopUpPageViewModel
    
    @StateObject private var mobileNumberInputViewModel: KredivoMobileNumberInputViewModel
    
    init(viewModel: KredivoTopUpPageViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
        self._mobileNumberInputViewModel = StateObject(wrappedValue: viewModel.mobileNumberInputViewModel)
    }
    
    var body: some View {
        VStack(spacing: .zero) {
            createTabBarView()
            
            ScrollView {
                if viewModel.tabSelection == 0 {
                    createMobileCreditView()
                }
                else {
                    createDataPackageView()
                }
            }
        }
        .onChange(of: viewModel.mobileNumberInputViewModel.isValidMobileNumber) { isValid in
            if isValid {
                Task {
                    await viewModel.fetchMobileCredits()
                }
            }
        }
    }
}

private extension KredivoTopUpPageView {
    func createTabBarView() -> some View {
        HStack(spacing: .zero) {
            Text("Pulsa")
                .font(.body)
                .foregroundColor(viewModel.tabSelection == 0 ? .orange : .secondary)
                .fontWeight(viewModel.tabSelection == 0 ? .bold : nil)
                .frame(maxWidth: .infinity)
                .padding(.bottom)
                .overlay(
                    Rectangle()
                        .frame(height: 3.0)
                        .foregroundColor(viewModel.tabSelection == 0 ? .orange : .clear)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.tabSelection = 0
                }
            
            Text("Data Package")
                .font(.body)
                .foregroundColor(viewModel.tabSelection == 1 ? .orange : .secondary)
                .fontWeight(viewModel.tabSelection == 1 ? .bold : nil)
                .frame(maxWidth: .infinity)
                .padding(.bottom)
                .overlay(
                    Rectangle()
                        .frame(height: 3.0)
                        .foregroundColor(viewModel.tabSelection == 1 ? .orange : .clear)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                )
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.tabSelection = 1
                }
        }
        .padding(.vertical, 8.0)
    }
    
    func createMobileCreditView() -> some View {
        VStack(spacing: 8.0) {
            KredivoMobileNumberInputView(viewModel: mobileNumberInputViewModel)
            
            KredivoMobileCreditListView(viewModel: viewModel.mobileCreditListViewModel)
            
            KredivoPromoBannerView(viewModel: viewModel.promoBannerViewModel)
        }
        .background(Color.secondary.opacity(0.4))
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    func createDataPackageView() -> some View {
        VStack {
            Text("Data package is not available.")
        }
    }
}

#Preview {
    KredivoTopUpPageView(viewModel: KredivoTopUpPageViewModel())
}
