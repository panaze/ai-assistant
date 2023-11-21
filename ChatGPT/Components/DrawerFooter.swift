//
//  DrawerFooter.swift
//  ChatGPT
//
//  Created by Pablo Navarro Zepeda on 16/11/23.
//

import SwiftUI

struct DrawerFooter: View {
    var body: some View {
        
        HStack {
    
            HStack(spacing: 13){
                Image("Pablo-Icon2").resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .cornerRadius(9)
                    
                Text("Pablo Navarro")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            Image(systemName: "ellipsis").foregroundColor(.white)
        }
        .padding(.vertical)
       
    }
}

#Preview {
    Group{
        DrawerFooter().foregroundColor(.blue)
    }.background(Color(.black))
}
