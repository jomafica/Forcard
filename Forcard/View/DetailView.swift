//
//  DetailView.swift
//  Forcard
//
//  Created by Daniel Pereira on 24/11/2020.
//

import SwiftUI

struct Detail: View {
    @State private var backColor:Color = Color(hue: 1.0, saturation: 0.0, brightness: 0.156)
    @State private var blur = CGFloat(0)
    @ObservedObject var article : NewsFeed
    var animation: Namespace.ID
    @State var showSafari = false
    @State var scale : CGFloat = 1
    
    var body: some View {
        
        ScrollView{
            VStack{
                GeometryReader{reader in
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                        UrlImageView(urlString: article.selectedItem.img)
                            .aspectRatio(contentMode: .fill)
                            .matchedGeometryEffect(id: article.selectedItem.img, in: animation)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.5)
                        }
                    .offset(y: (reader.frame(in: .global).minY > 0 && scale == 1) ? -reader.frame(in: .global).minY : 0)
                    .gesture(DragGesture(minimumDistance: 0).onChanged(onChanged(value:)).onEnded(onEnded(value:)))
                    }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.5)
                VStack{
                    HStack{
                    Text(article.selectedItem.title)
                        .font(.title2)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.white)
                        .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                        .padding()
                    }
                    
                    HStack{
                    
                        Text(article.selectedItem.date)
                            .padding()
                        
                        Spacer()
                            
                        Button(action: {
                            self.showSafari = true
                        }){
                            RoundedRectangle(cornerRadius: 40)
                                .foregroundColor(Color.blue)
                                .overlay(
                                    Text("VIEW")
                                        .foregroundColor(Color.white)
                                )
                                .frame(width: 90.0, height: 30)
                        }
                        .padding()
                        .frame(height: 30)
                        .sheet(isPresented: self.$showSafari) {
                            SafariView(url:URL(string: article.selectedItem.url)!)
                        }
                    }
                    .background(Color.gray)
                    .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .topLeading)
                    Text(article.selectedItem.description ?? "Empty")
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .padding([.leading, .trailing], 10.0)
                    
                }
                .blur(radius: blur)
            }
        }
        .scaleEffect(scale)
        .background(backColor)
        .ignoresSafeArea(.all)
        
    }
    
    func onChanged(value: DragGesture.Value){
        
        let scale = value.translation.height / UIScreen.main.bounds.height
        print(scale)
        withAnimation(.easeInOut(duration: 1)) {
            if 1 - scale > 0.55{
                self.scale = 1 - scale
                self.blur = CGFloat(0)
                self.backColor = Color(hue: 1.0, saturation: 0.0, brightness: 0.156)
                
            }
            if 1 - scale < 1 {
                self.blur = CGFloat(3)
                self.backColor = Color(hue: 1.0, saturation: 0.0, brightness: 0.156).opacity(0.5)
            }
        }
    }
    
    func onEnded(value: DragGesture.Value){
        
        withAnimation(.spring()){
            if scale < 1{
                article.show.toggle()
            }
        }
        self.blur = CGFloat(0)
        self.backColor = Color(hue: 1.0, saturation: 0.0, brightness: 0.156)
        scale = 1
    }
}
 
