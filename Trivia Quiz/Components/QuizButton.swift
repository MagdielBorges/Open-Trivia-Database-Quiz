//
//  QuizButton.swift
//  Trivia Quiz
//
//  Created by Magdiel Borges on 4/25/22.
//

import SwiftUI

struct QuizButton: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var quizManager: QuizManager
    @State private var selected = false
    var buttonAnswer: String
    var buttonLabel: String {
        cleanString(buttonAnswer)
    }
    
    init(_ buttonAnswer: String) {
        self.buttonAnswer = buttonAnswer
    }
    var body: some View {
        Button(action: {
            if quizManager.playerAnswer.isEmpty {
                quizManager.playerAnswer = buttonAnswer
                selected = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    if quizManager.progress + 1 == quizManager.amount {
                        withAnimation {
                            quizManager.mode = .results
                        }
                    }
                    if quizManager.playerAnswer == quizManager.getCorrectAnswer() {
                        quizManager.score += 1
                    }
                    quizManager.playerAnswer = ""
                    if quizManager.progress + 1 < quizManager.amount {
                        withAnimation {
                            quizManager.progress += 1
                        }
                    }
                    quizManager.updateUI()
                    selected = false
                }
            }
        }) {
            Text(buttonLabel)
                .padding(5)
//                .background(colorScheme == .light ? .blue : .orange, in: RoundedRectangle(cornerRadius: 8))
                .background(buttonColor(), in: RoundedRectangle(cornerRadius: 8))
        }
        //.buttonStyle(.bordered)
        //.tint(buttonColor())
        .shadow(radius: 5, x: 5, y: 5)
        .foregroundColor(.primary)
    }
    
    func buttonColor() -> Color {
        switch selected {
        case true:
            switch quizManager.getCorrectAnswer() == quizManager.playerAnswer {
            case true:
                return .green
            case false:
                return .red
            }
        case false:
            switch !quizManager.playerAnswer.isEmpty {
            case true:
                if quizManager.getCorrectAnswer() == buttonAnswer {
                    return .blue
                } else {
                    return colorScheme == .light ? .mint : .orange
                }
            case false:
                return colorScheme == .light ? .mint : .orange
            }
        }
    }
}

struct QuizButton_Previews: PreviewProvider {
    static var previewQuizManager = QuizManager()
    static var previews: some View {
        Group {
            QuizButton("Button")
                .previewLayout(.sizeThatFits)
            .environmentObject(previewQuizManager)
            QuizButton("Button")
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .environmentObject(previewQuizManager)
        }
    }
}
