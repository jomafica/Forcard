//
//  API_CALL.swift
//  Forcard
//
//  Created by Daniel Pereira on 14/11/2020.
//

import Foundation
import SwiftUI
import Combine

class NetworkManager: ObservableObject {
    @Published var articles = [Art_jbody]()
    
    init(){
        load()
    }
    
    func load() {
        let url = URL(string: "http://127.0.0.1:5000/api/v1/resources/all")!
    
        URLSession.shared.dataTask(with: url) {(data,response,error) in
            do {
                if let d = try? Data(contentsOf: url) {
                    let decodedLists = try JSONDecoder().decode([Art_jbody].self, from: d)
                    DispatchQueue.main.async {
                        self.articles = decodedLists
                        debugPrint(decodedLists)
                    }
                }else {
                    print("No Data")
                }
            } catch DecodingError.dataCorrupted(let context) {
                print(context)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.typeMismatch(let type, let context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
            
        }.resume()
         
    }
}