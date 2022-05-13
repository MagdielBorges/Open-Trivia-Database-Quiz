//
//  QuizManager.swift
//  Trivia Quiz
//
//  Created by Magdiel Borges on 4/24/22.
//

import Foundation
import SwiftUI

class QuizManager: ObservableObject {
    @Published var categoryData : CategoryData?
    @Published  var quizData: QuizData?
    
    @Published var amount = 10
    @Published var type = ""
    @Published var category = ""
    @Published var difficulty = ""
    
    @Published var progress = 0
    @Published var score = 0
    @Published var playerAnswer = ""
    @Published var quizAnswers: [String] = []
    @Published var buttonSelected = false
    @Published var playerAnswers: [String] = []
    enum Mode {
        case menu, loading, quiz, results
    }
    @Published var mode: Mode = .menu
    var categories: [QuizCategory]{
        categoryData?.trivia_categories ?? []
    }
    
    func getQuiz() async {
        var quizURL = "https://opentdb.com/api.php?"
        quizURL += "amount=\(amount)"
        if !category.isEmpty {
            quizURL += "&category=\(category)"
            print(quizURL)
        }
        if !difficulty.isEmpty {
            quizURL += "&difficulty=\(difficulty)"
        }
        
        if !type.isEmpty {
            quizURL += "&type=\(type)"
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: quizURL)!)
            let decodedResponse = try? JSONDecoder().decode(QuizData.self, from: data)
            if let quizQuestion = decodedResponse {
                DispatchQueue.main.async {
                    self.quizData = quizQuestion
                    withAnimation {
                        self.mode = .quiz
                    }
                    for i in self.quizData!.results {
                        print("Question: \(i.question)")
                        print("Answer: \(i.correct_answer)")
                    }
                }
            }
        } catch {
            print(error)
        }
       
    }
    
    func updateUI() {
        let currentQuestion = quizData!.results[progress]
        var answersArray = currentQuestion.incorrect_answers
        answersArray.append(currentQuestion.correct_answer)
        quizAnswers = answersArray.shuffled()
    }
    
    func isBoolean() -> Bool {
        return quizData!.results[progress].type == "boolean"
    }
    
    func getPercentage() -> Int {
        return Int((Double(score) / Double(amount)) * 100)
    }
    
    func getQuestionType() -> String {
        if quizData!.results[progress].type == "multiple" {
            return "Multiple Choice"
        } else {
            return "True or False"
        }
    }
    
    func getPercentageColor() -> Color {
        if getPercentage() <= 50 {
            return .red
        } else if getPercentage() < 70 {
            return .yellow
        } else {
            return .green
        }
    }
    
    func getCorrectAnswer() -> String {
        quizData!.results[progress].correct_answer
    }
    
    func getQuestionCategory() -> String {
        quizData!.results[progress].category
    }
    
    func getCurrentQuestion() -> String {
        let question = quizData!.results[progress].question
        return cleanString(question)
    }
    
    func getProgress() -> Float {
        Float(progress + 1) / Float(quizData!.results.count)
    }
    
    func pressedButton(_ buttonAnswer: String) {
        if !buttonSelected {
            buttonSelected = true
            playerAnswer = buttonAnswer
            playerAnswers.append(buttonAnswer)
            if buttonAnswer == getCorrectAnswer() {
                score += 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                if self.progress + 1 < self.amount {
                    self.progress += 1
                    self.buttonSelected = false
                    self.playerAnswer = ""
                    self.updateUI()
                } else {
                    withAnimation {
                        self.mode = .results
                    }
                }
            }
        }
    }

    func resetQuiz() {
        mode = .menu
        progress = 0
        score = 0
        playerAnswer = ""
        buttonSelected = false
    }
    
    func getCategories() {
        Task {
            let url = "https://opentdb.com/api_category.php"
            let (data, _) = try await URLSession.shared.data(from: URL(string: url)!)
            let decodedResponse = try? JSONDecoder().decode(CategoryData.self, from: data)
            if let categories = decodedResponse {
                DispatchQueue.main.async {
                    self.categoryData = categories
                }
            }
        }
    }
}


