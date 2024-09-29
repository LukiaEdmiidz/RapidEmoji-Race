//
//  StartScreenView.swift
//  EmojiRealmDB
//
//  Created by Nik Edmiidz on 9/29/24.
//

import SwiftUI

struct StartScreenView: View {
    var body: some View {
        VStack(spacing: 20) {
            // "Hello" Button
            Button(action: {
                // Action for Hello
                print("Hello tapped")
            }) {
                Text("Hello")
                    .font(.largeTitle)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            // "Bonjour" Button
            Button(action: {
                // Action for Bonjour
                print("Bonjour tapped")
            }) {
                Text("Bonjour")
                    .font(.largeTitle)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }

            // "こんにちは" Button
            Button(action: {
                // Action for こんにちは
                print("こんにちは tapped")
            }) {
                Text("こんにちは")
                    .font(.largeTitle)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .navigationTitle("Welcome")
    }
}

struct StartScreenView_Previews: PreviewProvider {
    static var previews: some View {
        StartScreenView()
    }
}
