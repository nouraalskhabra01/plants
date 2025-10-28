//
//  Untitled 2.swift
//  plants
//
//  Created by noura on 27/10/2025.
//

import SwiftUI

struct TodayReminder: View {
    @ObservedObject var viewModel: PlantViewModel
    @State private var showAddPlantSheet = false
    @State private var editingPlant: Plant? = nil

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color.black.ignoresSafeArea()

            VStack(spacing: 16) {
                Text("My Plants 🌱")
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 16)
                    .padding(.top, 40)

                Rectangle()
                    .fill(Color.gray.opacity(0.5))
                    .frame(height: 0.5)
                    .padding(.horizontal, 16)

                if !viewModel.allDone {
                    VStack(spacing: 8) {
                        Text(viewModel.selectedPlants.isEmpty ?
                             "Your plants are waiting for a sip 💦" :
                             "\(viewModel.selectedPlants.count) of your plants feel loved today ✨")
                            .font(.system(size: 18))
                            .foregroundColor(.white)

                        ProgressView(value: viewModel.plants.isEmpty ? 0 : Double(viewModel.selectedPlants.count) / Double(viewModel.plants.count))
                            .progressViewStyle(.linear)
                            .tint(Color("cyan"))
                            .frame(height: 10)
                            .background(Color(.systemGray5))
                            .cornerRadius(4)
                            .padding(.horizontal, 20)
                            .animation(.easeInOut(duration: 0.2), value: viewModel.selectedPlants.count)
                    }

                    List {
                        ForEach(viewModel.plants) { plant in
                            HStack(spacing: 14) {
                                Button(action: { viewModel.toggleSelection(for: plant) }) {
                                    Image(systemName: viewModel.selectedPlants.contains(plant.id) ? "checkmark.circle.fill" : "circle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(viewModel.selectedPlants.contains(plant.id) ? Color("cyan") : .gray)
                                }
                                .buttonStyle(PlainButtonStyle())

                                VStack(alignment: .leading, spacing: 8) {
                                    HStack(spacing: 6) {
                                        Image(systemName: "paperplane").foregroundColor(.gray)
                                        Text("in \(plant.room)").foregroundColor(.gray).font(.system(size: 14))
                                    }

                                    Text(plant.name)
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.white)

                                    HStack(spacing: 13) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.white.opacity(0.1))
                                                .frame(width: 89, height: 23)
                                            HStack(spacing: 6) {
                                                Image(systemName: "sun.max").resizable().scaledToFit()
                                                    .frame(width: 18, height: 18)
                                                    .foregroundColor(Color("sun"))
                                                Text(plant.light).foregroundColor(Color("sun")).font(.system(size: 14, weight: .semibold))
                                            }.padding(.horizontal, 8)
                                        }

                                        ZStack {
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(Color.white.opacity(0.1))
                                                .frame(width: 102, height: 23)
                                            HStack(spacing: 6) {
                                                Image(systemName: "drop").resizable().scaledToFit()
                                                    .frame(width: 18, height: 18)
                                                    .foregroundColor(Color("water"))
                                                Text(plant.water).foregroundColor(Color("water")).font(.system(size: 14, weight: .semibold))
                                            }.padding(.horizontal, 8)
                                        }
                                    }
                                }
                                .padding(.vertical, 12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            .listRowBackground(Color.clear)
                            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) { viewModel.deletePlant(plant) } label: { Label("Delete", systemImage: "trash") }
                            }
                            .onTapGesture {
                                editingPlant = plant
                                showAddPlantSheet = true
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .scrollContentBackground(.hidden)
                } else {
                    VStack(spacing: 20) {
                        Spacer()
                        Image("plants2")
                            .resizable()
                            .frame(width: 164, height: 200)
                            .padding(.top, 20)
                        Text("All Done! 🎉")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                }
            }

            Button(action: {
                if viewModel.allDone { viewModel.resetAll() }
                editingPlant = nil
                showAddPlantSheet.toggle()
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Color("cyan"))
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
            }
            .padding(.trailing, 20)
            .padding(.bottom, 30)
            .sheet(isPresented: $showAddPlantSheet) {
                SheetView(viewModel: viewModel, editingPlant: editingPlant) {}
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
