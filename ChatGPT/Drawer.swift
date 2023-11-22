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
            VStack(alignment: .leading){
                
                // Search Bar with Accessibility
                SearchBar(text: $searchText)
                    .accessibilityLabel("Search")
                    .accessibilityHint("Double-tap to enter search text")
                
                ScrollView{
                    VStack(alignment: .leading, spacing: 20){
                        // Accessibility for each section
                        Group {
                            DrawerItem(iconName: "ChatGPT-Icon", title: "ChatGPT")
                            DrawerItem(iconName: "Dalle", title: "DALL-E")
                            DrawerItem(iconName: "dataAnalysis", title: "Data Analysis")
                        }

                        Divider().background(Color.gray)
                        
                        // Accessibility for articles
                        Group() {
                            
                            Text("Today")
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                                .accessibility(addTraits: .isHeader)
                            ArticleItem(title: "Swift 5: What's New")
                            ArticleItem(title: "Beginner's Guide to iOS 17")
                            ArticleItem(title: "First Steps with SwiftUI")
                            ArticleItem(title: "SwiftUI vs UIKit Comparison")
                            ArticleItem(title: "Mastering iOS Auto Layout")
                            ArticleItem(title: "Exploring Swift's Functional Programming Features")


                        }
                        .accessibilityElement(children: .combine)
                        
                        Divider().background(Color.gray)
                        
                        Group() {
                            
                            Text("Yesterday")
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                                .accessibility(addTraits: .isHeader)
                            ArticleItem(title: "Swift Playgrounds: Learning Swift in a Fun Way")
                            ArticleItem(title: "Using Swift Package Manager")
                            ArticleItem(title: "SwiftUI on macOS")
                        }
                        .accessibilityElement(children: .combine)
                        
                        Divider().background(Color.gray)
                        
                        Group() {
                            
                            Text("Yesterday")
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                                .accessibility(addTraits: .isHeader)
                            ArticleItem(title: "SwiftUI Animation Techniques: Creating Dynamic UIs")
                            ArticleItem(title: "Debugging in Swift")
                            ArticleItem(title: "Apple's App Store: Success Strategies")
                        }
                        .accessibilityElement(children: .combine)
                        
                        Divider().background(Color.gray)
                        
                        Group() {
                            
                            Text("Yesterday")
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                                .accessibility(addTraits: .isHeader)
                            ArticleItem(title: "The Impact of Apple's Environmental Policies")
                            ArticleItem(title: "Apple Music API: Creating Music Apps")
                        }
                        .accessibilityElement(children: .combine)
                        
                        Divider().background(Color.gray)
                        
                        Group() {
                            
                            Text("Yesterday")
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                                .accessibility(addTraits: .isHeader)
                            ArticleItem(title: "Leveraging Apple's Core ML for AI")
                        }
                        .accessibilityElement(children: .combine)
                        
                        Divider().background(Color.gray)
                        
                        Group() {
                            
                            Text("Yesterday")
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                                .accessibility(addTraits: .isHeader)
                            ArticleItem(title: "Privacy Features in Apple's iOS")
                            ArticleItem(title: "Using Apple's HealthKit for Fitness Apps")
                        }
                        .accessibilityElement(children: .combine)
                        
                    }.padding(.top, 15)
                }
                
                DrawerFooter() // Ensure DrawerFooter is also accessible if needed
                
            }
            .padding(.horizontal, 17)
            .padding(.top, 60)
            .padding(.bottom, 60)
        }
        .frame(width: 310,height: UIScreen.main.bounds.height)
        .background(Color(.black).ignoresSafeArea(.all, edges: .vertical))
        .preferredColorScheme(.light)
    }
}

// Helper view for Drawer Items
struct DrawerItem: View {
    var iconName: String
    var title: String
    
    var body: some View {
        HStack(spacing: 15){
            Image(iconName).resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .cornerRadius(60)
                .accessibilityLabel("Icon representing \(title)")
            
            Text(title)
                .fontWeight(.medium)
                .foregroundColor(.white)
                .accessibilityLabel("\(title)")
        }
    }
}

// Helper view for Articles
struct ArticleItem: View {
    var title: String
    
    var body: some View {
        Text(title)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .lineLimit(1)
            .truncationMode(.tail)
            .padding(.top, 5)
            .accessibilityLabel(title)
    }
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
        .accessibilityLabel(menuData.showDrawer ? "Close Drawer" : "Open Drawer")
        .accessibilityHint("Double-tap to toggle drawer")
    }
}

#Preview {
    ContentView().environmentObject(OpenAIConnector())
}

