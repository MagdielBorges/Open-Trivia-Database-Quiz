//
//  Trivia_QuizApp.swift
//  Trivia Quiz
//
//  Created by Magdiel Borges on 4/24/22.
//

import SwiftUI

@main
struct Trivia_QuizApp: App {
    @StateObject var quizManager = QuizManager()
    var body: some Scene {
        WindowGroup {
            ControllerView()
                .environmentObject(quizManager)
        }
    }
}
