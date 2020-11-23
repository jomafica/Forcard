//
//  CleanerView.swift
//  Forcard
//
//  Created by Daniel on 23/11/2020.
//

import SwiftUI

struct CleanerView: View {
    @Namespace var animation
    @ObservedObject var newsFeed = NewsFeed()
    @EnvironmentObject var detail : NewsFeed
    //var animation: Namespace.ID
    
    var body: some View {
        ScrollView{
                    
                    VStack{
                        
                        HStack(alignment: .bottom) {
                            
                            VStack(alignment: .leading, spacing: 5) {
                                
                                Text("SATURDAY 14 NOVEMBER")
                                    .foregroundColor(.gray)
                                
                                Text("Today")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                            }
                            
                            Spacer()
                            
                            Button(action: {}) {
                                
                                Image(systemName: "person.circle")
                                    .font(.largeTitle)
                            }
                        }
                        .padding()
                        
                        ForEach(newsFeed) {item in
                            
                            // CardView...
                            TodayCardView(item: item,animation: animation)
                       //         .onAppear {
                       //             self.newsFeed.loadMoreArticles(currentItem: article)
                       // }
                                .onTapGesture {
                                    
                                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)){
                                        detail.newsListItems = item
                                        newsFeed.show.toggle()
                                    }
                                }

                    }
                    .padding(.bottom)
                }
            Spinner(isAnimating: newsFeed.isLoading, style: .medium, color: .white)
                .background(Color.primary.opacity(0.06).ignoresSafeArea())
    }
}
}

struct TodayCardView: View {
    var item: NewsListItem
    // getting Current Scheme Color
    @Environment(\.colorScheme) var color
    var animation: Namespace.ID
    
    var body: some View {
        
        VStack{
            
            UrlImageView(urlString: item.img)
                .aspectRatio(contentMode: .fill)
                .matchedGeometryEffect(id: item.img, in: animation)
                .frame(width: UIScreen.main.bounds.width - 30, height: 250)
            
            HStack{
                
                Image(item.img)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 65, height: 65)
                    .cornerRadius(15)
                
                VStack(alignment: .leading, spacing: 6) {
                    
                    Text(item.title)
                        .fontWeight(.bold)
                    
                    Text(item.description ?? "No Description")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer(minLength: 0)
                
                VStack{
                    
                    Button(action: {}) {
                        
                        Text("GET")
                            .fontWeight(.bold)
                            .padding(.vertical,10)
                            .padding(.horizontal,25)
                            .background(Color.primary.opacity(0.1))
                            .clipShape(Capsule())
                    }
                    
                    Text("In App Purchases")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            .matchedGeometryEffect(id: item.id, in: animation)
            .padding()
        }
        .background(color == .dark ? Color.black : Color.white)
        .cornerRadius(15)
        .padding(.horizontal)
        .padding(.top)
    }


    struct Detail: View {
        // Getting Current Selected Item...
        @ObservedObject var detail : NewsFeed
        var article: NewsListItem
        var animation: Namespace.ID
        
        @State var scale : CGFloat = 1
        
        var body: some View {

            ScrollView{
                
                VStack{
                    
                    // Updated Code For Avoiding Top Scroll
                    GeometryReader{reader in
                        
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                            
                            Image(article.img)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .matchedGeometryEffect(id: article.img, in: animation)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.5)

                            HStack{
                                
                                Text(article.title)
                                    .font(.title)
                                    .fontWeight(.heavy)
                                    .foregroundColor(.white)
                                
                                Spacer(minLength: 0)
                                
                                Button(action: {
                                    withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8, blendDuration: 0.8)){

                                        detail.show.toggle()
                                        
                                    }
                                }) {
                                    
                                    Image(systemName: "xmark")
                                        .foregroundColor(Color.black.opacity(0.7))
                                        .padding()
                                        .background(Color.white.opacity(0.8))
                                        .clipShape(Circle())
                                }
                            }
                            .padding(.horizontal)
                            // since we ignored top area...
                            .padding(.top,UIApplication.shared.windows.first!.safeAreaInsets.top + 10)
                        }
                            .offset(y: (reader.frame(in: .global).minY > 0 && scale == 1) ? -reader.frame(in: .global).minY : 0)
                        // Gesture For Closing Detail View....
                        .gesture(DragGesture(minimumDistance: 0).onChanged(onChanged(value:)).onEnded(onEnded(value:)))
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.5)
                    
                    HStack{
                        
                        Image(article.img)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 65, height: 65)
                            .cornerRadius(15)
                        
                        VStack(alignment: .leading, spacing: 6) {
                            
                            Text(article.title)
                                .fontWeight(.bold)
                            
                            Text(article.description ?? "No description")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer(minLength: 0)
                        
                        VStack{
                            
                            Button(action: {}) {
                                
                                Text("GET")
                                    .fontWeight(.bold)
                                    .padding(.vertical,10)
                                    .padding(.horizontal,25)
                                    .background(Color.primary.opacity(0.1))
                                    .clipShape(Capsule())
                            }
                            
                            Text("In App Purchases")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .matchedGeometryEffect(id: article.id, in: animation)
                    .padding()
                    
                    Text(article.description ?? "No Description")
                        .padding()

                    Button(action: {}) {
                        
                        Label(title: {
                            Text("Share")
                                .foregroundColor(.primary)
                        }) {
                            
                            Image(systemName: "square.and.arrow.up.fill")
                                .font(.title2)
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical,10)
                        .padding(.horizontal,25)
                        .background(Color.primary.opacity(0.1))
                        .cornerRadius(10)
                    }
                    .padding()
                }
            }
            .scaleEffect(scale)
            .ignoresSafeArea(.all, edges: .top)
        }
        
        func onChanged(value: DragGesture.Value){
            
            // calculating scale value by total height...
            
            let scale = value.translation.height / UIScreen.main.bounds.height
            
            // if scale is 0.1 means the actual scale will be 1- 0.1 => 0.9
            // limiting scale value...
            
            if 1 - scale > 0.75{
            
                self.scale = 1 - scale
            }
        }
        
        func onEnded(value: DragGesture.Value){
            
            withAnimation(.spring()){
                
                // closing detail view when scale is less than 0.9...
                if scale < 0.9{
                    detail.show.toggle()
                }
                scale = 1
            }
        }
    }
}
