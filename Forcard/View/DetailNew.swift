//
//  teste.swift
//  Forcard
//
//  Created by Daniel Pereira on 02/12/2020.
//

import SwiftUI


struct DetailNew: View {
    @State private var backColor:Color = Color(hue: 1.0, saturation: 0.0, brightness: 0.156)
    @State private var blur = CGFloat(0)
    @State var article : NewsFeed
    @State var states : States
    var animation: Namespace.ID
    @State var showSafari = false
    @State private var viewState = CGSize.zero
    @State private var viewStateCurrent = CGSize.zero
    
    var body: some View {
            VStack{
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                        UrlImageView(urlString: article.selectedItem.img)
                                .matchedGeometryEffect(id: "image\(article.selectedItem.img)", in: animation)
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.5)

                        }
                    .offset(x: viewState.width , y: viewState.height)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                self.viewState = value.translation
                                print(viewState)
                                withAnimation {
                                    if self.viewState.height > self.viewStateCurrent.height {
                                        self.blur = CGFloat(3)
                                        self.backColor = Color(hue: 1.0, saturation: 0.0, brightness: 0.156).opacity(0.5)
                                        self.viewStateCurrent = self.viewState
                                    }
                                    if self.viewState.height < self.viewStateCurrent.height {
                                        self.blur = CGFloat(0)
                                        self.backColor = Color(hue: 1.0, saturation: 0.0, brightness: 0.156)
                                        self.viewStateCurrent = self.viewState
                                    }
                                }
                            }
                            .onEnded { value in
                                if self.viewState.height > 135 {
                                    withAnimation(.easeInOut(duration: 0.2)){
                                    states.hide.toggle()
                                    }
                                } else {
                                    withAnimation(.easeInOut(duration: 0.2)){
                                    self.blur = CGFloat(0)
                                    self.backColor = Color(hue: 1.0, saturation: 0.0, brightness: 0.156)
                                    self.viewState = .zero
                                    }
                                }
                    
                        }
                    )
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.5)
                ScrollView{
                if states.hide{
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
                }
            }
                .blur(radius: blur)
        } // First VStack
        .matchedGeometryEffect(id: "id\(article.selectedItem.id)", in: animation)
        .background(backColor)
        .ignoresSafeArea(.all)
    }
}
