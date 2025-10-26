//
//  Untitled 4.swift
//  plants
//
//  Created by noura on 22/10/2025.
//

import SwiftUI

struct TodayReminder: View {
    @Binding var plants: [Plant]
    @State private var selectedPlants: Set<UUID> = []
    @State private var showAddPlantSheet = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color(.black).ignoresSafeArea()

            VStack(spacing: 16) {
                // الشريط العلوي
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

                // ProgressView
                VStack(spacing: 8) {
                    Text("Your plants are waiting for a sip 💦")
                        .font(.system(size: 18))
                        .foregroundColor(.white)

                    ProgressView(value: plants.isEmpty ? 0 : Double(selectedPlants.count) / Double(plants.count))
                        .progressViewStyle(.linear)
                        .tint(Color("cyan"))
                        .frame(height: 10)
                        .background(Color(.systemGray5))
                        .cornerRadius(4)
                        .padding(.horizontal, 20)
                }

                // قائمة النباتات
                List {
                    ForEach(plants) { plant in
                        HStack(spacing: 12) {
                            // زر التشيك
                            Button(action: {
                                if selectedPlants.contains(plant.id) {
                                    selectedPlants.remove(plant.id)
                                } else {
                                    selectedPlants.insert(plant.id)
                                }
                            }) {
                                Image(systemName: selectedPlants.contains(plant.id) ? "checkmark.circle.fill" : "circle")
                                    .resizable()
                                    .frame(width: 32, height: 32)
                                    .foregroundColor(selectedPlants.contains(plant.id) ? .cyan : .gray)
                            }

                            // محتوى البطاقة - محاذاة لليسار
                            VStack(alignment: .leading, spacing: 8) {
                                // مكان النبتة فوق الاسم
                                Text(plant.room)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.gray)

                                // اسم النبتة
                                Text(plant.name)
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)

                                // Sun + Water تحت الاسم
                                HStack(spacing: 30) {
                                    HStack(spacing: 5) {
                                        Image(systemName: "sun.max.fill")
                                            .foregroundColor(.yellow)
                                        Text(plant.light)
                                            .foregroundColor(.white)
                                    }

                                    HStack(spacing: 5) {
                                        Image(systemName: "drop.fill")
                                            .foregroundColor(.cyan)
                                        Text(plant.water)
                                            .foregroundColor(.white)
                                    }
                                }
                                .font(.system(size: 16))
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white.opacity(0.05))
                            .cornerRadius(20)
                        }
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                if let index = plants.firstIndex(where: { $0.id == plant.id }) {
                                    plants.remove(at: index)
                                    selectedPlants.remove(plant.id)
                                }
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
            }

            // زر إضافة نبتة
            Button(action: { showAddPlantSheet.toggle() }) {
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
                SheetView(plants: $plants)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TodayReminder(plants: .constant([]))
}
