//
//  Countries.swift
//  GuessTheFlag
//
//  Created by Yasser Bal on 12/10/2023.
//

import Foundation

class CountryService{
    enum CountryServiceError:Error{
        case jsonFileNotFound
    }
    static let instance:CountryService = CountryService();
    
    private var countries:[Country] = []
    
    private init(){
        do{
            guard let filePath = Bundle.main.path(forResource: "Flags", ofType: "json")else{
                throw CountryServiceError.jsonFileNotFound
            }
            let fileURL = URL(filePath: filePath)
            let data = try Data(contentsOf:fileURL)
            let result = try JSONDecoder().decode([Country].self, from: data)
            countries = result;
        }catch is CountryServiceError{
            fatalError("Failed to load flags JSON")
        }catch
        {
           print("Failed to retrieve countries from JSON")
        }
    
    }
    
    func getRandomCountry()->Country?{
        return countries.randomElement()
    }
    
    func getRandomCountries(amount:Int)->[Country]{
        var countries:[Country] = [];
        var i = amount
        while(i>0){
            if let country = self.getRandomCountry(){
                countries.append(country)
            }
            i-=1
        }
        
        return countries;
    }
    
    func getAllCountries() -> [Country] {
        return countries
    }
    
}
