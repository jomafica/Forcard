//
//  UrlImageView.swift
//  Forcard
//
//  Created by Daniel on 22/11/2020.
//

import SwiftUI

struct UrlImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    
    init(urlString: String?) {
        urlImageModel = UrlImageModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlImageView.defaultImage!)
            .resizable()
    }
    
    static var defaultImage = UIImage(named: "NewsIcon")
}

