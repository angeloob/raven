//
//  ravenApp.swift
//  raven
//
//  Created by Angel Olvera on 09/12/24.
//

import SwiftUI
import SwiftData

@main
struct ravenApp: App {

    var body: some Scene {
        WindowGroup {
            NewsView(viewModel: NewsViewModel())
        }
    }
}
