//
//  ContentView.swift
//  Forcard
//
//  Created by Daniel Pereira on 06/11/2020.
//

import Foundation
import SwiftUI
import SafariServices

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


struct ContentView: View {

    @StateObject var networkManager = NetworkManager()
    @State var showSafari = false
    var body: some View {
        ZStack{
            Color(red: 0.1, green: 0.1, blue: 0.1).edgesIgnoringSafeArea(.all)
                ScrollView(showsIndicators: false) {
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
                            .sheet(isPresented: $showSafari) {
                                SafariView(url:URL(string: Art_jbody.content.url_art)!)
                        }
                        }
                    }
                }
            statusBarView
         }
    }
}



    extension View {
        func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
            clipShape( RoundedCorner(radius: radius, corners: corners) )
            }
        }

        var statusBarView: some View {
            GeometryReader { geometry in
                Color(red: 0.1, green: 0.1, blue: 0.1)
                    .frame(height: geometry.safeAreaInsets.top, alignment: .top)
                    .edgesIgnoringSafeArea(.top)
            }
        }

    struct SafariView: UIViewControllerRepresentable {
    
        let url: URL
    
        func makeUIViewController(context: 	UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
            return SFSafariViewController(url: url)
        }
    
        func updateUIViewController(_ uiViewController: SFSafariViewController, context: 	UIViewControllerRepresentableContext<SafariView>) {
    
        }
    
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

