//
//  Cardify.swift
//  CardMemorizer
//
//  Created by Admin on 21.11.2022.
//

import SwiftUI

struct Cardify: AnimatableModifier {

    private let cornerRadius: CGFloat = 10.0
    private let edgeLineWidth: CGFloat = 3.0

    var rotation: Double

    var isFaceUp: Bool {
        rotation < 90
    }

    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }

    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }

    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke()
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill()
                .opacity(isFaceUp ? 0 : 1)

        }
        .rotation3DEffect(.degrees(rotation), axis: (x: 0.0, y: 1.0, z: 0.0))
    }

}

extension View {
    func cardfiy(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

