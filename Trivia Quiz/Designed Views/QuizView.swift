//
//  QuizView.swift
//  Trivia Quiz
//
//  Created by Magdiel Borges on 4/25/22.
//

import SwiftUI

struct QuizView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var quizManager: QuizManager
    @State private var showQuitAlert = false
    var body: some View {
        VStack {
            titleLabel
            Spacer()
            QuestionView()
                //.padding()
//            HStack {
//                quizTypeLabel
//                quizCategoryLabel
//            }
//            quizQuestion
//            quizButtons
            Spacer()
            quizProgress
            Spacer()
        }
        .onAppear {
            quizManager.updateUI()
        }
        .toolbar {
            Button(action: {
                showQuitAlert = true
            }){
                Image(systemName: "xmark")
                    .foregroundColor(.red)
            }
        }
        .alert("Exit Quiz?", isPresented: $showQuitAlert) {
            Button("Exit", role: .destructive) {
                quizManager.resetQuiz()
            }
            Button("Cancel", role: .cancel) {}
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var previewQuizManager: QuizManager {
        let previewQuestion = Results(category: "Preview", type: "Preview", difficulty: "Preview", question: "Preview Question", correct_answer: "Preview", incorrect_answers: ["Preview", "Preview", "Preview"])
        let previewQuiz = QuizData(results: [previewQuestion])
        let quizManager = QuizManager()
        quizManager.quizData = previewQuiz
        return quizManager
    }
    static var previews: some View {
        Group {
            NavigationView {
                QuizView()
                    .environmentObject(previewQuizManager)
            }
            NavigationView {
                QuizView()
                    .preferredColorScheme(.dark)
                    .environmentObject(previewQuizManager)
            }
        }
    }
}
