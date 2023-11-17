//
//  Header.swift
//  ChatGPT
//
//  Created by Pablo Navarro Zepeda on 14/11/23.
//

import SwiftUI

struct Header: View {
    var menuData = MenuViewModel()
    
    var body: some View {
        HStack (alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
            
            Button(action: {
                withAnimation(.easeInOut){
                    menuData.showDrawer.toggle()
                }
                
            }, label : {
                Image(systemName: "line.3.horizontal.decrease")
                    .foregroundColor(.white)
                    .padding(.horizontal, 5)
                    .font(.title)
                    .fontWeight(.semibold)
            })
                Spacer()
                
                HStack{
                    Text("ChatGPT")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    HStack(spacing: 3){
                        Text("4")
                            .foregroundColor(.gray)
                            .fontWeight(.semibold)
                        
                        Image(systemName: "chevron.forward")
                            .foregroundColor(.gray)
                            .font(.system(size: 14))
                            .fontWeight(.semibold)
                    }
                    
                }
                
                Spacer()
                
                Image(systemName: "square.and.pencil")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.semibold)
                    

            }
        }
}

#Preview {
    ZStack {
        Color("ColorWhite").ignoresSafeArea(.all, edges: .all)
        
        Header().background(Color("ColorBlack"))
    }
    
}
