//
//  MenuModel.swift
//  DrawerTest
//
//  Created by Pablo Navarro Zepeda on 15/11/23.
//

import SwiftUI

// Menu Data

class MenuViewModel: ObservableObject{
    
    //Default
    @Published var selectedMenu = "Catalogue"
    //Show...
    @Published var showDrawer = false
}
