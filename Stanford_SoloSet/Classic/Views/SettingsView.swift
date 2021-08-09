//
//  SettingsView.swift
//  Stanford_SoloSet
//
//  Created by Steve Blythe on 09/08/2021.
//

import SwiftUI

struct SettingsView: View {
    @Binding var colorBlind: Bool
    
    @Binding var showing: Bool
    
    var yOffset: CGFloat {
        if showing {
            return 40.0
        } else {
            return -30.0
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Toggle(isOn: $colorBlind, label: {
                    Text("Color Blind")
                })
                .padding()
                
                Button(action: {
                    withAnimation {
                        showing.toggle()
                    }
                }, label: {
                    if showing {
                        Image(systemName: "chevron.compact.up")
                            .font(.largeTitle)
                    } else {
                        Image(systemName: "chevron.compact.down")
                            .font(.largeTitle)
                    }
                })
                .padding()
            }
            .background(showing ? Color.white : Color.clear)
            .frame(width: geometry.size.width / 2, height: 100, alignment: .center)
            .position(x: geometry.size.width / 2, y: yOffset)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(colorBlind: .constant(true), showing: .constant(true))
    }
}
