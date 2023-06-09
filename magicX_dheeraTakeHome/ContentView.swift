//
//  ContentView.swift
//  magicX_dheeraTakeHome
//
//  Created by Dheera Vuppala on 6/8/23.
//

import SwiftUI
import WebKit

// ViewModel
class WebViewModel: ObservableObject {
    @Published var statusText: String = "Loading..."
    
    func openFirstEvent(from webView: WKWebView) {
            webView.evaluateJavaScript("document.getElementsByClassName('col-xs-12 col-sm-7')[0].getElementsByTagName('a')[0].click();", completionHandler: nil)
      
    }
    
    func getFirstEventName(from webView: WKWebView) {
        webView.evaluateJavaScript("document.getElementsByClassName('col-xs-12 col-sm-7')[0].getElementsByTagName('span')[0].textContent", completionHandler: { (result, error) in
            if let eventName = result as? String {
                DispatchQueue.main.async {
                    self.statusText = eventName
                }
            }
        })
    }
}

// View
// describe how the app should look
struct ContentView: View {
    @StateObject var model = WebViewModel()
    @State private var webView = WKWebView()

    var body: some View {
        VStack {
            Text("Events Explorer")
                .font(.largeTitle)
                .padding()
            //Link(url)
            WebView(url: URL(string: "https://www.sfstation.com/calendar")!, model: model, webView: $webView)
            if model.statusText == "Loading..." {
                Text(model.statusText)
            } else {
                Text("Upcoming Event")
                    .font(.subheadline)
                    .foregroundColor(.indigo)
                Text(model.statusText)
                    .onTapGesture {
                        model.openFirstEvent(from: webView)
                    }
            }
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    let model: WebViewModel
    @Binding var webView: WKWebView

    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        let parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.model.getFirstEventName(from: webView)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
