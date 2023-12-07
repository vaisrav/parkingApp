
import SwiftUI

struct ParkingDetailView: View {
    var parking: Parking
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Building Code: \(parking.buildingCode)")
                .font(.headline)
            Text("License Plate: \(parking.carLicensePlate)")
                .font(.subheadline)
            // Add more details as needed
        }
        .padding()
    }
}

struct ParkingDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let parking = Parking(id: "1", buildingCode: "ABC12", numberOfHours: 4, carLicensePlate: "XYZ123", hostSuiteNumber: "1234", parkingLocation: "123 Street", dateAndTime: Date(), userId: "user123")
        ParkingDetailView(parking: parking)
    }
}

