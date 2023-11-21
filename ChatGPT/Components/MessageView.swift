//
//  MessageView.swift
//  ChatGPT
//
//  Created by Manuchim Oliver on 15/03/2023.
//

import SwiftUI

struct MessageView: View {
    var message: [String: String]
    var body: some View {
        
        HStack(alignment: .top){
            VStack(alignment: .center){
                Image(message["role"] == "user" ? "Pablo-Icon2" : "ChatGPT-Icon")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 30,height: 30)
            }.padding(.top, 3)
           
            VStack(alignment: .leading){
                Text(message["role"] == "user" ? "Pablo" : "ChatGPT").bold()
                    .padding(.bottom, 5)
                    .padding(.top, 8)
                    .foregroundColor(.white)
                Text(message["content"] ?? "error")
                    .foregroundColor(.white)
                    .padding(.bottom, 15)
            }
            
            Spacer()
            
        }.padding(EdgeInsets(top: 5, leading: 5, bottom: 3, trailing: 5))
        
        }
           
}

struct MessageView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            MessageView(message: ["role": "user", "content": "Hello!"])
            
            MessageView(message: ["role": "assistant", "content": "How are you?"])
        }
        .previewLayout(.sizeThatFits)
        .background(Color("ColorBlack"))
    }
}
