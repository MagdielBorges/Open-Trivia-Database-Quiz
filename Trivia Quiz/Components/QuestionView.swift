//
//  QuestionView.swift
//  Trivia Quiz
//
//  Created by Magdiel Borges on 4/28/22.
//

import SwiftUI

struct QuestionView: View {
    @EnvironmentObject var quizManager: QuizManager
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            HStack {
                Text("Question:")
                    .bold()
                Spacer()
            }
            Text(quizManager.getCurrentQuestion())
                .minimumScaleFactor(0.5)
                .padding()
                .background(colorScheme == .light ? .blue : .orange, in: RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 12)
//            HStack {
//                Spacer()
//                QuizButton("Preview")
//                Spacer()
//                QuizButton("Preview")
//                Spacer()
//            }
//            if !quizManager.isBoolean() {
//                HStack {
//                    Spacer()
//                    QuizButton("Preview")
//                    Spacer()
//                    QuizButton("Preview")
//                    Spacer()
//                }
//            }
            if quizManager.isBoolean() {
                HStack {
                    Spacer()
                    QuizButton("True")
                    Spacer()
                    QuizButton("False")
                    Spacer()
                }
            } else {
                ForEach(quizManager.quizAnswers, id: \.self) { answer in
                    QuizButton(answer)
                }
            }
            GroupBox {
                HStack {
                    Text(quizManager.getQuestionType())
                        .font(.footnote)
                    Spacer()
                    Text(quizManager.getQuestionCategory())
                        .font(.footnote)
                }
            }
        }
        .padding()
        .background(colorScheme == .light ? .white : .black, in: RoundedRectangle(cornerRadius: 12))
        .shadow(color: colorScheme == .light ? .gray : .yellow,radius: 5)
        .padding()
    }
}

struct QuestionView_Previews: PreviewProvider {
    static var previewQuizManager: QuizManager {
        let previewQuestion = Results(category: "Preview", type: "Preview", difficulty: "Preview", question: "Preview Question", correct_answer: "Preview", incorrect_answers: ["Preview", "Preview", "Preview"])
        let previewQuiz = QuizData(results: [previewQuestion])
        let quizManager = QuizManager()
        quizManager.quizData = previewQuiz
        return quizManager
    }
    static var previews: some View {
        Group {
            QuestionView()
                .previewLayout(.sizeThatFits)
            .environmentObject(previewQuizManager)
            QuestionView()
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .environmentObject(previewQuizManager)
        }
    }
}
