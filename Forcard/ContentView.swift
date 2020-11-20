//
//  ContentView.swift
//  Forcard
//
//  Created by Daniel Pereira on 06/11/2020.
//

import Foundation
import SwiftUI
import SafariServices
import Combine

struct ContentView: View {
    
    var body: some View {
        ZStack{
            Color(red: 0.1, green: 0.1, blue: 0.1).edgesIgnoringSafeArea(.all)
                    cards()
                    statusBarView
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

struct cards: View {
    @State var Loading = true
    @StateObject var networkManager = NetworkManager()
    @State private var moveRightLeft = false
    @State var showSafari = false
    
    var body: some View {
        if networkManager.articles.isEmpty {
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
        RefreshableScrollView(height: 70, refreshing: self.$networkManager.loading) {
        LazyVStack(spacing: 30) {
            ForEach(networkManager.articles, id: \.id){ Art_jbody in
                Button(action: {
                    self.showSafari = true
                }){
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: 350.0, height: 350.0)
                    .foregroundColor(/*@START_MENU_TOKEN@*/Color(hue: 1.0, saturation: 0.0, brightness: 0.156)/*@END_MENU_TOKEN@*/)
                    .shadow(radius: 8)
                    .overlay(
                        VStack(alignment: .center){
                            RemoteImage(url: Art_jbody.content.img_art)
                                .cornerRadius(20, corners: [.topLeft,.topRight])
                            Spacer()
                                .frame(height: 10)
                            Text(Art_jbody.content.title_art)
                                .padding(.horizontal, 15.0)
                                .frame(maxWidth: 340, alignment: .topLeading)
                                .lineLimit(2)
                                .truncationMode(.tail)
                                .font(.headline)
                                .foregroundColor(Color.white)
                            Spacer()
                            Text(Art_jbody.content.description)
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
                    SafariView(url:URL(string: Art_jbody.content.url_art)!)
            }
                    }
                    }
                }
            }
        }
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

