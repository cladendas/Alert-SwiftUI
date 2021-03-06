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
//            ContentViewPickerNavigation()
//            ContentViewAlert()
//            ContentViewActionSheet()
//            ContentViewToggle()
//            ContentViewPicker()
//            ContentViewSlider()
//            ContentViewSegment()
//            ContentViewActivity()
            ContentViewNavigationView()
        }
    }
}

struct ContentViewPickerNavigation: View {
    @State var section = 0
    @State var isOnToggle = false
    
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
                
                Toggle(isOn: $isOnToggle) {
                    Text("Авиарежим").foregroundColor(isOnToggle ? Color.orange : Color.gray)
                }
            }
            .navigationBarTitle("Настройки")
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
            }.padding()
            
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
            .frame(width: 200, height: 50)
        }
    }
}

struct ContentViewSlider: View {
    @State private var progressTop: Float = 0
    @State private var progressBottom: Float = 0
    ///Плеер
    @ObservedObject var viewModel = PlayerViewModel()
    
    var body: some View {
        
        VStack {
            
            Slider(value: $progressTop).padding()
            
            Text("Время - \(progressBottom)")
            
            Slider(value: Binding(get: {
                self.progressBottom
            }, set: {
                self.progressBottom = $0
                self.viewModel.setTime(value: $0)
                
                //TODO: сделать изменение ползунка одновременно с музыкой
            }),
                   in: 0...viewModel.maxDuration,
                   step: 0.01).padding()
            
            HStack {
                Button {
                    self.viewModel.play()
                } label: {
                    Text("Play").foregroundColor(Color.white)
                }
                .frame(width: 100, height: 50)
                .background(Color.orange)
                .cornerRadius(10)

                Button {
                    self.viewModel.stop()
                } label: {
                    Text("Stop").foregroundColor(Color.white)
                }
                .frame(width: 100, height: 50)
                .background(Color.orange)
                .cornerRadius(10)
            }
        }
        
    }
}

struct ContentViewSegment: View {
    @State var segmentIndex = 0
    @State var offSetX = 0
    
    var company = ["Nike", "Puma", "Reebok"]
    var sneakers = ["nike", "puma", "reebok"]
    
    var body: some View {
        
        VStack {
            Text("Кроссовик - \(company[segmentIndex])")
        
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray)
                    .padding()
                    .offset(x: CGFloat(offSetX))
                
                Image(sneakers[segmentIndex])
                    .resizable()
                    .frame(width: 300, height: 300)
                    .offset(x: CGFloat(offSetX))
            }.animation(.spring(response: 0.6,
                                dampingFraction: 0.5,
                                blendDuration: 0.4),
                        value: segmentIndex)
            
            Picker(selection: Binding(get: {
                self.segmentIndex
            }, set: { newValue in
                self.segmentIndex = newValue
                self.offSetX = -500
                self.moveBack()
            })) {
                ForEach(0..<company.count) {
                    Text(self.company[$0]).tag($0)
                }
            } label: {
                Text("")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
        }
    }
    
    private func moveBack() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.offSetX = 0
        }
    }
}

struct ContentViewActivity: View {
    @State private var isSharedPresented = false
    let customActivity = ActivityViewCustomActivityView(title: "Телеграмм",
                                                        imageName: "telegram") {
        print("отправка в телеграмм")
    }
    
    var body: some View {
        Button ("press") {
            self.isSharedPresented = true
        }.sheet(isPresented: $isSharedPresented) {
            ActivityView(activityItems: ["message test"],
                         applicationActivities: [self.customActivity])
        }
    }
}

struct DetailView: View {
    ///с помощью @Environment(\.presentationMode) можно передать в переменную стэк
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var userBuy: UserBuy
    
    var text: String
    
    var body: some View {
        
        VStack(spacing: 30) {
            
            Text("Купить \(text) \(userBuy.cups) шт")
            
            .navigationBarItems(
                leading:
                    Button("в меню") {
                //вернёт обратно к родителю
                self.presentation.wrappedValue.dismiss()
            },
                trailing:
                    HStack {
                        Button("-") {
                            guard userBuy.cups > 0 else { return }
                            userBuy.cups -= 1
                        }
                        
                        Button("+") {
                            userBuy.cups += 1
                        }
                    }
            )
        }
        .navigationBarBackButtonHidden(true) //убирает в навигации кнопку НАЗАД
        //срабатывает, когда вью появляется
        .onAppear {
            self.userBuy.cups = 0
        }
    }
}

struct ContentViewNavigationView: View {
    ///@ObservedObject подходит для хранения состояния более сложных сущностей. Для простых сущностей используется @State
    @ObservedObject var userBuy = UserBuy()
    
    @State var selector: String?
    
    @State var isShow = false
    
    let coffee = "Кофе"
    let tea = "Чай"
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 30) {
                
                Text("Вы выбрали \(userBuy.cups) шт")
                
                Text("Что желаете?")
                
                NavigationLink(coffee) {
                    //типа передаются данные в новое вью
                    DetailView(text: coffee)
                }.navigationTitle("Меню")
                
                NavigationLink(tea) {
                    DetailView(text: tea)
                }.navigationTitle("Меню")
                
                //для демонстрации перехода по тегу
                NavigationLink(tag: "act1",
                               selection: $selector,
                               destination: { DetailView(text: coffee) },
                               label: { EmptyView() })
                
                //для демонстрации перехода по тегу
                NavigationLink(destination: DetailView(text: tea),
                               tag: "act2",
                               selection: $selector,
                               label: { EmptyView() })
                
                //для демонстрации перехода по флагу
                NavigationLink(isActive: $isShow,
                               destination: { DetailView(text: coffee) },
                               label: { EmptyView() })
                
                //типа по нажатию кнопки отправляетя запрос и через 3 секунды приходи ответ с act1
                //как только придёт ответ, отработает один из NavigationLink, которые работают по тегу
                Button("GO_1") {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.selector = "act1"
                    }
                }
                
                Button("GO_2") {
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.selector = "act1"
                    }
                }
            }
        }
        .environmentObject(userBuy) //environmentObject() позволяет таскать с собой указанный объект
    }
}
