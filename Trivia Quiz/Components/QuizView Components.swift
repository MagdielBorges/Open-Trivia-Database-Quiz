//
//  QuizView Components.swift
//  Trivia Quiz
//
//  Created by Magdiel Borges on 4/25/22.
//

import SwiftUI

extension QuizView {
    var titleLabel: some View {
        Text("Trivia Quiz")
            .font(.largeTitle)
    }
    var quizTypeLabel: some View {
        Text(quizManager.getQuestionType())
            .minimumScaleFactor(0.5)
            .font(.subheadline)
            .padding(1)
            .padding(.horizontal, 3)
            .background(.green, in: RoundedRectangle(cornerRadius: 12))
    }
    var quizCategoryLabel: some View {
        Text(quizManager.getQuestionCategory())
            .font(.subheadline)
            .padding(1)
            .padding(.horizontal, 3)
            .background(.indigo, in: RoundedRectangle(cornerRadius: 12))
    }
    
    var quizQuestion: some View {
        GroupBox {
            Text(quizManager.getCurrentQuestion())
        }
    }
    
    @ViewBuilder
    var quizButtons: some View {
        if quizManager.isBoolean() {
            QuizButton("True")
                .padding(5)
            QuizButton("False")
                .padding(5)
        } else {
            ForEach(quizManager.quizAnswers, id: \.self) { answer in
                QuizButton(answer)
                    .padding(5)
            }
        }
    }
    
    var finalScore: some View {
        VStack {
            Text("Final Score: \(quizManager.score)/\(quizManager.amount)")
            Text("\(quizManager.getPercentage())%")
                .font(.largeTitle)
                .foregroundColor(quizManager.getPercentageColor())
        }
    }
    var quizProgress: some View {
        ProgressView(value: quizManager.getProgress())
            .padding()
    }
    var restartQuizButton: some View {
        Button("Restart Quiz") {
            quizManager.resetQuiz()
        }
    }
}
struct QuizView_Components_Previews: PreviewProvider {
    static var previewQuizManager: QuizManager {
        let previewQuestion = Results(category: "Entertainment: Video Games", type: "Preview", difficulty: "Preview", question: "Preview Question...", correct_answer: "Preview", incorrect_answers: ["Preview", "Preview", "Preview"])
        let previewQuiz = QuizData(results: [previewQuestion])
        let quizManager = QuizManager()
        quizManager.quizData = previewQuiz
        return quizManager
    }
    static var previews: some View {
        Group {
            QuizView()
                .environmentObject(previewQuizManager)
            QuizView()
                .preferredColorScheme(.dark)
                .environmentObject(previewQuizManager)
        }
    }
}
