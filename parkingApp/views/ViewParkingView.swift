//
//  ViewParkingView.swift
//  parkingApp
//
//  Created by Graphic on 2023-06-24.
//

import SwiftUI

struct ViewParkingView: View {
    @StateObject private var parkingListVM = ParkingListViewModel()
    @State private var showDeleteConfirmation = false
    @State private var selectedParkingId: String?

    var body: some View {
        NavigationView {
            List(parkingListVM.parkingList) { parking in
                NavigationLink(destination: ParkingDetailView(parking: parking)) {
                    VStack(alignment: .leading) {
                        Text("Building Code: \(parking.buildingCode)")
                            .font(.headline)
                        Text("License Plate: \(parking.carLicensePlate)")
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Parking List")
            .onAppear {
                parkingListVM.fetchParkingList()
            }
            .actionSheet(isPresented: $showDeleteConfirmation) {
                ActionSheet(
                    title: Text("Delete Parking"),
                    message: Text("Are you sure you want to delete this parking?"),
                    buttons: [
                        .destructive(Text("Delete"), action: {
                            guard let parkingId = selectedParkingId else { return }
                            parkingListVM.deleteParking(parkingId: parkingId)
                        }),
                        .cancel()
                    ]
                )
            }
        }
    }
}

struct ViewParkingView_Previews: PreviewProvider {
    static var previews: some View {
        ViewParkingView()
    }
}
