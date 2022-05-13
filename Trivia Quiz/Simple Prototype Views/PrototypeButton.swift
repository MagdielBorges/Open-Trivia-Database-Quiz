//
//  PrototypeButtons.swift
//  Trivia Quiz
//
//  Created by Magdiel Borges on 5/2/22.
//

import SwiftUI

struct PrototypeButton: View {
    @EnvironmentObject var quizManager: QuizManager
    var buttonAnswer: String
    var buttonLabel: String {
        cleanString(buttonAnswer)
    }
    
    init(_ buttonAnswer: String) {
        self.buttonAnswer = buttonAnswer
    }
    var body: some View {
        Button(buttonLabel) {
            quizManager.pressedButton(buttonAnswer)
        }
        .tint(buttonColor())
    }
    func buttonColor() -> Color {
        if quizManager.playerAnswer.isEmpty {
            return .primary
        } else {
            if quizManager.playerAnswer == buttonAnswer {
                if quizManager.getCorrectAnswer() == buttonAnswer {
                    return .green
                } else {
                    return .red
                }
            } else {
                if quizManager.getCorrectAnswer() == buttonAnswer {
                    return .blue
                } else {
                    return .primary
                }
            }
        }
    }
}

struct PrototypeButton_Previews: PreviewProvider {
    static var quizManager = QuizManager()
    static var previews: some View {
        PrototypeButton("Button")
            .previewLayout(.sizeThatFits)
            .environmentObject(quizManager)
    }
}
