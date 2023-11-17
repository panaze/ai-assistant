//
//  Drawer.swift
//  DrawerTest
//
//  Created by Pablo Navarro Zepeda on 15/11/23.
//

import SwiftUI

struct Drawer: View {
    
    @EnvironmentObject var menuData: MenuViewModel
    
    @State private var searchText = ""
    
    //Animation...
    var animation: Namespace.ID
    
        var body: some View {
      
        VStack{
            VStack{
                
                SearchBar(text: $searchText)
                DrawerFooter()
                
            }.padding(.horizontal, 17)
            
            
            
           
        }
        .frame(width: 310,height: UIScreen.main.bounds.height)
        .background(Color(.black).ignoresSafeArea(.all, edges: .vertical))
    }
}

#Preview {
   ContentView()
    
    
}

struct DrawerCloseButton: View {
    
    @EnvironmentObject var menuData: MenuViewModel
    
    var animation: Namespace.ID
    
    var body: some View{
        Button(action: {
            withAnimation(.easeInOut){
                menuData.showDrawer.toggle()
            }
            
        }, label : {
            
            VStack(spacing: 5){
                
                Capsule()
                    .fill(menuData.showDrawer ? Color.white: Color.clear)
                    .frame(width: 35, height: 3)
                    .rotationEffect(.init(degrees: menuData.showDrawer ? -50 : 0))
                    .offset(x: menuData.showDrawer ? 3 : 0, y: menuData.showDrawer ? 9 : 0)
                
                
                VStack(spacing: 5){
                    
                    Capsule()
                    .fill(menuData.showDrawer ? Color.white: Color.clear)
                    .frame(width: 35, height: 3)
                    
                    Capsule()
                    .fill(menuData.showDrawer ? Color.white: Color.clear)
                    .frame(width: 35, height: 3)
                
                    
                    //Moving This View To Hide..
                    .offset(y: menuData.showDrawer ? -8: 0)
                }
                
                //Rotation
                .rotationEffect(.init(degrees: menuData.showDrawer ? 50 : 0))

            }
            
            
        })
        .scaleEffect(0.8)
        .matchedGeometryEffect(id: "MENU_BUTTON", in: animation)
    }
}



