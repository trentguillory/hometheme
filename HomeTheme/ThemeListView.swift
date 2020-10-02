//
//  ThemeListView.swift
//  HomeTheme
//
//  Created by Trent Guillory on 10/1/20.
//

import SwiftUI

struct ThemeListView: View {
    @State var themesModel = ThemesViewModel()
    
    var body: some View {
        VStack {
//            List(themesModel.themes, id: \.id) { theme in
//                HStack(alignment: .center) {
//                    Text(theme.title)
//                    Text(theme.description)
//                }
//                .padding()
//                .background(Color.blue)
//            }
            LazyVStack {
                ForEach(themesModel.themes, id: \.id) { theme in
                    HStack(alignment: .center) {
                        Text(theme.title)
                        Text(theme.description)
                    }
                    .padding()
                    .background(Color.blue)
                }
            }
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Button(action: {
                NetworkManager.shared.getThemes { themes in
                    DispatchQueue.main.async {
                        themesModel.themes = themes
                    }
                }
            }, label: {
                Text("Fetch Themes")
            })
        }
        .onAppear {
            NetworkManager.shared.getThemes { themes in
                DispatchQueue.main.async {
                    themesModel.themes = themes
                }
            }
        }
    }
}

struct ThemeListView_Previews: PreviewProvider {
    static var previews: some View {
        ThemeListView()
    }
}
