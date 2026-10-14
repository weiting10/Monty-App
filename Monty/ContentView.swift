import SwiftUI

struct ContentView: View {
    // Dark green background color
    private let tableGreen = Color(red: 0.05, green: 0.25, blue: 0.10)

    // Which of the 3 cards is the ace
    @State private var aceIndex = Int.random(in: 0..<3)
    // Which cards have been flipped face up
    @State private var revealed = [false, false, false]
    // True once the user has picked a card (round won/lost)
    @State private var roundOver = false
    // Result of the round
    @State private var didWin = false

    var body: some View {
        ZStack {
            // set background
            tableGreen
                .ignoresSafeArea()

            VStack(spacing: 24) {
                

                // Winner / Loser images s
                Spacer()
                ZStack {
                    Image("winner")
                        .resizable()
                        .scaledToFit()
                        .opacity(roundOver && didWin ? 1 : 0)
                    //.opacity(1) is fully visible;
                    //.opacity(0) is fully invisible;
                    

                    Image("loser")
                        .resizable()
                        .scaledToFit()
                        .opacity(roundOver && !didWin ? 1 : 0)
                }
                .frame(height: 150)

                HStack(spacing: 12) {
                    ForEach(0..<3, id: \.self) { index in
                        // call CardView
                        CardView(
                            //"index" is the card the user picks;
                            faceImage: index == aceIndex ? "ace" : "blank",
                            isRevealed: revealed[index] // change that index from "false" to "true" in "revealed[]"
                        )
                        .onTapGesture {
                            pick(index) // this function mark the card revealed and works out if the user won
                        }
                    }
                }
                .padding(.horizontal)

                Spacer()
                

                Button("New Game") {
                    newGame()
                }
                .tint(.white)
                .disabled(!roundOver)   // disabled during a round, enabled after win/loss
            }
            .padding()
        }
    }

    // MARK: - Game logic

    private func pick(_ index: Int) {
        // Ignore all taps once a card has been revealed
        guard !roundOver else { return }

        revealed[index] = true
        didWin = (index == aceIndex)
        roundOver = true
    }

    // when starting a new game, reset the "revealed[]" and "roundOver" to false
    private func newGame() {
        aceIndex = Int.random(in: 0..<3)
        revealed = [false, false, false]
        didWin = false
        roundOver = false
    }
}

#Preview {
    ContentView()
}
