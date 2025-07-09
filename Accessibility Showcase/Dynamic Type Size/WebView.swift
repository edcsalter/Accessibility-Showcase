//
//  WebView.swift
//  Dynamic Type Size Showcase
//
//  Created by Ed Salter on 7/8/25.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
	@Environment(\.dynamicTypeSize) private var dynamicTypeSize

	private func scaleForDynamicType(_ dynamicTypeSize: DynamicTypeSize) -> CGFloat {
		switch dynamicTypeSize {
		case .xSmall:
			return 0.8
		case .small:
			return 0.9
		case .medium:
			return 1.0
		case .large:
			return 1.1
		case .xLarge:
			return 1.2
		case .xxLarge:
			return 1.3
		case .xxxLarge:
			return 1.4
		case .accessibility1:
			return 1.5
		case .accessibility2:
			return 1.6
		case .accessibility3:
			return 1.7
		case .accessibility4:
			return 1.8
		case .accessibility5:
			return 2.0
		@unknown default:
			return 1.0
		}
	}

	func makeUIView(context: Context) -> WKWebView {
		let configuration = WKWebViewConfiguration()
		configuration.limitsNavigationsToAppBoundDomains = true

		let webView = WKWebView(frame: .zero, configuration: configuration)
		webView.navigationDelegate = context.coordinator
		context.coordinator.scale = scaleForDynamicType(dynamicTypeSize)

		if let url = URL(string: "https://github.com") {
			let request = URLRequest(url: url)
			webView.load(request)
		}
		return webView
	}

	func updateUIView(_ uiView: WKWebView, context: Context) {
		// Reload page when Dynamic Type scale changes
		let newScale = scaleForDynamicType(dynamicTypeSize)
		if context.coordinator.scale != newScale {
			context.coordinator.scale = newScale
			if let url = URL(string: "https://github.com") {
				let request = URLRequest(url: url)
				uiView.load(request)
			}
		}
	}

	func makeCoordinator() -> Coordinator {
		Coordinator()
	}

	class Coordinator: NSObject, WKNavigationDelegate {
		var scale: CGFloat = 1.0

		private func generateScaledFontJavaScript() -> String {
			let fontScalingJS = """
				// Scale all fonts on the page by Dynamic Type scale factor (max 200%)
				// First, capture original font sizes for all elements
				var allElements = document.querySelectorAll('*');

				console.log('Font scaling results (scale factor: \(scale)):');

				// Find the base paragraph font size for normalization
				var baseFontSize = 16; // fallback
				var paragraphElement = document.querySelector('p');
				if (paragraphElement) {
					var paragraphStyle = window.getComputedStyle(paragraphElement);
					baseFontSize = parseFloat(paragraphStyle.fontSize) || 16;
				} else {
					// If no paragraph found, use body font size
					var bodyElement = document.querySelector('body');
					if (bodyElement) {
						var bodyStyle = window.getComputedStyle(bodyElement);
						baseFontSize = parseFloat(bodyStyle.fontSize) || 16;
					}
				}

				console.log('Base font size for normalization: ' + baseFontSize + 'px');

				allElements.forEach(function(element) {
					// Get the computed font size for this element
					var computedStyle = window.getComputedStyle(element);
					var currentFontSize = parseFloat(computedStyle.fontSize);

					// Skip elements with no meaningful font size or extremely large fonts
					if (isNaN(currentFontSize) || currentFontSize <= 0 || currentFontSize > 100) {
						return;
					}

					// Check if element is inside a list
					var isInList = element.closest('ul, ol, li') !== null;

					// Store original font size as data attribute ONLY if not already stored
					var originalFontSize;
					if (!element.dataset.originalFontSize) {
						// Normalize paragraphs, hyperlinks, and ALL elements within lists to use the same base font size
						if (element.tagName === 'P' || element.tagName === 'A' || element.tagName === 'LI' || element.tagName === 'UL' || element.tagName === 'OL' || isInList) {
							originalFontSize = baseFontSize;
						} else {
							originalFontSize = currentFontSize;
						}
						element.dataset.originalFontSize = originalFontSize;
					} else {
						originalFontSize = parseFloat(element.dataset.originalFontSize);
					}

					// Apply scaled font size based on original size
					var scaledSize = originalFontSize * \(scale);

					// Cap the scaled size to prevent extremely large text
					if (scaledSize > originalFontSize * 2) {
						scaledSize = originalFontSize * 2;
					}

					element.style.fontSize = scaledSize + 'px';

					// Log the scaling results for debugging
					var elementDescription = element.tagName.toLowerCase();
					if (element.id) {
						elementDescription += '#' + element.id;
					} else if (element.className) {
						elementDescription += '.' + element.className.split(' ')[0];
					}

					// Add indicator if element is in a list
					if (isInList) {
						elementDescription += ' (in-list)';
					}

					// Only log if there's actual text content or if it's a significantly sized element
					if (element.textContent.trim().length > 0 || scaledSize >= 16) {
						console.log('- ' + elementDescription + ' "' + element.textContent.trim().substring(0, 20) + '"');
						console.log('    - Original: ' + originalFontSize + 'px');
						console.log('    - Scaled: ' + scaledSize + 'px');
					}
				});

				// Add aggressive CSS to normalize list styling (using JavaScript variables)
				var listFontSize = baseFontSize * \(scale);
				var bulletStyle = document.createElement('style');
				bulletStyle.textContent = 
					'/* Force all list elements and hyperlinks to use normalized font size */' +
					'ul, ol, li, ul *, ol *, li *, a {' +
						'font-size: ' + listFontSize + 'px !important;' +
					'}' +
					'li::before, li::marker {' +
						'font-size: inherit !important;' +
					'}' +
					'li {' +
						'line-height: 1.4 !important;' +
					'}';
				document.head.appendChild(bulletStyle);

				console.log('Added CSS to force list and hyperlink font size to: ' + listFontSize + 'px');
			"""

			let hideHeaderFooterJS = """
				// Hide header and footer elements
				var headerFooterSelectors = [
					'header', 'footer', 
					'[role="banner"]', '[role="contentinfo"]',
					'.header', '.footer', '.site-header', '.site-footer',
					'#header', '#footer', '#site-header', '#site-footer',
					'nav', '.navigation', '.nav', '.navbar'
				];

				headerFooterSelectors.forEach(function(selector) {
					var elements = document.querySelectorAll(selector);
					elements.forEach(function(element) {
						element.style.display = 'none';
						console.log('Hidden element: ' + selector);
					});
				});
			"""

			return """
				(function(){
					\(fontScalingJS)

					\(hideHeaderFooterJS)
				})();
			"""
		}

		func webView(_ webView: WKWebView, didFinish _: WKNavigation!) {
			let js = generateScaledFontJavaScript()
			webView.evaluateJavaScript(js) { _, error in
				if let error = error {
					print("JavaScript evaluation error: \(error.localizedDescription)")
				}
			}
		}

		func webView(
			_: WKWebView, decidePolicyFor navigationAction: WKNavigationAction,
			decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
		) {
			if let url = navigationAction.request.url {
				if url.absoluteString == "about:blank" {
					decisionHandler(.cancel)
					return
				}

				print("Navigating to: \(url.absoluteString)")
			}
			decisionHandler(.allow)
		}
	}
}

#Preview {
	WebView()
}
