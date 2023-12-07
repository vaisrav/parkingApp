import SwiftUI
import Firebase
import FirebaseFirestore

struct EditParkingView: View {
    var parking: Parking
    
    @State private var buildingCode = ""
    @State private var carLicensePlate = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Parking Details")) {
                    TextField("Building Code", text: $buildingCode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onAppear {
                            buildingCode = parking.buildingCode
                        }
                    TextField("Car License Plate", text: $carLicensePlate)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onAppear {
                            carLicensePlate = parking.carLicensePlate
                        }
                }
                
                Button("Update") {
                    updateParking()
                }
            }
            .navigationTitle("Edit Parking")
        }
    }
    
    func updateParking() {
        guard let parkingId = parking.id else { return }
        
        let parkingData: [String: Any] = [
            "buildingCode": buildingCode,
            "carLicensePlate": carLicensePlate
        ]
        
        Firestore.firestore().collection("parkings").document(parkingId).updateData(parkingData) { error in
            if let error = error {
                print("Failed to update parking data: \(error.localizedDescription)")
            } else {
                print("Parking updated successfully!")
                // Optionally, navigate back to the parking detail view or perform any other action
            }
        }
    }
}

struct EditParkingView_Previews: PreviewProvider {
    static var previews: some View {
        let parking = Parking(id: "1", buildingCode: "ABC12", numberOfHours: 4, carLicensePlate: "XYZ123", hostSuiteNumber: "1234", parkingLocation: "123 Street", dateAndTime: Date(), userId: "user123")
        EditParkingView(parking: parking)
    }
}

