//
//  ImageView.swift
//  Forcard
//
//  Created by Daniel Pereira on 29/11/2020.
//

import SwiftUI

import SwiftUI

struct ImageView: View {
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

