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
            if(vm.gameOver){
                gameOverView
            }else{
                gameView
            }
            
        }
    }
    private var gameView:some View{
        VStack{
            stats
            Spacer()
            instructions
            Spacer()
            choices
            Spacer()
            Spacer()
        }
    }
    
    private var gameOverView:some View {
        VStack{
            stats
            Spacer()
            Button{
                vm.newGame()
            }label: {
                Text("NEW GAME")
                    .font(.system(size:36,weight: .bold,design: .monospaced))
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .shadow(radius: 10,x:0,y:20)
                    .frame(maxWidth: .infinity)
            }
            Spacer()
        }
    }

    private var stats:some View{
        VStack{
            Text("HIGH SCORE \(vm.highscore)").font(.system(size:14,weight: .bold,design: .monospaced))
                .shadow(color:.white.opacity(0.5),radius: 10,x:0,y:0)
                .foregroundColor(.white)
            Divider()
                .frame(maxWidth: 200)
            HStack{
                createStatItem(content: Text("LIVES: \(vm.lives)"))
                Divider()
                    .frame(maxHeight: 16)
                createStatItem(content: Text("SCORE: \(vm.score)"))
            }
        }
        .padding(.top)
    }
    
    private func createStatItem(content:Text)->some View{
        content
            .font(.system(size: 16, weight: .semibold, design: .monospaced))
            .foregroundColor(.white)
            .shadow(radius: 10)
        .padding(10)
        .background()
        .cornerRadius(8)
        .backgroundStyle(.ultraThinMaterial)
        .shadow(color: Color(.black.withAlphaComponent(0.1)), radius: 10, x: 0, y: 0)
    }
    
    private var instructions:some View{
        VStack{
            Text("TAP THE FLAG OF")
                .font(.system(size:14,weight: .light,design: .monospaced))
            Text("\(vm.correctAnswer.name.uppercased())")
                .font(.system(size:36,weight: .bold,design: .monospaced))
        }
        .multilineTextAlignment(.center)
        .foregroundColor(.white)
        .shadow(radius: 10,x:0,y:20)
        .frame(maxWidth: .infinity)
    }
    private var choices:some View{
        HStack(spacing:20){
            ForEach(vm.countryChoices) { country in
                Button{
                    vm.handleAnswerPicked(answer: country)

                }label:{
                        AsyncImage(url: URL(string:country.image))
                        { image in
                            image.resizable()
                                .frame(width:64,height:64)
                        } placeholder: {
                            ProgressView()
                                .onTapGesture {
                                    vm.newRound()
                                }
                        }
                }
            }
        }
    }
}

extension MainView{
    
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
