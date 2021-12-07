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
            showAlert().padding()
        }
    }
    
    ///Алерт с двумя кнопками
    fileprivate func showAlert() -> some View {
        return Button (action: {
            self.isError = true
        }, label: {
            Text("Alert")
        }).alert(isPresented: $isError, content: {
            Alert(title: Text("Загрузка"),
                  message: Text("Вы уверены?"),
                  primaryButton:
                        .destructive(Text("Да"),
                                     action: {print("test")}),
                  secondaryButton: .cancel())
        })
    }
}

struct ContentViewQ: View {
    
    @State var isError = false
    
    var body: some View {
        Text("Hello, world!")
            .padding()
        
        showActionSheet()
    }
    
    ///ActionSheet с двумя кнопками
    fileprivate func showActionSheet() -> some View {
        return Button (action: {
            self.isError = true
        }, label: {
            Text("ActionSheet")
        }).actionSheet(isPresented: $isError) {
            ActionSheet(title: Text("Test"))
        }
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
