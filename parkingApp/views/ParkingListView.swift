import SwiftUI
import Firebase
import FirebaseFirestore

struct ParkingListView: View {
    @State private var parkingRecords: [ParkingRecord] = []
    
    var body: some View {
        NavigationView {
            List(parkingRecords, id: \.id) { record in
                NavigationLink(destination: ParkingDetail(record: record)) {
                    VStack(alignment: .leading) {
                        Text("Building Code: \(record.buildingCode)")
                        Text("Hours to Park: \(record.hoursToPark)")
                    }
                }
            }
            .navigationTitle("Parking List")
            .onAppear {
                fetchParkingRecords()
            }
        }
    }
    
    func fetchParkingRecords() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(userId).collection("parking").addSnapshotListener { snapshot, error in
            if let error = error {
                print("Failed to fetch parking records: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            parkingRecords = documents.compactMap { document in
                let data = document.data()
                let id = document.documentID
                
                if let buildingCode = data["buildingCode"] as? String,
                   let hoursToPark = data["hoursToPark"] as? Int,
                   let carPlateNumber = data["carPlateNumber"] as? String,
                   let suitNumber = data["suitNumber"] as? String,
                   let parkingLocation = data["parkingLocation"] as? String {
                    
                    return ParkingRecord(id: id, buildingCode: buildingCode, hoursToPark: hoursToPark, carPlateNumber: carPlateNumber, suitNumber: suitNumber, parkingLocation: parkingLocation)
                } else {
                    return nil
                }
            }
        }
    }
    
    func deleteParking(parkingId: String) {
        Firestore.firestore().collection("parkings").document(parkingId).delete { error in
            if let error = error {
                print("Failed to delete parking data: \(error.localizedDescription)")
            } else {
                print("Parking deleted successfully!")
                // Optionally, perform any other action after deleting the parking
            }
        }
    }

}

struct ParkingListView_Previews: PreviewProvider {
    static var previews: some View {
        ParkingListView()
    }
}

struct ParkingRecord: Identifiable {
    let id: String
    let buildingCode: String
    let hoursToPark: Int
    let carPlateNumber: String
    let suitNumber: String
    let parkingLocation: String
}

struct ParkingDetail: View {
    let record: ParkingRecord
    
    @State private var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Building Code: \(record.buildingCode)")
            Text("Hours to Park: \(record.hoursToPark)")
            Text("Car Plate Number: \(record.carPlateNumber)")
            Text("Suit Number: \(record.suitNumber)")
            Text("Parking Location: \(record.parkingLocation)")
        }
        .padding()
        .navigationTitle("Parking Detail")
        .toolbar {
            Button(action: {
                showAlert = true
            }) {
                Image(systemName: "trash")
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Delete Parking Record"),
                message: Text("Are you sure you want to delete this parking record?"),
                primaryButton: .destructive(Text("Delete"), action: deleteRecord),
                secondaryButton: .cancel()
            )
        }
    }
    
    func deleteRecord() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(userId).collection("parking").document(record.id).delete { error in
            if let error = error {
                print("Failed to delete record: \(error.localizedDescription)")
            } else {
                print("Record deleted successfully!")
            }
        }
    }
}

