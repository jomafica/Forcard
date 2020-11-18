//
//  ContentView.swift
//  Forcard
//
//  Created by Daniel Pereira on 06/11/2020.
//

import Foundation
import SwiftUI
import SafariServices



struct ContentView: View {
    
    @State var isLoading = true
    
    var body: some View {
        ZStack{
            Color(red: 0.1, green: 0.1, blue: 0.1).edgesIgnoringSafeArea(.all)
                if isLoading {
                    LoadingView()
                } else {
                    statusBarView
                    cards()
                }
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isLoading = false
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

struct LoadingView: View {
    @State var isLoading = true
    
    var body: some View {
        ZStack {
         
                    Text("Fetching Data")
                        .font(.system(.body, design: .rounded))
                        .bold()
                        .offset(x: 0, y: -25)
         
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color(.systemGray5), lineWidth: 3)
                        .frame(width: 250, height: 3)
         
                    RoundedRectangle(cornerRadius: 3)
                        .stroke(Color.blue, lineWidth: 3)
                        .frame(width: 30, height: 3)
                        .offset(x: isLoading ? 110 : -110, y: 0)
                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
                }

            }
    }

struct cards: View{
    @StateObject public var networkManager = NetworkManager()
    @State var showSafari = false
    
    struct SafariView: UIViewControllerRepresentable {

        let url: URL

        func makeUIViewController(context:     UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
            return SFSafariViewController(url: url)
        }

        func updateUIViewController(_ uiViewController: SFSafariViewController, context:     UIViewControllerRepresentableContext<SafariView>) {

        }

    }
    var body: some View {
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

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
        }
    }


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            
    }
}

