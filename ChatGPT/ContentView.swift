//
//  ContentView.swift
//  ChatGPT
//
//  Created by Manuchim Oliver on 15/03/2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var chatMessages: [ChatMessage] = []
    @State var message: String = ""
    @State var lastMessageID: String = ""
    @State var cancellables = Set<AnyCancellable>()
    
    @StateObject var menuData = MenuViewModel()
    
    @Namespace var animation
    
    @Environment(\.colorScheme) var colorScheme
    
    
    let openAIService = OpenAIService()
    var isLoading: Bool = OpenAIService().isLoading

    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        HStack(spacing: 0){
            
            //Drawer
            Drawer(animation: animation)
            
            
            VStack {
                
                Header(menuData: menuData)
                
                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(alignment: .leading) {
                            ForEach(chatMessages, id: \.id) { message in
                                MessageView(message: message)
                            }
                        }
                    }
                    .onChange(of: self.lastMessageID) { id in
                        withAnimation{
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
                
                MessageInput(message: $message, sendMessage: sendMessage)
                
            }
            .padding()
            .background(menuData.showDrawer ? Color("ColorBlack").opacity(0.8) : Color("ColorBlack") )
            .frame(width: UIScreen.main.bounds.width)
            
            
        }
        //Max Frame..
        .frame(width: UIScreen.main.bounds.width)
        //Moving View...
        // 250/2" -> 125
        .offset(x: menuData.showDrawer ? 155 : -155)
       
        //Setting As Environment Object
        //For Avoiding Re-Declaration
        .environmentObject(menuData)
        
    }
        
    func sendMessage (){
        guard message != "" else {return}
        
       
        let myMessage = ChatMessage(id: UUID().uuidString, content: message, createdAt: Date(), sender: .me)
        chatMessages.append(myMessage)
        lastMessageID = myMessage.id
        
        
        //Comment or unncomment for testing

        let textResponse = "The Roman Empire was incredibly vast, but one fun fact is about their innovative use of concrete. They were among the first to use concrete extensively in construction, which allowed them to build structures like the Pantheon and the Colosseum that have stood for thousands of years. This early concrete was made from a mix of lime, volcanic sand, and ash, making it very durable and resistant to weathering."
        
        let chatGPTMessage = ChatMessage(id: UUID().uuidString, content: textResponse, createdAt: Date(), sender: .chatGPT)
        
        chatMessages.append(chatGPTMessage)
        lastMessageID = chatGPTMessage.id
        
        //When UI is ready uncomment this line
        
        /*
        openAIService.sendMessage(message: message).sink { completion in
            /// - Handle Error here
        } receiveValue: { response in
            guard let textResponse = response.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines.union(.init(charactersIn: "\""))) else {return}
            let chatGPTMessage = ChatMessage(id: response.id, content: textResponse, createdAt: Date(), sender: .chatGPT)
            
            chatMessages.append(chatGPTMessage)
            lastMessageID = chatGPTMessage.id
        }
        .store(in: &cancellables)
            
        */
         
        message = ""
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
