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
    @State private var refresh = true
    @StateObject var states = States()
        
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
                //Color.white.edgesIgnoringSafeArea(.all)
                Color(red: 0.1, green: 0.1, blue: 0.1).edgesIgnoringSafeArea(.all)
                RefreshableScrollView(height: 70, refreshing: self.$newsFeed.refresh) {
                    LazyVStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 60) {
                        ForEach(newsFeed.newsListItems) { article in
                            TodayCardView(article: article, animation: animation, states: states)
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.3)){
                                        newsFeed.selectedItem = article
                                        states.hide.toggle()
                                    }
                                }
                                .onAppear {
                                    self.newsFeed.loadMoreArticles(currentItem: article)
                                }
                                .frame(maxWidth: .infinity)
                            
                            }
                            }
                    VStack{
                        Spacer()
                            .frame(width: 0, height: 40)
                        Spinner(isAnimating: newsFeed.isLoading, style: .medium, color: .white)
                    }
                }
                statusBarView
                if states.hide{
                    DetailNew(article: newsFeed, states: states, animation: animation)
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
