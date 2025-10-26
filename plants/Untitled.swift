//
//  Untitled.swift
//  plants
//
//  Created by noura on 20/10/2025.
//
import SwiftUI
import UserNotifications

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var plants: [Plant]

    @State private var plantName = ""
    @State private var selectedRoom = "Bedroom"
    @State private var selectedLight = "Full sun"
    @State private var selectedWatering = "Every day"
    @State private var selectedWater = "20–50 ml"

    let rooms = ["Bedroom", "Living Room", "Kitchen", "Balcony", "Bathroom"]
    let lights = ["Full sun", "Partial sun", "Low light"]
    let wateringDays = ["Every day", "Every 2 days", "Every 3 days", "Once a week", "Every 10 days", "Every 2 weeks"]
    let waterAmounts = ["20–50 ml", "50–100 ml", "100–200 ml", "200–300 ml"]

    @State private var goToToday = false
    @State private var testMode = true // لتجربة الإشعار السريع

    var body: some View {
        NavigationStack {
            ZStack {
                Color("sheet").ignoresSafeArea()

                VStack(spacing: 25) {
                    // الشريط العلوي
                    HStack {
                        Button(action: { dismiss() }) {
                            Image(systemName: "xmark")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .frame(width: 42, height: 42)
                                .background(Color.black.opacity(0.25))
                                .clipShape(Circle())
                        }

                        Spacer()

                        Text("Set Reminder")
                            .font(.title3.bold())
                            .foregroundColor(.white)

                        Spacer()

                        Button(action: {
                            // إنشاء نبتة جديدة
                            let newPlant = Plant(
                                name: plantName.isEmpty ? "Pothos" : plantName,
                                room: selectedRoom,
                                light: selectedLight,
                                water: selectedWater,
                                watering: selectedWatering,
                                lastWatered: nil
                            )

                            // إضافة النبتة للقائمة
                            plants.append(newPlant)

                            // طلب إذن الإشعارات وجدولة الإشعار
                            NotificationManager.shared.requestPermission()
                            NotificationManager.shared.scheduleNotification(for: newPlant, testMode: testMode)

                            goToToday = true
                        }) {
                            Image(systemName: "checkmark")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                                .frame(width: 42, height: 42)
                                .background(Color.green)
                                .clipShape(Circle())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 25)

                    Spacer().frame(height: 15)

                    // المحتوى
                    VStack(spacing: 45) {
                        // Plant Name
                        HStack(spacing: 20) {
                            Text("Plant Name")
                                .foregroundColor(.white)

                            ZStack(alignment: .leading) {
                                if plantName.isEmpty {
                                    Text("Pothos")
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                TextField("", text: $plantName)
                                    .foregroundColor(.white.opacity(0.8))
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding()
                        .frame(height: 60)
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(30)
                        .padding(.horizontal, 20)

                        // Room & Light
                        VStack(spacing: 10) {
                            HStack {
                                Label("Room", systemImage: "paperplane")
                                    .foregroundColor(.white)
                                Spacer()
                                Menu {
                                    ForEach(rooms, id: \.self) { room in
                                        Button(room) { selectedRoom = room }
                                    }
                                } label: {
                                    HStack {
                                        Text(selectedRoom)
                                        Image(systemName: "chevron.down")
                                    }
                                    .foregroundColor(.white.opacity(0.8))
                                }
                            }
                            Divider().background(Color.white.opacity(0.2))
                            HStack {
                                Label("Light", systemImage: "sun.max")
                                    .foregroundColor(.white)
                                Spacer()
                                Menu {
                                    ForEach(lights, id: \.self) { light in
                                        Button(light) { selectedLight = light }
                                    }
                                } label: {
                                    HStack {
                                        Text(selectedLight)
                                        Image(systemName: "chevron.down")
                                    }
                                    .foregroundColor(.white.opacity(0.8))
                                }
                            }
                        }
                        .padding()
                        .frame(height: 95)
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(30)
                        .padding(.horizontal, 20)

                        // Watering Days & Water
                        VStack(spacing: 10) {
                            HStack {
                                Label("Watering Days", systemImage: "drop")
                                    .foregroundColor(.white)
                                Spacer()
                                Menu {
                                    ForEach(wateringDays, id: \.self) { day in
                                        Button(day) { selectedWatering = day }
                                    }
                                } label: {
                                    HStack {
                                        Text(selectedWatering)
                                        Image(systemName: "chevron.down")
                                    }
                                    .foregroundColor(.white.opacity(0.8))
                                }
                            }
                            Divider().background(Color.white.opacity(0.2))
                            HStack {
                                Label("Water", systemImage: "drop.fill")
                                    .foregroundColor(.white)
                                Spacer()
                                Menu {
                                    ForEach(waterAmounts, id: \.self) { amount in
                                        Button(amount) { selectedWater = amount }
                                    }
                                } label: {
                                    HStack {
                                        Text(selectedWater)
                                        Image(systemName: "chevron.down")
                                    }
                                    .foregroundColor(.white.opacity(0.8))
                                }
                            }
                        }
                        .padding()
                        .frame(height: 95)
                        .background(Color.white.opacity(0.05))
                        .cornerRadius(30)
                        .padding(.horizontal, 20)
                    }

                    Spacer()

                    NavigationLink("", destination: TodayReminder(plants: $plants), isActive: $goToToday)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

#Preview {
    SheetView(plants: .constant([]))
}
