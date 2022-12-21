//
//  TitleScreen.swift
//  CardMemorizer
//
//  Created by Admin on 18.12.2022.
//

import SwiftUI

struct TitleScreen : View{
    
    @State
    private var currentTheme: ThemeFactory.ThemeOption =  .love
    
    @State
    private var currentDifficutly: DifficultyFactory.DifficutlyOption = .medium
    
    @State private var gameState : GameState = .title;
    
    fileprivate func showTitleView() -> some View {
        return VStack{
            VStack{
            Text("Choose difficulty")
                .padding()
            HStack{
                ForEach(DifficultyFactory.DifficutlyOption.allCases, id:\.self) {difficulty in
                    Button(action:{
                        currentDifficutly = difficulty
                    }){
                        Text(difficulty.description).foregroundColor((currentDifficutly.description == difficulty.description ? Color.green : Color.black))
                    }
                }
            }
        }.padding()
        Text("Chose theme")
            .padding()
        VStack {
            ForEach(ThemeFactory.ThemeOption.allCases, id:\.self){theme in
                Button(action:{
                        currentTheme=theme
                
                }){
                    Text(theme.description).foregroundColor((currentTheme.name == theme.name ? Color.green : Color.black))
                }
            }
        }.padding()
        Button("Start game"){
            gameState = .playing;
           }
        Button("Get help"){
            gameState = .help;
            }
        }
    }
    
    fileprivate func showGameView()-> some View{
        return EmojiGameView(viewModel: GameFactory.createMemoryGame(theme: currentTheme,difficutly: currentDifficutly,
                                                                     startNewGame: {gameState = .title}))
    }
    fileprivate func showHelpView()-> some View{
        return VStack{
            Text("Memory game help").padding()
            Text("To win the game you should match cards with the identical ones, match gives you 2 score and miss takes 1 score, you can use hint by paying 5 score to see all cards for 1 second").padding()
            Text("You can choose difficulty for 8, 12 and 24 card and take the theme you loved most").padding()
            Button("Return"){gameState = .title}
        }
    }
    
    var body: some View {
        switch gameState {
        case .title:
         return AnyView(showTitleView())
        case .playing:
            return AnyView(showGameView())
        case .help:
            return AnyView(showHelpView())
       }
}

}
