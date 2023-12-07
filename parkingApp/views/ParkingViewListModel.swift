//
//  ParkingViewListModel.swift
//  parkingApp
//
//  Created by Graphic on 2023-06-24.
//
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


class ParkingListViewModel: ObservableObject {
    @Published var parkingList: [Parking] = []

    private var db = Firestore.firestore()

    func fetchParkingList() {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        db.collection("parkings")
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error fetching parking list: \(error.localizedDescription)")
                    return
                }

                guard let documents = querySnapshot?.documents else {
                    print("No documents found")
                    return
                }

                self.parkingList = documents.compactMap { document in
                    try? document.data(as: Parking.self) as Parking
                }
            }
    }

    func deleteParking(parkingId: String) {
        db.collection("parkings").document(parkingId).delete { error in
            if let error = error {
                print("Failed to delete parking data: \(error.localizedDescription)")
            } else {
                print("Parking deleted successfully!")
            }
        }
    }
}

struct ParkingViewListModel_Previews: PreviewProvider {
    static var previews: some View {
        Text("Placeholder")
    }
}

