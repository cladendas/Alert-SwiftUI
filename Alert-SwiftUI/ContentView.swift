//
//  ContentView.swift
//  Alert-SwiftUI
//
//  Created by cladendas on 07.12.2021.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
     
    var body: some View {
        VStack {
            ContentViewPickerNavigation()
            ContentViewAlert()
            ContentViewActionSheet()
            ContentViewToggle()
            ContentViewPicker()
        }
    }
}

struct ContentViewAlert: View {

    ///@State хранит состояние
    @State var isError = false
    
    
    var body: some View {
        showAlert().padding()
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

struct ContentViewActionSheet: View {
    
    @State var isError = false
    
    var body: some View {
        showActionSheet()
    }
    
    ///ActionSheet с двумя кнопками
    fileprivate func showActionSheet() -> some View {
        return Button (action: {
            self.isError = true
        }, label: {
            Text("ActionSheet")
        }).actionSheet(isPresented: $isError) {
            ActionSheet(title: Text("Загрузка"),
                        message: Text("Вы хотите загрузить?"),
                        buttons: [.destructive(Text("Загрузить"), action: {
                                    print("пошла загрузка")}),
                                    .cancel()])
        }
    }
}
struct ContentViewToggle: View {
        
    @State var isOnToggle = false
        
    var body: some View {
        ///ZStack накладывает вьюхи друг на друга
        ZStack {
            
            HStack {
                VStack {
                    Text("Кошелёк").padding()
                    Text("Профиль").padding()
                }
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.yellow)
                .frame(width: 400, height: 100)
                .offset(x: isOnToggle ? 200 : 0).padding()
        }.animation(.spring(response: 0.5,
                            dampingFraction: 0.7,
                            blendDuration: 0.4),
                    value: isOnToggle)
        Toggle(isOn: $isOnToggle,
               label: { Text("Показать настройки")}).padding()
    }
}

struct ContentViewPicker: View {
    
    @State var section = 0
    var settingsTime = ["5 min", "10 min", "15 min", "20 min",
                        "25 min", "30 min", "35 min",
                        "40 min", "45 min", "50 min",
                        "55 min", "60 min", "65 min"]
    
    var body: some View {
        
        HStack {
            Text("Время - \(settingsTime[section])").padding()
            
            
            Picker(selection: $section,
                   content: {
                ForEach(0..<settingsTime.count) {
                    Text(self.settingsTime[$0])
                }
            },
                   label: {Text("")})
                .pickerStyle(.wheel)
                .frame(width: 200, height: 200)
        }
        
    }
}

struct ContentViewPickerNavigation: View {
    @State var section = 0
    var settingsTime = ["5 min", "10 min", "15 min", "20 min",
                        "25 min", "30 min", "35 min",
                        "40 min", "45 min", "50 min",
                        "55 min", "60 min", "65 min"]
    
    var body: some View {
        NavigationView {
            Form {
                Picker(selection: $section,
                       content: {
                    ForEach(0..<settingsTime.count) {
                        Text(self.settingsTime[$0])
                    }
                },
                       label: {Text("Время")})
            }.navigationBarTitle("Настройки")
        }
    }
}
