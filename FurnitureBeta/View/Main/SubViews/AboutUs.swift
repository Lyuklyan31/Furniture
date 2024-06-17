//
//  About Us.swift
//  FurnitureBeta
//
//  Created by admin on 16.06.2024.
//

import SwiftUI

struct AboutUs: View {
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                Text("About Us")
                    .bold()
                    .font(.title)
                    .padding()
                
                Image("emblem")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(maxWidth: 160, maxHeight: 160)
                    .overlay(
                        Circle()
                            .stroke(Color.primary, lineWidth: 3)
                    )
                
                Text("ComfortHome Furniture")
                    .font(.headline)
                    .bold()
                    .padding(.bottom)
                
                Text("Welcome to ComfortHome Furniture, your premier destination for stylish and high-quality furniture in Ivano-Frankivsk. Our store is dedicated to helping you create the perfect home environment with our extensive range of furniture and decor. From modern to classic designs, we have something to suit every taste and budget")
                    .padding(.horizontal)
                
                HStack {
                    Text("Our Mission")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                        .padding(.leading)
                    Spacer()
                }
                
                Text("At ComfortHome Furniture, our mission is to provide our customers with exceptional products that enhance the beauty and functionality of their homes. We believe that furniture should not only be aesthetically pleasing but also durable and comfortable.")
                    .padding(.horizontal)
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("Our Products")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Group {
                        Text("We offer a wide variety of furniture for every room in your home, including:")
                        
                        HStack {
                            Text("Living Room:")
                                .fontWeight(.bold)
                            Text("Sofas, armchairs, coffee tables, and entertainment units.")
                        }
                        
                        HStack {
                            Text("Bedroom:")
                                .fontWeight(.bold)
                            Text("Beds, wardrobes, nightstands, and dressers.")
                        }
                        
                        HStack {
                            Text("Dining Room:")
                                .fontWeight(.bold)
                            Text("Dining tables, chairs, buffets, and bar stools.")
                        }
                        
                        HStack {
                            Text("Office:")
                                .fontWeight(.bold)
                            Text("Desks, office chairs, and storage solutions.")
                        }
                        
                        HStack {
                            Text("Outdoor:")
                                .fontWeight(.bold)
                            Text("Patio sets, garden chairs, and loungers.")
                        }
                    }
                    
                    Text("Why Choose Us?")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Group {
                        HStack {
                            Text("Quality:")
                                .fontWeight(.bold)
                            Text("We source our products from reputable manufacturers to ensure the highest quality and longevity.")
                        }
                        
                        HStack {
                            Text("Variety:")
                                .fontWeight(.bold)
                            Text("Our diverse selection guarantees you’ll find the perfect piece to complement your home.")
                        }
                        
                        HStack {
                            Text("Customer Service:")
                                .fontWeight(.bold)
                            Text("Our knowledgeable and friendly staff are here to assist you with any questions and help you find the ideal furniture for your needs.")
                        }
                        
                        HStack {
                            Text("Competitive Prices:")
                                .fontWeight(.bold)
                            Text("We offer great value for money with our competitively priced furniture.")
                        }
                    }
                    
                    Text("Visit Us")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("We invite you to visit our store in Ivano-Frankivsk to experience our furniture firsthand. Our showroom is designed to inspire and help you visualize how our pieces can transform your home.")
                    
                    Text("Contact Us")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Group {
                        Text("For more information, please feel free to contact us:")
                        Text("Email: info@comforthomefurniture.com")
                        Text("Phone: +38 0342 123 456")
                    }
                    
                    Text("We look forward to helping you create a comfortable and stylish home with ComfortHome Furniture!")
                }
                .padding()
            }
        }
    }
}
#Preview {
    AboutUs()
}
