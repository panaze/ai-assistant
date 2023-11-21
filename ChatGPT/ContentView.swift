//
//  ContentView.swift
//  ChatGPT
//
//  Created by Pablo Navarro on 21/11/2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    //@State var chatMessages: [ChatMessage] = []
    @State var message: String = ""
    @State var lastMessageID: String = ""
    @State var cancellables = Set<AnyCancellable>()
    
    @EnvironmentObject var connector: OpenAIConnector
    
    @StateObject var menuData = MenuViewModel()
    
    @Namespace var animation
    
    @Environment(\.colorScheme) var colorScheme
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        HStack(spacing: 0){
            
            // Drawer with Accessibility
            Drawer(animation: animation)
                .accessibilityLabel("Navigation Menu")
            
            VStack {
                
                // Header with Accessibility
                Header(menuData: menuData)
                    .accessibilityLabel("Chat Header")
                
                ScrollViewReader { proxy in
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack(alignment: .leading) {
                            ForEach(connector.messageLog.filter { $0["role"] != "system" }, id: \.id) { message in
                                // Message View with Accessibility
                                MessageView(message: message)
                                    .accessibilityLabel("Message from \(message["role"] ?? "error"): \(message["content"] ?? "error")")
                            }
                        }
                    }
                    .onChange(of: self.lastMessageID) { id in
                        withAnimation{
                            proxy.scrollTo(id, anchor: .bottom)
                        }
                    }
                }
                
                // Message Input with Accessibility
                MessageInput(message: $message, connector: _connector)
                    .accessibilityLabel("Message Input")
                    .accessibilityHint("Double-tap to type your message")
                
            }
            .padding()
            .background(menuData.showDrawer ? Color("ColorBlack").opacity(0.8) : Color("ColorBlack") )
            .frame(width: UIScreen.main.bounds.width)
            
            
        }
        // Max Frame with Accessibility
        .frame(width: UIScreen.main.bounds.width)
        .offset(x: menuData.showDrawer ? 155 : -155)
        .environmentObject(menuData)
        .preferredColorScheme(menuData.showDrawer ? .light : .dark)
        .accessibility(hidden: menuData.showDrawer)
        .gesture(
            DragGesture()
            .onEnded(onDragEnded)
        )
        
        
    }
    
    private func onDragEnded(drag: DragGesture.Value) {
        let hapticFeedback = UINotificationFeedbackGenerator()
        let dragDistance = drag.translation.width
        
        
        
        hapticFeedback.notificationOccurred(.success)
        
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        if dragDistance > 100 { // Threshold to open drawer
            // Open the drawer if it's not already open
            if !menuData.showDrawer {
                withAnimation {
                    menuData.showDrawer = true
                }
            }
        } else if dragDistance < -100 { // Threshold to close drawer
            // Close the drawer if it's open
            if menuData.showDrawer {
                withAnimation {
                    menuData.showDrawer = false
                }
            }
        }
    }
    
    
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(OpenAIConnector())
    }
}

