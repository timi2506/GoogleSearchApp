import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var showWebView = false
    @State private var searchURL: URL?

    var body: some View {
        VStack {
            HStack {
                TextField("Enter search", text: $searchText, onCommit: {
                    performSearch()
                })
                .frame(height: 50)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.horizontal)

                // Use platform-specific colors for background
                .background(
                    Color(PlatformColor.grayBackground)
                )
                .cornerRadius(30)
                .frame(width: 300)

                Button(action: {
                    performSearch()
                }) {
                    Text("Search")
                        .frame(width: 80, height: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }
            }
            .frame(width: 400, height: 75)
            .padding()
        }
        .sheet(isPresented: $showWebView) {
            if let url = searchURL {
                WebViewContainer(url: url, showWebView: $showWebView)
            }
        }
    }

    private func performSearch() {
        if let encodedSearch = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: "https://www.google.com/search?q=\(encodedSearch)") {
            searchURL = url
            showWebView = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Define platform-specific color
struct PlatformColor {
    #if os(iOS)
    static let grayBackground = UIColor.systemGray5
    #elseif os(macOS)
    static let grayBackground = NSColor.windowBackgroundColor
    #endif
}
