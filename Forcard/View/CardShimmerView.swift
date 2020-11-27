//
//  CardShimmerView.swift
//  Forcard
//
//  Created by Daniel Pereira on 27/11/2020.
//

import SwiftUI

struct CardShimmer : View {
      
      @State var show = false
      var center = (UIScreen.main.bounds.width / 2) + 310
      
      var body : some View{
          ZStack{
            Color(hue: 1.0, saturation: 0.0, brightness: 0.156)
              Color.black.opacity(0.09)
              .frame(height: 320)
              .cornerRadius(10)
              
              Color.gray
              .frame(height: 320)
              .cornerRadius(10)
              .mask(
              
                  Rectangle()
                    .fill(
                      LinearGradient(gradient: .init(colors: [.clear,Color.white.opacity(0.48),.clear]), startPoint: .top, endPoint: .bottom)
                    )
                    .rotationEffect(.init(degrees: 70))
                    .offset(x: self.show ? center : -center)
              
              )
          }
          .cornerRadius(10)
          .padding(.horizontal)
          .onAppear {
              
            withAnimation(Animation.default.speed(0.5).delay(0).repeatForever(autoreverses: false)){
                  
                  self.show.toggle()
              }
          }
      }
  }
