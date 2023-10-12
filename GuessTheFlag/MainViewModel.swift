//
//  MainViewModel.swift
//  GuessTheFlag
//
//  Created by Yasser Bal on 12/10/2023.
//

import Foundation

class MainViewModel:ObservableObject{
    private static let OPTION_COUNT = 3;
    private let countryService = CountryService.instance
    
    private var correctAnswer:Country?
    @Published var countryChoices:[Country]
    
    @Published var score:Int
    
    init() {
        self.correctAnswer = countryService.getRandomCountry()
        self.countryChoices = countryService.getRandomCountries(amount: Self.OPTION_COUNT)
        self.score = 0
    }
    
    
    
    
}
