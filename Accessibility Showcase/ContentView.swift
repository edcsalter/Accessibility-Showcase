//
//  ContentView.swift
//  Accessibility Showcase
//
//  Created by Ed Salter on 7/9/25.
//

import SwiftUI

struct ContentView: View {
	@State private var selectedDate = Date()
	
	var body: some View {
		ScrollView {
			VStack(spacing: 30) {
				VStack(alignment: .leading, spacing: 12) {
					Text("Accessible Date Picker")
						.font(.title)
						.bold()
					
					Text("This date picker fully supports Dynamic Type Size and displays dates in a readable format.")
						.font(.body)
						.foregroundColor(.secondary)
					
					AccessibleDatePicker(selectedDate: $selectedDate)
						.padding(.top, 8)
				}
				.padding()
				.frame(maxWidth: .infinity, alignment: .leading)
				
				Divider()
				
				VStack(alignment: .leading, spacing: 12) {
					Text("Web View with Dynamic Type")
						.font(.title)
						.bold()
					
					WebView()
				}
				.padding()
			}
			.padding()
		}
	}
}

#Preview {
	ContentView()
}
