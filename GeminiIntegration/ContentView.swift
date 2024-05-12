//
//  ContentView.swift
//  GeminiIntegration
//
//  Created by DEEP BHUPATKAR on 12/05/24.
//

import SwiftUI
import GoogleGenerativeAI

struct ContentView: View {
    
    //created the instace of generative model class and assing to varibale with name of model we want to use and API key
    // for text to text request response we use gemini-pro
    let model = GenerativeModel (name: "gemini-pro", apiKey: APIKey.default)
    // done with initialization
    
    
    // initializing the State Varibles
    @State var userPrompt = ""
    @State var response: LocalizedStringKey = "How can I help you today!?"
    @State var isLoading = false
    
    var body: some View {
        VStack {
            Text("Welcome to Gemini AI")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.indigo)
                .padding(.top,40)
            ZStack{
                ScrollView{
                    Text(response)
                        .font(.title)
                }
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint:.indigo))
                        .scaleEffect(3)
                }
            }
            TextField("Ask anything...",text: $userPrompt , axis: .vertical)
                .lineLimit(5)
                .font(.title2)
                .padding()
                .background(Color.blue.opacity(0.2), in: Capsule())
                .disableAutocorrection(true)
                .onSubmit {
                    generateResponse()
                }
            
        }
        .padding()
    }
    
    func generateResponse(){
        isLoading = true
        response = ""
    // for performing asynchoronous task
        Task{
            do{
                let result = try await model.generateContent(userPrompt)
                isLoading = false
                response = LocalizedStringKey(result.text ?? "No Respone Found")
                userPrompt = ""
            }
            catch{
                response = "Something went wrong\n\(error.localizedDescription)"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        ContentView()
    }
   
}
