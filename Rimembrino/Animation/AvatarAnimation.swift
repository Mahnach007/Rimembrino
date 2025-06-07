import SwiftUI
import Lottie


// LottieView to wrap LottieAnimationView for use in SwiftUI
struct LottieView: UIViewRepresentable, View {
    var animationName: String
    var loopMode: LottieLoopMode = .loop
    var onComplete: (() -> Void)? = nil
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIView(frame: .zero)

        let animationView = LottieAnimationView(name: animationName)
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = loopMode
        animationView.play { (finished) in
            if finished {
                onComplete?()  // Call the completion handler
            }
        }

        // Add animationView as a subview of the UIView
        view.addSubview(animationView)

        // Set animationView's constraints
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        // No need to update in this case
    }
}


#Preview {
    LottieView(animationName: "elephant")
}
