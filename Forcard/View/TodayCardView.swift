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
                    .aspectRatio(2.0, contentMode: .fill)
                    .frame(width: UIScreen.main.bounds.width, height: 215)

                LazyVStack{
                    Spacer()
                }
                HStack{
                    VStack{
                        Spacer()
                            .frame(width: UIScreen.main.bounds.width - 30, height: 215)
                        HStack{
                            ZStack{
                                VStack{
                                    Text(article.title)
                                        .font(.subheadline)
                                        .foregroundColor(Color.white)
                                        .lineLimit(2)
                                }
                                .frame(width: 170, height: 35)
                                .padding()
                            }
                            .background(BlurView(style: .systemThinMaterial))
                            .cornerRadius(25)
                            Spacer()
                                .frame(width: 30, height: 0)
                            
                            VStack{
                                Spacer()
                                    .frame(width: 0, height: 25)
                                
                                Text(article.date)
                                    .font(.subheadline)
                                    .foregroundColor(Color.white)
                            }
                            Spacer()
                                .frame(width: 25, height: UIScreen.main.bounds.height)
                        }
                    }
                    .padding()
                    .fixedSize(horizontal: false, vertical: true)
                }
                .frame(width: UIScreen.main.bounds.width - 30, height: 65)
            }
            .frame(width: UIScreen.main.bounds.width, height: 215)
        }
    }
}
