//
//  Our contacts.swift
//  FurnitureBeta
//
//  Created by admin on 16.06.2024.
//

import SwiftUI
import MapKit

struct OurContacts: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 48.9341, longitude: 24.7154),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Our Contacts")
                    .font(.title)
                    .fontWeight(.bold)
                
                Group {
                    Text("For more information, please contact us through any of the following:")
                    HStack {
                        Text("Phone:")
                            .fontWeight(.bold)
                        Text("+38 0342 123 456")
                    }
                    HStack {
                        Text("Email:")
                            .fontWeight(.bold)
                        Text("info@comforthomefurniture.com")
                    }
                    HStack {
                        Text("Address:")
                            .fontWeight(.bold)
                        Text("123 Main Street, Ivano-Frankivsk, Ukraine")
                    }
                    
                    Text("Follow us on social media:")
                    HStack {
                        Link(destination: URL(string: "https://www.facebook.com/comforthomefurniture")!) {
                            Text("Facebook")
                        }
                        .padding(.trailing, 10)
                        
                        Link(destination: URL(string: "https://www.instagram.com/comforthomefurniture")!) {
                            Text("Instagram")
                        }
                        .padding(.trailing, 10)
                        
                        Link(destination: URL(string: "https://www.twitter.com/comforthomefurn")!) {
                            Text("Twitter")
                        }
                    }
                }
                
                Text("Find Us Here:")
                    .font(.title2)
                    .fontWeight(.bold)
                
                Map(coordinateRegion: $region)
                    .frame(height: 300)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}
