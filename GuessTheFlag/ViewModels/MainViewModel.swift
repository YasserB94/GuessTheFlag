//
//  MainViewModel.swift
//  GuessTheFlag
//
//  Created by Yasser Bal on 12/10/2023.
//

import Foundation

class MainViewModel:ObservableObject{
    private static let HIGH_SCORE_USER_DEFAULTS_KEY = "high-score"
    private static let CHOICE_COUNT = 3;
    private static let STARTING_LIVES = 3;
    private let countryService = CountryService.instance
    private let hapticsService = HapticService.instance
    
    @Published var correctAnswer:Country
    @Published var countryChoices:[Country]
    @Published var gameOver:Bool
    @Published var roundEnded:Bool
    @Published var lives:Int
    
    @Published var highscore:Int
    @Published var score:Int
    
    init() {
        let choices = countryService.getRandomCountries(amount: Self.CHOICE_COUNT)
        guard let answer = choices.randomElement() else{
            fatalError("Country data returned nil - Data corrupt")
        }
        
        self.correctAnswer = answer
        self.countryChoices = choices
        
        self.gameOver = false
        self.roundEnded = false
        self.score = 0
        self.lives = Self.STARTING_LIVES
        self.highscore = UserDefaults.standard.integer(forKey: Self.HIGH_SCORE_USER_DEFAULTS_KEY);
    }
    
    func handleAnswerPicked(answer:Country)->Void{
        guard !self.roundEnded else {return}
        self.roundEnded = true
        
        if(answer != self.correctAnswer){
            self.hapticsService.notify(type: .warning)
            self.lives -= 1
            
        }else{
            self.hapticsService.notify(type: .success)
            score += 1
        }
        
        if(score > self.highscore){
            self.highscore = score;
            UserDefaults.standard.set(self.highscore, forKey: Self.HIGH_SCORE_USER_DEFAULTS_KEY)
        }
        
        guard self.lives > 0 else{
            self.gameOver = true;
            self.hapticsService.notify(type: .error)
            return
        }
        
        self.newRound()
        
    }
        
    func newRound(){
        self.refreshChoices()
        self.correctAnswer = self.getRandomAnswer()
        self.roundEnded = false;
    }
    
    func newGame(){
        self.gameOver = false
        self.roundEnded = false
        self.score = 0
        self.lives = Self.STARTING_LIVES
        
    }
    
    private func refreshChoices()->Void{
        self.countryChoices = self.countryService.getRandomCountries(amount: Self.CHOICE_COUNT)
    }
    private func getRandomAnswer()->Country{
        guard let answer = self.countryChoices.randomElement() else{
            fatalError("Country data returned nil - Data corrupt")
        }
        return answer;
    }
    
    
}
