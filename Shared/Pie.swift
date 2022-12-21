//
//  Pie.swift
//  CardMemorizer
//
//  Created by Admin on 21.11.2022.
//

import SwiftUI

struct Pie: Shape {

    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool
    var pieColor: UIColor = .blue
    
    var animatableData: AnimatablePair<Double, Double> {
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle(radians: newValue.first)
            endAngle = Angle(radians: newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var p = Path()

        let center = CGPoint(x: rect.midX	, y: rect.midY)
        p.move(to: center)

        p.addArc(center: center,
                 radius: 3*rect.width/4,
                 startAngle: startAngle,
                 endAngle: endAngle,
                 clockwise: clockwise,
                 transform: .identity)
        p.closeSubpath()
        return p
    }
}

private struct PieView: View {
    var body: some View {
        Pie(startAngle: .degrees(0), endAngle: .degrees(270), clockwise: true, pieColor: .blue)
    }
}

struct PieView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            PieView()
                .padding()
        }
        .foregroundColor(.blue)
    }
}
