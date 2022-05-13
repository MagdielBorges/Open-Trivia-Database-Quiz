//
//  PrototypeQuizResults.swift
//  Trivia Quiz
//
//  Created by Magdiel Borges on 5/2/22.
//

import SwiftUI

struct PrototypeQuizResults: View {
    @EnvironmentObject var quizManager: QuizManager
    @State private var showingQuitAlert = false
    var body: some View {
        Form {
            ForEach(quizManager.quizData!.results, id: \.self) { question in
                let playerAnswer = quizManager.playerAnswers[quizManager.quizData!.results.firstIndex(of: question)!]
                Section("Question: \(quizManager.quizData!.results.firstIndex(of: question)! + 1)"){
                    Text("\(cleanString(question.question))")
                        .bold()
                    Text("Correct Answer: \(cleanString(question.correct_answer))")
                        .italic()
                    Text("Your Answer: \(cleanString(playerAnswer))")
                        .foregroundColor(playerAnswer == question.correct_answer ? .green : .red)
                }
            }
            Section {
                VStack(alignment: .leading) {
                    Text("Correct Answers: \(quizManager.score)/\(quizManager.amount)")
                        .font(.subheadline)
                    HStack {
                        Text("Final Score: ")
                            .font(.subheadline)
                        Text("\(quizManager.getPercentage())%")
                            .font(.subheadline)
                            .foregroundColor(quizManager.getPercentageColor())
                    }
                }
            }
        }
        .navigationTitle("Results")
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

struct PrototypeQuizResults_Previews: PreviewProvider {
    static var previews: some View {
        PrototypeQuizResults()
    }
}
