//
//  IconView.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/8/20.
//

import SwiftUI

struct IconView: View {
    @State var icon: Asset
    var iconWidth: CGFloat = 100

    var body: some View {
        icon.testStaticImage!
            .resizable()
            .frame(width: iconWidth, height: iconWidth, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: iconWidth / 4, style: .continuous))
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        let icon = Asset(name: "Firefox", altText: "", image: Image("firefox"))

        ZStack {
            IconView(icon: icon)
        }
        .padding()
        .background(Color.black)
    }
}
