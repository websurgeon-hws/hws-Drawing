//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))

        return path
    }
}


struct Arrow: Shape {

    private var headXScale: CGFloat = 1.0
    private var headYScale: CGFloat = 0.5
    private var shaftXScale: CGFloat = 1.0 / 3.0
    
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.addPath(headPath(in: rect))
        path.addPath(shaftPath(in: rect))
        
        return path
    }
    
    private func headPath(in rect: CGRect) -> Path {
        return Triangle().path(in: rect.divided(atDistance: rect.maxY * headYScale, from: .minYEdge).slice)
    }
    
    private func shaftPath(in rect: CGRect) -> Path {

        let shaftWidth = rect.width * shaftXScale
        let shaftHeight = rect.height * (1 - headYScale)

        return Rectangle().path(in:
            CGRect(x: rect.minX + (rect.width / 2.0) - (shaftWidth / 2.0),
                   y: rect.maxY - shaftHeight,
                   width: shaftWidth,
                   height: shaftHeight))
    }
}

struct ContentView: View {
    @State private var thickness: CGFloat = 10.0
    
    var body: some View {
        VStack {
            Spacer()

            Arrow()
                .stroke(Color.red, lineWidth: thickness)
                .frame(width: 200, height: 300)

            Spacer()
            
            Button(action: {
                withAnimation {
                    if self.thickness > 40 {
                        self.thickness = 1
                    } else {
                        self.thickness += 5
                    }
                }
            }) {
                Text("Animate")
            }
            Spacer()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
