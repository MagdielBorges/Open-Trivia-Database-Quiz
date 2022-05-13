//
//  QuizMenuView.swift
//  Trivia Quiz
//
//  Created by Magdiel Borges on 4/25/22.
//

import SwiftUI

struct QuizMenuView: View {
    @SceneStorage("amount") var amount = 10
    @SceneStorage("type") var type = ""
    @SceneStorage("category") var category = ""
    @SceneStorage("difficulty") var difficulty = ""
    @EnvironmentObject var quizManager: QuizManager
    var body: some View {
        Form {
            Section("Quiz Settings") {
                difficultyPicker
                categoryPicker
                questionNumberPicker
                quizTypePicker
            }
            startQuizLink
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Trivia Quiz")
        .task {
            quizManager.getCategories()
        }
        .onAppear {
            quizManager.amount = amount
            quizManager.type = type
            quizManager.category = category
            quizManager.difficulty = difficulty
        }
        .onChange(of: quizManager.amount) { newValue in
            amount = newValue
        }
        .onChange(of: quizManager.type) { newValue in
            type = newValue
        }
        .onChange(of: quizManager.category) { newValue in
            category = newValue
        }
        .onChange(of: quizManager.difficulty) { newValue in
            difficulty = newValue
        }
    }
    
    var difficultyPicker: some View {
        Picker(selection: $quizManager.difficulty) {
            Text("Any").tag("")
            Text("Easy").tag("easy")
            Text("Medium").tag("medium")
            Text("Hard").tag("hard")
        } label: {
            Text("Select a difficulty")
        }
    }
    
    var categoryPicker: some View {
        Picker(selection: $quizManager.category) {
            Text("Any").tag("")
            ForEach(quizManager.categories) { category in
                Text(category.name).tag(String(category.id))
            }
        } label: {
            Text("Select a Category")
        }
    }
    
    var questionNumberPicker: some View {
        Picker(selection: $quizManager.amount) {
            ForEach(1..<51) { i in
                Text(String(i)).tag(i)
            }
        } label: {
            Text("Number of Questions")
        }
    }
    
    var quizTypePicker: some View {
        Picker(selection: $quizManager.type) {
            Text("Any").tag("")
            Text("True/False").tag("boolean")
            Text("Multiple Choice").tag("multiple")
        } label: {
            Text("Quiz Type")
        }
    }
    
    var startQuizLink: some View {
        Button("Start Quiz") {
            quizManager.mode = .loading
            Task {
                await quizManager.getQuiz()
            }
        }
    }
}


struct QuizMenuView_Previews: PreviewProvider {
    static var quizManager = QuizManager()
    static var previews: some View {
        Group {
            NavigationView {
                QuizMenuView()
                    .environmentObject(quizManager)
            }
            NavigationView {
                QuizMenuView()
                    .environmentObject(quizManager)
            }
            .preferredColorScheme(.dark)
        }
    }
}
