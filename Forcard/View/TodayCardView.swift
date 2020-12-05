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
            ZStack{
                Rectangle()
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.156)/*@END_MENU_TOKEN@*/)
                    .shadow(radius: 10)

                UrlImageView(urlString: article.img)
                    .matchedGeometryEffect(id: "image\(article.img)", in: animation)
                    .aspectRatio(contentMode: .fill)

                //.frame(width: UIScreen.main.bounds.width - 30, height: 250)
                LazyVStack{
                    Spacer()
                }
                    HStack{

                        VStack{
                            Spacer()
                                .frame(width: UIScreen.main.bounds.width - 30, height: 215)
                            HStack{
                                VStack{
                            Text(article.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .truncationMode(.tail)
                                }
                                
                                Spacer()
                                    .frame(width: 150, height: UIScreen.main.bounds.height)
                            }
                        }
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                    }
                .frame(width: UIScreen.main.bounds.width - 30, height: 65)
            }
            .matchedGeometryEffect(id: "id\(article.id)", in: animation)
            .frame(width: UIScreen.main.bounds.width, height: 300)
        }
    }
}
