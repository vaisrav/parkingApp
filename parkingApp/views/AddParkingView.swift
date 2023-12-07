import SwiftUI
import Firebase
import FirebaseFirestore

struct AddParkingView: View {
    @State private var buildingCode = ""
    @State private var hoursOfParking = ""
    @State private var carLicensePlate = ""
    @State private var hostSuiteNumber = ""
    @State private var parkingLocation = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Parking Details")) {
                    TextField("Building Code", text: $buildingCode)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Hours of Parking", text: $hoursOfParking)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Car License Plate", text: $carLicensePlate)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Host Suite Number", text: $hostSuiteNumber)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Parking Location", text: $parkingLocation)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                Button("Save") {
                    addParking()
                }
            }
            .navigationTitle("Add Parking")
        }
    }
    
    func addParking() {
        let parkingData: [String: Any] = [
            "buildingCode": buildingCode,
            "hoursOfParking": hoursOfParking,
            "carLicensePlate": carLicensePlate,
            "hostSuiteNumber": hostSuiteNumber,
            "parkingLocation": parkingLocation,
            "dateTime": Date()
        ]
        
        Firestore.firestore().collection("parkings").addDocument(data: parkingData) { error in
            if let error = error {
                print("Failed to save parking data: \(error.localizedDescription)")
            } else {
                print("Parking added successfully!")
                // Optionally, navigate to the parking list view or perform any other action
            }
        }
    }
}

struct AddParkingView_Previews: PreviewProvider {
    static var previews: some View {
        AddParkingView()
    }
}
