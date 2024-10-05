import SwiftUI
import WebKit

struct WebViewContainer: View {
    var url: URL
    @Binding var showWebView: Bool
    @State private var webView = WKWebView()

    var body: some View {
        VStack {
            WebView(webView: webView, url: url)
                .edgesIgnoringSafeArea(.all)

            HStack {
                Button(action: {
                    showWebView = false
                }) {
                    Text("Back")
                        .frame(width: 100, height: 50)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }

                Spacer()

                Button(action: {
                    if let currentURL = webView.url {
                        #if os(iOS)
                        UIPasteboard.general.string = currentURL.absoluteString
                        #elseif os(macOS)
                        NSPasteboard.general.clearContents()
                        NSPasteboard.general.setString(currentURL.absoluteString, forType: .string)
                        #endif
                    }
                }) {
                    Text("Copy Link")
                        .frame(width: 100, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding()
                }
            }
        }
    }
}

#if os(iOS)
struct WebView: UIViewRepresentable {
    let webView: WKWebView
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // No update needed
    }
}
#elseif os(macOS)
struct WebView: NSViewRepresentable {
    let webView: WKWebView
    var url: URL

    func makeNSView(context: Context) -> WKWebView {
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateNSView(_ nsView: WKWebView, context: Context) {
        // No update needed
    }
}
#endif
