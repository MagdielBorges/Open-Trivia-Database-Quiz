//
//  Quiz.swift
//  Trivia Quiz
//
//  Created by Magdiel Borges on 4/24/22.
//

import Foundation

struct QuizData: Codable {
    let results: [Results]
}

struct Results: Codable, Hashable {
    let category: String
    let type: String
    let difficulty: String
    let question: String
    let correct_answer: String
    let incorrect_answers: [String]
}

struct CategoryData: Codable {
    let trivia_categories: [QuizCategory]
}

struct QuizCategory: Codable, Identifiable {
    let id: Int
    let name: String
}


