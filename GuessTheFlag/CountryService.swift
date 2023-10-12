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
            print("got filepath")
            let fileURL = URL(filePath: filePath)
            let data = try Data(contentsOf:fileURL)
            print("got url")
            let result = try JSONDecoder().decode([Country].self, from: data)
            countries = result;
        }catch is CountryServiceError{
            print("Failed to load json")
        }catch
        {
           print("failed to get countries")
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
