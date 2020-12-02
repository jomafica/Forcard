//
//  CardView.swift
//  Forcard
//
//  Created by Daniel Pereira on 24/11/2020.
//

import SwiftUI

struct TodayCardView: View {
    var article: NewsListItem
    var animation: Namespace.ID
    @State var states : States
    
    var body: some View {
        if !states.hide{
        VStack{
            UrlImageView(urlString: article.img)
                .matchedGeometryEffect(id: "image\(article.id)", in: animation)
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 30, height: 250)
            
                HStack{
                    VStack(alignment: .leading) {
                        Text(article.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.white)
                            .lineLimit(2)
                            .truncationMode(.tail)
                    }
                    .frame(width: 300, height: 65, alignment: .leading)
                }
                .background(/*@START_MENU_TOKEN@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.156)/*@END_MENU_TOKEN@*/)
                .shadow(radius: 8)
                .cornerRadius(10)
            }
        }
    }
}
