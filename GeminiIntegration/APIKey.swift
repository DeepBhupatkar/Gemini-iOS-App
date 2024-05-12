//
//  APIKey.swift
//  GeminiIntegration
//
//  Created by DEEP BHUPATKAR on 12/05/24.
//

import Foundation

enum APIKey{
    // for fetching API key from GenerativeAI-Info property file
    
    static var `default` : String{
        //checking for property file called GenerativeAI-Info.plist
        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist")
        else {
            fatalError("Couldn't find the file 'GenerativeAI-Info.plist")
        }
        //checking weather the APIKEY is avaliable in GenerativeAI-Info.plist
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String
        else {
            fatalError("Couldn't find API_KEY in 'GenerativeAI-Info.plist")
        }
        //checking if it's the value starting with _ means it not API key so check the step for it 
        if value.starts(with: "_")
        {
            fatalError("Follow the instruction at https://ai.google.dev/tutorials/setup to get API key.")
        }
        return value
    }
}
