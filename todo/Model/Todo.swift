//
//  Todo.swift
//  todo
//
//  Created by Sasha on 28.10.2020.
//

import Foundation

struct Todos: Codable {
    let items: Array<Todo>
}

struct Todo: Codable {
    let item: String
    let priority: Int
}
