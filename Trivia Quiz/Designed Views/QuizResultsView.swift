//
//  QuizResultsView.swift
//  Trivia Quiz
//
//  Created by Magdiel Borges on 4/28/22.
//

import SwiftUI

struct QuizResultsView: View {
    @EnvironmentObject var quizManager: QuizManager
    var body: some View {
        VStack {
            Text("Final Score: \(quizManager.score)/\(quizManager.amount)")
            Text("\(quizManager.getPercentage())%")
                .font(.largeTitle)
                .foregroundColor(quizManager.getPercentageColor())
            Button("Restart Quiz") {
                withAnimation {
                    quizManager.resetQuiz()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct QuizResultsView_Previews: PreviewProvider {
    static var previews: some View {
        QuizResultsView()
    }
}
