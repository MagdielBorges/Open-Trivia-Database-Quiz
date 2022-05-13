//
//  ControllerView.swift
//  Trivia Quiz
//
//  Created by Magdiel Borges on 4/28/22.
//

import SwiftUI

struct ControllerView: View {
    @EnvironmentObject var quizManager: QuizManager

    var body: some View {
        switch quizManager.mode {
        case .menu:
            NavigationView {
                QuizMenuView()
            }
        case .loading:
            ProgressView()
        case .quiz:
            //QuizView()
                //.transition(.scale)
            NavigationView {
                PrototypeView()
            }
        case .results:
            //QuizResultsView()
                //.transition(.move(edge: .top))
            NavigationView {
                PrototypeQuizResults()
            }
        }
    }
}

struct ControllerView_Previews: PreviewProvider {
    static var quizManager = QuizManager()
    static var previews: some View {
        ControllerView()
            .environmentObject(quizManager)
    }
}
