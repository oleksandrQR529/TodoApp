//
//  NetworkService.swift
//  todo
//
//  Created by Sasha on 28.10.2020.
//

import Foundation

typealias OnApiSuccess = (Todos) -> Void
typealias OnApiError = (String) -> Void

class NetworkService {
    static let instance = NetworkService()
    
    let URL_BASE = "http://localhost:3003"
    let URL_ADD_TODO = "/add"
    
    let session = URLSession(configuration: .default)
    
    func getTodos(onSuccess: @escaping OnApiSuccess, onError: @escaping OnApiError) {
        guard let url = URL(string: "\(URL_BASE)") else { return }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    onError(error.localizedDescription)
                    return
                }
                
                guard let data = data, let response = response as? HTTPURLResponse else { return }
                
                do{
                    if response.statusCode == 200 {
                        let items = try JSONDecoder().decode(Todos.self, from: data)
                        onSuccess(items)
                    }else {
                        let err = try JSONDecoder().decode(APIError.self, from: data)
                        onError(err.message)
                    }
                }catch let jsonError{
                    onError(jsonError.localizedDescription)
                }
            }
        }
        task.resume()
    }
    
    func addTodo(todo: Todo) {
        
    }
}
