//
//  NewsFeedView.swift
//  Forcard
//
//  Created by Daniel on 22/11/2020.
//

import SwiftUI

struct NewsFeedView: View {
    @ObservedObject var newsFeed = NewsFeed()
    @State private var moveRightLeft = false
    @State var refresh = true
    
    var body: some View {
        if newsFeed.isEmpty {
            ZStack {
                Capsule()  // Inactive
                    .frame(width: 128, height: 6, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .foregroundColor(Color(.systemGray4))

                 Capsule()
                    .clipShape(Rectangle().offset(x: moveRightLeft ? 80 : -80))
                    .frame(width: 100, height: 6, alignment: .leading)
                    .foregroundColor(Color(.systemBlue))
                    .offset(x: moveRightLeft ? 14 : -14)
                    .animation(Animation.easeInOut(duration: 0.5).delay(0.2).repeatForever(autoreverses: true))
                    .onAppear {
                        moveRightLeft.toggle()
                        }
                }
        } else {
            ZStack{
                Color(red: 0.1, green: 0.1, blue: 0.1).edgesIgnoringSafeArea(.all)
                    RefreshableScrollView(height: 70, refreshing: self.$newsFeed.refresh) {
                        LazyVStack(spacing: 30) {
                            ForEach(newsFeed) { (article: NewsListItem) in
                                NewsListItemListView(article: article)
                                    .onAppear {
                                        self.newsFeed.loadMoreArticles(currentItem: article)
                            }
                        }
                    }
                        Spinner(isAnimating: newsFeed.isLoading, style: .medium, color: .white)
                }
            statusBarView
            }
        }
    }
}
            
    var statusBarView: some View {
        GeometryReader { geometry in
            Color(red: 0.1, green: 0.1, blue: 0.1)
                .frame(height: geometry.safeAreaInsets.top, alignment: .top)
                .edgesIgnoringSafeArea(.top)
        }
    }

struct NewsListItemListView: View {
    var article: NewsListItem
    @State var showSafari = false
    
    var body: some View {
        Button(action: {
            self.showSafari = true
        }){
        RoundedRectangle(cornerRadius: 20)
            .frame(width: 350.0, height: 350.0)
            .foregroundColor(/*@START_MENU_TOKEN@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.156)/*@END_MENU_TOKEN@*/)
            .shadow(radius: 8)
            .overlay(
                VStack(alignment: .center){
                    RemoteImage(url: article.img)
                        .cornerRadius(20, corners: [.topLeft,.topRight])
                    Spacer()
                        .frame(height: 10)
                    Text(article.title)
                        .padding(.horizontal, 15.0)
                        .frame(maxWidth: 340, alignment: .topLeading)
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .font(.headline)
                        .foregroundColor(Color.white)
                    Spacer()
                    Text(article.description ?? "View inside")
                        .padding(.horizontal, 15.0)
                        .frame(maxWidth: 340, alignment: .topLeading)
                        .lineLimit(2)
                        .truncationMode(.tail)
                        .font(.footnote)
                        .foregroundColor(Color.white)
                    Spacer()
                        .frame(height: 15)
                        .scaledToFill()

                     }
                .frame(width: 350.0, height: 350.0)
                )
            }
            .sheet(isPresented: self.$showSafari) {
                SafariView(url:URL(string: article.url)!)
            }
    }
}

struct NewsFeedView_Previews: PreviewProvider {
    static var previews: some View {
        NewsFeedView()
    }
}
