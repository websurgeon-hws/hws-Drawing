//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var gradientPosition = 1.0
    var steps = 100

    var body: some View {
        let end = UnitPoint(x: UnitPoint.bottom.x,
                            y: UnitPoint.bottom.y * CGFloat(self.gradientPosition))
        return ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: CGFloat(value))
                    .strokeBorder(LinearGradient(gradient: Gradient(colors: [
                        self.color(for: value, brightness: 1),
                        self.color(for: value, brightness: 0.5)
                    ]), startPoint: .top, endPoint: end), lineWidth: 2)
            }
        }
        .drawingGroup() // renders in offscreen image before putting on to screen as single rendered output (uses Metal)
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(self.steps) + self.amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var colorCycle = 0.0
    @State private var gradientPosition = 1.0

    var body: some View {
        VStack {
            Spacer()

            ColorCyclingRectangle(amount: self.colorCycle,
                                  gradientPosition: self.gradientPosition)
                .frame(width: 300, height: 300)

            Spacer()
            
            Text("Color")
            Slider(value: $colorCycle)
            Spacer()
            Text("Gradient Position")
            Slider(value: $gradientPosition, in: 0...1, step: 0.1)
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
