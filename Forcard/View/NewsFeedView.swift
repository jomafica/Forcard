//
//  NewsFeedView.swift
//  Forcard
//
//  Created by Daniel on 22/11/2020.
//

import SwiftUI

struct NewsFeedView: View {
    @StateObject var newsFeed = NewsFeed()
    @Namespace private var animation
    @State private var moveRightLeft = false
    @State private var refresh = true
        
    var body: some View {
        if newsFeed.newsListItems.isEmpty {
            ZStack{
                Color(red: 0.1, green: 0.1, blue: 0.1).edgesIgnoringSafeArea(.all)
                    ScrollView(showsIndicators: false){
                            ForEach(0...2, id: \.self) { _ in
                                CardShimmer()
                    }
                }
                statusBarView
            }
        } else {
            ZStack{
                Color(red: 0.1, green: 0.1, blue: 0.1).edgesIgnoringSafeArea(.all)
                RefreshableScrollView(height: 70, refreshing: self.$newsFeed.refresh) {
                    LazyVStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 25) {
                        ForEach(newsFeed.newsListItems) { article in
                            TodayCardView(article: article, animation: animation)
                                .onTapGesture {
                                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)){
                                        newsFeed.selectedItem = article
                                        newsFeed.show.toggle()
                                    }
                                }
                                .onAppear {
                                    self.newsFeed.loadMoreArticles(currentItem: article)
                                }
                                .frame(maxWidth: .infinity)
                            }
                        Spinner(isAnimating: newsFeed.isLoading, style: .medium, color: .white)
                    }
                }
                statusBarView
                if newsFeed.show{
                    Detail(article: newsFeed, animation: animation)
                }
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
