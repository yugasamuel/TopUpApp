//
//  KredivoImageView.swift
//  Kredivo
//
//  Created by Yuga Samuel on 17/05/25.
//

import Foundation
import SwiftUI
import UIKit

struct KredivoImageView: View {
    
    @StateObject private var imageLoader: KredivoImageLoader
    
    private let width: CGFloat?
    private let height: CGFloat?
    
    init(
        url: String,
        width: CGFloat? = nil,
        height: CGFloat? = nil
    ) {
        _imageLoader = StateObject(
            wrappedValue: KredivoImageLoader(
                url: url,
                imagePreloader: KredivoImageViewPreloader()
            )
        )
        self.width = width
        self.height = height
    }
    
    var body: some View {
        HStack {
            switch imageLoader.state {
            case .loading:
                Image(systemName: "loading.circle")
                    .resizable()
                    .onAppear {
                        preloadImage()
                    }
            case .error:
                Image(systemName: "error")
                    .resizable()
                    .scaledToFill()
                    .clipped()
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
            }
        }
    }
    
    func preloadImage() {
        _imageLoader.wrappedValue.loadImage()
    }
}

enum KredivoImageLoaderState: Equatable {
    case loading
    case error
    case success(image: Image)
}

final class KredivoImageLoader: ObservableObject {
    
    private let url: String
    private let imageView: UIImageView = UIImageView()
    private let imagePreloader: KredivoImageViewPreloader
    
    @Published var state: KredivoImageLoaderState = .loading
    
    init(
        url: String,
        imagePreloader: KredivoImageViewPreloader
    ) {
        self.url = url
        self.imagePreloader = imagePreloader
    }
    
    func loadImage() {
        guard let url: URL = URL(string: url), state == .loading else { return }
        
        imagePreloader.preloadImage(
            imageView: imageView,
            url: url,
            onComplete: { [weak self] uiImage in
                guard let self else { return }
                guard let uiImage: UIImage else {
                    // Setup state to failed
                    self.state = .error
                    return
                }
                // Setup state to success
                let image: Image = Image(uiImage: uiImage)
                self.state = .success(image: image)
            }
        )
    }
}

final class KredivoImageViewPreloader {
    
    init() { }
    
    func preloadImage(
        imageView: UIImageView,
        url: URL,
        onComplete: @escaping (_ image: UIImage?) -> Void
    ) {
        let request: URLRequest = URLRequest(url: url)
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            guard let data: Data = data, let image: UIImage = UIImage(data: data), error == nil else {
                DispatchQueue.main.async {
                    onComplete(nil)
                }
                return
            }
            
            DispatchQueue.main.async {
                imageView.image = image
                onComplete(image)
            }
        }
        
        task.resume()
    }
}
