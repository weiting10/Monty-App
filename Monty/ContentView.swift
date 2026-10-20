import SwiftUI

struct ContentView: View {
    // Dark green table color
    private let tableGreen = Color(red: 0.05, green: 0.25, blue: 0.10)
    private let cardCount = 5
    private let prize = 100

    /// Game phases drive which buttons are enabled
    enum Phase {
        case idle      // cards stacked, waiting for Play
        case dealing   // cards animating out (all buttons disabled)
        case playing   // waiting for the user to pick a card
        case over      // a card was picked, Reset available
    }

    @State private var phase: Phase = .idle
    @State private var isSpread = false              // false = stacked in the center
    @State private var aceIndex = Int.random(in: 0..<5)
    @State private var revealed = Array(repeating: false, count: 5)
    @State private var showResult = false            // controls the Winner/Loser message
    @State private var didWin = false
    @State private var playerBalance = 500
    @State private var houseBalance = 500

    // USD currency formatter
    private let currencyFormatter: NumberFormatter = {
        let f = NumberFormatter()
        f.numberStyle = .currency
        f.currencyCode = "USD"
        f.maximumFractionDigits = 0
        return f
    }()

    private func money(_ amount: Int) -> String {
        currencyFormatter.string(from: NSNumber(value: amount)) ?? "$\(amount)"
    }

    var body: some View {
        VStack(spacing: 0) {
            gameArea
            controlStrip
        }
        .background(tableGreen.ignoresSafeArea())
    }
   

    private var gameArea: some View {
        GeometryReader { geo in
            let cardWidth = geo.size.width * 0.14
            let step = cardWidth + geo.size.width * 0.02

            ZStack {
                tableGreen

                // Cards: stacked at center until Play spreads them out
                ForEach(0..<cardCount, id: \.self) { index in
                    CardView(
                        faceImage: index == aceIndex ? "ace" : "blank",
                        isRevealed: revealed[index]
                    )
                    .frame(width: cardWidth)
                    .offset(x: isSpread ? CGFloat(index - cardCount / 2) * step : 0)
                    .zIndex(Double(index))
                    .onTapGesture { pick(index) }
                }

                // Winner / Loser message slides in from the top
                if showResult {
                    Image(didWin ? "winner" : "loser")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.6)
                        .transition(.move(edge: .top).combined(with: .opacity))
                        .zIndex(100)
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .clipped()
        }
    }

    private var controlStrip: some View {
        HStack(spacing: 120) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Player: \(money(playerBalance))")
                Text("House: \(money(houseBalance))")
            }
            .font(.caption2)
            .foregroundStyle(.yellow)
            

            Button("Reset") { reset() }
                .tint(.green)
                .disabled(phase != .over)
            

            Button("Play") { play() }
                .tint(.white)
                .disabled(phase != .idle)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 44)
        .padding(.bottom, 4)
        .background(Color(white: 0.12).ignoresSafeArea(edges: [.bottom, .horizontal]))
    }


    // Game logic
    private func play() {
        guard phase == .idle else { return }
        phase = .dealing                  // all buttons disabled
        aceIndex = Int.random(in: 0..<cardCount)

        withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
            isSpread = true
        }
        // Let the spread animation finish before allowing picks
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            if phase == .dealing { phase = .playing }
        }
    }

    private func pick(_ index: Int) {
        guard phase == .playing else { return }

        didWin = (index == aceIndex)
        if didWin { playerBalance += prize } else { houseBalance += prize }
        phase = .over                     // Reset enabled, Play disabled

        withAnimation(.easeInOut(duration: 0.6)) {
            revealed[index] = true
        }
        withAnimation(.spring(response: 0.6, dampingFraction: 0.65).delay(0.3)) {
            showResult = true
        }
    }

    private func reset() {
        guard phase == .over else { return }
        phase = .idle                     // Reset disabled, Play enabled

        // Message leaves, cards flip back face down
        withAnimation(.easeInOut(duration: 0.4)) {
            showResult = false
        }
        withAnimation(.easeInOut(duration: 0.6)) {
            revealed = Array(repeating: false, count: cardCount)
        }
        // After the flip, gather the cards back into the center stack
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            if phase == .idle {
                withAnimation(.spring(response: 0.6, dampingFraction: 0.8)) {
                    isSpread = false
                }
            }
        }
    }
}

#Preview(traits: .landscapeLeft) {
    ContentView()
}
