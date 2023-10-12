//
//  MainView.swift
//  GuessTheFlag
//
//  Created by Yasser Bal on 12/10/2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var vm = MainViewModel();
    
    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [.red,.blue]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
            HStack(spacing:20){
                ForEach(vm.countryChoices) { country in
                    AsyncImage(url: URL(string:country.image))
                    { image in
                        image.resizable()
                            .frame(width:64,height:64)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            .padding()
                .background()
                .cornerRadius(8)
                .backgroundStyle(.ultraThinMaterial)
                .shadow(color: Color(.black.withAlphaComponent(0.1)), radius: 10, x: 0, y: 0)
        }
        

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
