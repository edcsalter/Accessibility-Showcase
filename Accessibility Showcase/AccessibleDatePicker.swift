//
//  AccessibleDatePicker.swift
//  Accessibility Showcase
//
//  Created by Ed Salter on 7/9/25.
//

import SwiftUI

struct AccessibleDatePicker: View {
    @Binding var selectedDate: Date
    @State private var isPickerPresented = false
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d, yyyy" // Format: "July 9, 1985"
        return formatter
    }
    
    private var formattedDate: String {
        dateFormatter.string(from: selectedDate)
    }
    
    var body: some View {
        Button(action: {
            isPickerPresented = true
        }) {
            HStack {
                Text(formattedDate)
                    .font(.body)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "calendar")
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
        .buttonStyle(.plain)
        .accessibilityLabel("Date picker")
        .accessibilityHint("Double tap to select a date. Currently selected: \(formattedDate)")
        .accessibilityTraits(.button)
        .dynamicTypeSize(...DynamicTypeSize.accessibility5)
        .sheet(isPresented: $isPickerPresented) {
            NavigationView {
                VStack(spacing: 20) {
                    DatePicker(
                        "Select a date",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .padding()
                    .dynamicTypeSize(...DynamicTypeSize.accessibility5)
                    .accessibilityLabel("Date picker. Use the wheels to select month, day, and year.")
                    
                    Spacer()
                }
                .navigationTitle("Select Date")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            isPickerPresented = false
                        }
                        .font(.body)
                        .dynamicTypeSize(...DynamicTypeSize.accessibility5)
                    }
                }
            }
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @State private var date = Date()
        
        var body: some View {
            VStack(spacing: 20) {
                AccessibleDatePicker(selectedDate: $date)
                
                Text("Selected: \(date, formatter: {
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MMMM d, yyyy"
                    return formatter
                }())")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
        }
    }
    
    return PreviewWrapper()
}
