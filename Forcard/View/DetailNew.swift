//
//  teste.swift
//  Forcard
//
//  Created by Daniel Pereira on 02/12/2020.
//

import SwiftUI


struct DetailNew: View {
    @State private var backColor:Color = Color(hue: 1.0, saturation: 0.0, brightness: 0.156)
    @State private var opac = Double(1)
    @State private var frameImg = CGFloat(2.5)
    @State var article : NewsFeed
    @State var states : States
    var animation: Namespace.ID
    @State var showSafari = false
    @State private var viewState = CGSize.zero
    @State private var viewStateSquare = CGSize.zero
    @State private var viewStateCurrent = CGSize.zero
    @State private var viewStateCurrentSquare = CGSize.zero
    
    var body: some View {
        Rectangle()
            .overlay(
                VStack{
                    ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                        UrlImageView(urlString: article.selectedItem.img)
                            .matchedGeometryEffect(id: "image\(article.selectedItem.img)", in: animation)
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / frameImg)
                        
                    }
                    .offset(x: viewState.width , y: viewState.height)
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                self.viewState = value.translation
                                withAnimation {
                                    self.frameImg = CGFloat(4.0)
                                }
                                print(viewState)
                                withAnimation {
                                    if self.viewState.height > self.viewStateCurrent.height {
                                        self.opac = Double(0)
                                        self.backColor = Color(hue: 1.0, saturation: 0.0, brightness: 0.156).opacity(0.5)
                                        self.viewStateCurrent = self.viewState
                                    }
                                    // REFERENCIA NAO APAGAR
                                    // if self.viewState.height < self.viewStateCurrent.height {
                                    //     self.frameImg = CGFloat(2.5)
                                    //     self.opac = Double(1)
                                    //     self.backColor = Color(hue: 1.0, saturation: 0.0, brightness: 0.156)
                                    //     self.viewStateCurrent = self.viewState
                                    // }
                                    
                                    if self.viewState.height < 50 {
                                        self.frameImg = CGFloat(2.5)
                                        self.opac = Double(1)
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
                                        self.frameImg = CGFloat(2.5)
                                        self.opac = Double(1)
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
                                    Spacer()
                                        .frame(width: 20, height: 0)
                                    
                                    LazyVStack(alignment: .leading){
                                        Text(article.selectedItem.title)
                                            .font(.title2)
                                            .foregroundColor(Color.white)
                                            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                    }
                                    
                                    Spacer()
                                        .frame(width: 20, height: 0)
                                }
                                .frame(width: UIScreen.main.bounds.width, height: 80)
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
                                //.background(Color.gray)
                                .background(BlurView(style: .systemThinMaterial))
                                .frame(width: UIScreen.main.bounds.width, height: 50, alignment: .topLeading)
                                VStack{
                                    HStack{
                                        Spacer()
                                            .frame(width: 10, height: 0)
                                        Text(article.selectedItem.description ?? "Empty")
                                            .foregroundColor(Color.white)
                                            .multilineTextAlignment(.leading)
                                            .padding([.leading, .trailing], 10.0)
                                        Spacer()
                                            .frame(width: 10, height: 0)
                                    }
                                }
                            }
                        }
                    }

                } // First VStack
            )
            .offset(x: viewStateSquare.width, y: 0)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.viewStateSquare = value.translation
                        withAnimation {
                            self.frameImg = CGFloat(4.0)
                        }
                        print(viewStateSquare)
                        withAnimation {
                            if self.viewStateSquare.width > self.viewStateCurrentSquare.width {
                                self.opac = Double(0)
                                self.backColor = Color(hue: 1.0, saturation: 0.0, brightness: 0.156).opacity(0.5)
                                self.viewStateCurrentSquare = self.viewStateSquare
                            }
                            if self.viewStateSquare.width < 15 {
                                self.frameImg = CGFloat(2.5)
                                self.opac = Double(1)
                                self.backColor = Color(hue: 1.0, saturation: 0.0, brightness: 0.156)
                                self.viewStateCurrentSquare = self.viewStateSquare
                            }
                        }
                    }
                    .onEnded { value in
                        if self.viewStateSquare.width > 30 {
                            withAnimation(.easeInOut(duration: 0.2)){
                                states.hide.toggle()
                            }
                        } else {
                            withAnimation(.easeInOut(duration: 0.2)){
                                self.frameImg = CGFloat(2.5)
                                self.opac = Double(1)
                                self.backColor = Color(hue: 1.0, saturation: 0.0, brightness: 0.156)
                                self.viewStateSquare = .zero
                            }
                        }
                        
                    }
            )
            .opacity(Double(opac))
            .foregroundColor(backColor)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .cornerRadius(4.0)
            .ignoresSafeArea(.all)
    }
}
