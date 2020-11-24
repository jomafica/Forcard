//
//  CardView.swift
//  Forcard
//
//  Created by Daniel Pereira on 24/11/2020.
//

import SwiftUI

struct TodayCardView: View {
    var article: NewsListItem
    @StateObject var newsFeed = NewsFeed()
    //@State var showSafari = false
    var animation: Namespace.ID
    
    var body: some View {
        VStack{
            UrlImageView(urlString: article.img)
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 30, height: 250)
                .matchedGeometryEffect(id: article.img, in: animation)
            
            HStack{
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(article.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .lineLimit(2)
                        .truncationMode(.tail)
                }
                Spacer(minLength: 0)
            }
            //.matchedGeometryEffect(id: article.id, in: animation)
            .padding()
        }
        .background(/*@START_MENU_TOKEN@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.156)/*@END_MENU_TOKEN@*/)
        .shadow(radius: 8)
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.top)
    }
}