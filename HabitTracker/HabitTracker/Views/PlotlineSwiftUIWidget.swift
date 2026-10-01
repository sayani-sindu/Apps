//
//  PlotlineSwiftUIWidget.swift
//  HabitTracker
//
//  Created by Sindu on 06/09/26.
//


import SwiftUI
import Plotline

struct PlotlineSwiftUIWidget: UIViewRepresentable {
    var widgetId: String
    @Binding var height: CGFloat  // Binding for height adjustment

    func makeUIView(context: Context) -> PlotlineWidget {
        let widget = PlotlineWidget(clientElementId: widgetId)
        widget.setPlotlineWidgetListener(plotlineWidgetListener: context.coordinator)  // Set coordinator as listener
        return widget
    }

    func updateUIView(_ uiView: PlotlineWidget, context: Context) {
        // Updates to `PlotlineWidget` when SwiftUI updates
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(height: $height)
    }

    class Coordinator: NSObject, PlotlineWidgetListener {
        @Binding var height: CGFloat

        init(height: Binding<CGFloat>) {
            _height = height
        }

        func onWidgetReady(width: CGFloat, height: CGFloat) {
            DispatchQueue.main.async {
                self.height = height  // Update the binding when height changes
            }
        }
    }
}