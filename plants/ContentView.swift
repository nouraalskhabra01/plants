//
//  ContentView.swift
//  plants
//
//  Created by noura on 19/10/2025.
//
import SwiftUI

struct ContentView: View {
    @State private var plants: [Plant] = []
    @State private var goToSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.black)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    HStack {
                        Text("My Plants 🌱")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 40)
                    
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 0.5)
                        .padding(.horizontal, 16)
                    
                    Image("plants") // غير الاسم لاسم الصورة عندك
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
                    
                    Button(action: {
                        goToSheet = true
                    }) {
                        Text("Set Plant Reminder")
                            .font(.system(size: 20))
                            .frame(width: 280, height: 42)
                            .background(Color("cyan"))
                            .foregroundColor(.white)
                            .cornerRadius(25)
                    }
                    .padding(.bottom, 100)
                    
                    NavigationLink("", destination: SheetView(plants: $plants), isActive: $goToSheet)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    ContentView()
}

