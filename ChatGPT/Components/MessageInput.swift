//
//  MessageInput.swift
//  ChatGPT
//
//  Created by Pablo Navarro Zepeda on 14/11/23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var placeholder: Text
    var cornerRadius: CGFloat
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .foregroundColor(.gray) // Gray color for the placeholder
                    .padding(EdgeInsets(top: 12, leading: 15, bottom: 12, trailing: 5))
                    .fontWeight(.semibold)
            }
            TextField("", text: $text)
                .foregroundColor(.white) // Color of the input text
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 5))
                .cornerRadius(cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.gray, lineWidth: 1)
                )
            
        }
    }
}

struct MessageInput: View {
    @Binding var message: String
    @EnvironmentObject var connector: OpenAIConnector
    
    @State var isWaitingForResponse: Bool = false

    var body: some View {
        HStack {
            Button(action: {
                print("Button clicked")
            }
            ){
                ZStack {
                    Image(systemName: "circle.fill")
                        .foregroundColor(Color("ColorGrey")) // Color of the circle

                    Image(systemName: "plus")
                        .foregroundColor(.gray) // Color of the plus
                        .font(.system(size: 20, weight: .semibold)) // Adjust the size to fit inside the circle
                }
                .font(.largeTitle)
                    
            }
            CustomTextField(text: $message, placeholder: Text("Message"), cornerRadius: 30)
            
            Button(action: {
                isWaitingForResponse = true
                Task {
                    await connector.sendToAssistant()
                    isWaitingForResponse = false
                }
                connector.logMessage(message, messageUserType: .user)
                message = ""
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
            ) {
                if isWaitingForResponse {
                    Image(systemName: "square.circle")
                        .foregroundColor(.white)
                        .padding(.horizontal, 5)
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                } else {
                    Image(systemName: "arrow.up.circle.fill")
                        .foregroundColor(.white)
                        .padding(.horizontal, 5)
                        .font(.system(size: 30))
                        .fontWeight(.semibold)
                }
            }
        }
    }
}

// Assuming you have a ContentView to display the preview
struct MessageInput_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(OpenAIConnector())
    }
}
