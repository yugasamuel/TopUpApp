//
//  KredivoErrorView.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import SwiftUI

struct KredivoErrorView: View {
    
    let title: String
    let onTryAgain: (() -> Void)?
    
    var body: some View {
        VStack(spacing: 16.0) {
            Image(systemName: "x.circle.fill")
                .resizable()
                .frame(width: 50.0, height: 50.0)
                .foregroundColor(KredivoColor.orange.toColor)
            
            Text(title)
                .font(.body)
            
            if let onTryAgain {
                Button(action: onTryAgain) {
                    Text("Try again")
                        .fontWeight(.bold)
                }
            }
        }
        .padding()
    }
}

#Preview {
    KredivoErrorView(
        title: "Network error. Please try again.",
        onTryAgain: {
            print("Try again.")
        }
    )
}
