//
//  ContentView.swift
//  Alert-SwiftUI
//
//  Created by cladendas on 07.12.2021.
//

import SwiftUI

struct ContentView: View {
    
    ///@State хранит состояние
    @State var isError = false
    
    var body: some View {
        
        VStack {
            Text("Hello, world!")
                .padding()
            Text("Hello, world!")
                .padding()
        }
        Button (action: {
            self.isError = true
            }, label: {
                Text("Вход")
            }).alert(isPresented: $isError, content: {
                Alert(title: Text("TEST1"))
                })


    }
}

struct ContentViewQ: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        HStack {
            
            ContentView()
            ContentViewQ()
        }
        
    }
}
