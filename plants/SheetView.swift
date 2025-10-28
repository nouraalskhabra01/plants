//
//  Untitled 3.swift
//  plants
//
//  Created by noura on 27/10/2025.
//

import SwiftUI

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: PlantViewModel
    var editingPlant: Plant? = nil
    var onDone: () -> Void = {}

    @State private var plantName: String
    @State private var selectedRoom: String
    @State private var selectedLight: String
    @State private var selectedWatering: String
    @State private var selectedWater: String

    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let lights = ["Full sun", "Partial sun", "Low light"]
    let wateringDays = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let waterAmounts = ["20–50 ml", "50–100 ml", "100–200 ml", "200–300 ml"]

    init(viewModel: PlantViewModel, editingPlant: Plant? = nil, onDone: @escaping () -> Void = {}) {
        self.viewModel = viewModel
        self.editingPlant = editingPlant
        self.onDone = onDone
        _plantName = State(initialValue: editingPlant?.name ?? "")
        _selectedRoom = State(initialValue: editingPlant?.room ?? "Bedroom")
        _selectedLight = State(initialValue: editingPlant?.light ?? "Full sun")
        _selectedWatering = State(initialValue: editingPlant?.watering ?? "Every day")
        _selectedWater = State(initialValue: editingPlant?.water ?? "20–50 ml")
    }

    var body: some View {
        ZStack {
            Color("sheet").ignoresSafeArea()

            VStack(spacing: 25) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .frame(width: 42, height: 42)
                            .background(Color.black.opacity(0.25))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text(editingPlant == nil ? "Set Reminder" : "Edit Plant")
                        .font(.title3.bold())
                        .foregroundColor(.white)

                    Spacer()

                    Button(action: {
                        let newPlant = Plant(
                            name: plantName.isEmpty ? "Pothos" : plantName,
                            room: selectedRoom,
                            light: selectedLight,
                            water: selectedWater,
                            watering: selectedWatering
                        )
                        viewModel.addOrUpdatePlant(newPlant, editingPlant: editingPlant)
                        dismiss()
                        onDone()
                    }) {
                        Image(systemName: "checkmark")
                            .foregroundColor(.white)
                            .frame(width: 42, height: 42)
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 25)

                VStack(spacing: 45) {
                    // Plant Name
                    HStack(spacing: 20) {
                        Text("Plant Name").foregroundColor(.white)
                        ZStack(alignment: .leading) {
                            if plantName.isEmpty { Text("Pothos").foregroundColor(.white.opacity(0.5)) }
                            TextField("", text: $plantName).foregroundColor(.white.opacity(0.8))
                        }
                    }
                    .padding()
                    .frame(height: 60)
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(30)
                    .padding(.horizontal, 20)

                    // Room, Light
                    VStack(spacing: 10) {
                        HStack {
                            Label("Room", systemImage: "paperplane").foregroundColor(.white)
                            Spacer()
                            Menu {
                                ForEach(rooms, id: \.self) { room in
                                    Button(room) { selectedRoom = room }
                                }
                            } label: {
                                HStack(spacing: 5) {
                                    Text(selectedRoom).foregroundColor(.white.opacity(0.8))
                                    Image(systemName: "chevron.up.chevron.down")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.white.opacity(0.7))
                                }
                            }
                        }
                        Divider().background(Color.white.opacity(0.2))
                        HStack {
                            Label("Light", systemImage: "sun.max").foregroundColor(.white)
                            Spacer()
                            Menu {
                                ForEach(lights, id: \.self) { light in
                                    Button(light) { selectedLight = light }
                                }
                            } label: {
                                HStack(spacing: 5) {
                                    Text(selectedLight).foregroundColor(.white.opacity(0.8))
                                    Image(systemName: "chevron.up.chevron.down")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.white.opacity(0.7))
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(height: 95)
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(30)
                    .padding(.horizontal, 20)

                    // Watering Days, Water
                    VStack(spacing: 10) {
                        HStack {
                            Label("Watering Days", systemImage: "drop").foregroundColor(.white)
                            Spacer()
                            Menu {
                                ForEach(wateringDays, id: \.self) { day in
                                    Button(day) { selectedWatering = day }
                                }
                            } label: {
                                HStack(spacing: 5) {
                                    Text(selectedWatering).foregroundColor(.white.opacity(0.8))
                                    Image(systemName: "chevron.up.chevron.down")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.white.opacity(0.7))
                                }
                            }
                        }
                        Divider().background(Color.white.opacity(0.2))
                        HStack {
                            Label("Water", systemImage: "drop").foregroundColor(.white)
                            Spacer()
                            Menu {
                                ForEach(waterAmounts, id: \.self) { amount in
                                    Button(amount) { selectedWater = amount }
                                }
                            } label: {
                                HStack(spacing: 5) {
                                    Text(selectedWater).foregroundColor(.white.opacity(0.8))
                                    Image(systemName: "chevron.up.chevron.down")
                                        .font(.system(size: 10, weight: .bold))
                                        .foregroundColor(.white.opacity(0.7))
                                }
                            }
                        }
                    }
                    .padding()
                    .frame(height: 95)
                    .background(Color.white.opacity(0.05))
                    .cornerRadius(30)
                    .padding(.horizontal, 20)

                    // Delete button
                    if let editingPlant {
                        Button(role: .destructive) {
                            if let index = viewModel.plants.firstIndex(where: { $0.id == editingPlant.id }) {
                                viewModel.plants.remove(at: index)
                            }
                            dismiss()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.white.opacity(0.05))
                                    .frame(height: 60)
                                Text("Delete Reminder")
                                    .foregroundColor(.red)
                                    .font(.system(size: 18, weight: .medium))
                            }
                            .padding(.horizontal, 20)
                        }
                    }
                }

                Spacer()
            }
        }
    }
}
