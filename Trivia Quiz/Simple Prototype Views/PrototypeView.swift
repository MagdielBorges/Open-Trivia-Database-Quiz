//
//  PrototypeView.swift
//  Trivia Quiz
//
//  Created by Magdiel Borges on 5/2/22.
//

import SwiftUI

struct PrototypeView: View {
    @EnvironmentObject var quizManager: QuizManager
    @State private var showingQuitAlert = false
    var body: some View {
        List {
            Section {
                Text("Question: \(quizManager.getCurrentQuestion())")
            } footer: {
                Text(quizManager.getQuestionCategory())
            }
            Section {
                if quizManager.isBoolean() {
                    PrototypeButton("True")
                    PrototypeButton("False")
                } else {
                    ForEach(quizManager.quizAnswers, id: \.self) { answer in
                        PrototypeButton(answer)
                    }
                }
            } footer: {
                ProgressView(value: quizManager.getProgress())
            }
        }
        .onAppear {
            quizManager.updateUI()
        }
        .navigationTitle("Trivia Quiz")
        .toolbar {
            Button("Restart Quiz") {
                showingQuitAlert = true
            }
        }
        .alert("Restart Quiz?", isPresented: $showingQuitAlert) {
            Button("Restart") {
                withAnimation {
                    quizManager.resetQuiz()
                }
            }
            Button("Cancel", role: .cancel){}
        }
    }
}

struct PrototypeView_Previews: PreviewProvider {
    static var quizManager : QuizManager {
        let previewQuestion = Results(category: "Entertainment: Video Games", type: "multiple_choice", difficulty: "Preview", question: "Is Magdiel the Coolest?", correct_answer: "Yes", incorrect_answers: ["Wrong Answer", "Wrong Answer", "Wrong Answer"])
        let previewQuiz = QuizData(results: [previewQuestion])
        let quizManager = QuizManager()
        quizManager.quizData = previewQuiz
        return quizManager
    }
    static var previews: some View {
        NavigationView {
            PrototypeView()
                .environmentObject(quizManager)
        }
    }
}
