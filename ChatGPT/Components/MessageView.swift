//
//  MessageView.swift
//  ChatGPT
//
//  Created by Manuchim Oliver on 15/03/2023.
//

import SwiftUI

struct MessageView: View {
    var message: ChatMessage
    var body: some View {
        
        HStack(alignment: .top){
            VStack(alignment: .center){
                Image(message.sender == .me ? "Pablo-Icon2" : "ChatGPT-Icon")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 40,height: 40)
            }
           
            VStack(alignment: .leading){
                Text(message.sender == .me ? "Pablo" : "ChatGPT").bold()
                    .padding(.bottom, 5)
                    .padding(.top, 8)
                    .foregroundColor(.white)
                Text(message.content)
                    .foregroundColor(.white)
                    .padding(.bottom, 15)
            }
            
            Spacer()
            
        }.padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
        
        }
           
}

struct MessageView_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            MessageView(message: ChatMessage(id: UUID().uuidString, content: "Tell me a random fun fact about the Roman Empire", createdAt: Date(), sender: .me))
                .previewDisplayName("User Input")
            
            MessageView(message: ChatMessage(id: UUID().uuidString, content: "The Roman Empire was incredibly vast, but one fun fact is about their innovative use of concrete. They were among the first to use concrete extensively in construction, which allowed them to build structures like the Pantheon and the Colosseum that have stood for thousands of years. This early concrete was made from a mix of lime, volcanic sand, and ash, making it very durable and resistant to weathering.", createdAt: Date(), sender: .chatGPT))
                .previewDisplayName("ChatGPT Response")
        }
        .previewLayout(.sizeThatFits)
        .background(Color("ColorBlack"))
    }
}
