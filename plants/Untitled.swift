//
//  Untitled.swift
//  plants
//
//  Created by noura on 27/10/2025.
//
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PlantViewModel()
    @State private var showSheet = false
    @State private var navigateToToday = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 20) {
                    Text("My Plants 🌱")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .padding(.top, 40)

                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 0.5)
                        .padding(.horizontal, 16)

                    Spacer()
                    
                    Image("plants")
                        .resizable()
                        .frame(width: 164, height: 200)
                        .padding(.top, 20)

                    Text("Start your plant journey!")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(.white)

                    Text("Now all your plants will be in one place and we will help you take care of them :)🪴")
                        .font(.system(size: 16))
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                    Spacer()

                    Button("Set Plant Reminder") {
                        showSheet = true
                    }
                    .font(.system(size: 20))
                    .frame(width: 280, height: 42)
                    .background(Color("cyan"))
                    .foregroundColor(.white)
                    .cornerRadius(25)
                    .padding(.bottom, 100)

                    NavigationLink(
                        destination: TodayReminder(viewModel: viewModel),
                        isActive: $navigateToToday
                    ) {
                        EmptyView()
                    }
                    .hidden()
                }
            }
            .sheet(isPresented: $showSheet) {
                SheetView(viewModel: viewModel) {
                    showSheet = false
                    navigateToToday = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

