//
//  UserCardView.swift
//  eBuddySwiftUIMVVMFirebaseApp
//
//  Created by Chandra Welim on 10/12/24.
//

import SwiftUI

struct UserCardView: View {
    var name: String
    var rating: Double
    var reviewsCount: Int
    var price: Double
    var imageURL: String
    var isAvailable: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(name)
                
                /// Green doots
                
                Spacer()
                /// Verified
                Image(systemName: "star.fill")
                /// IG
                Image(systemName: "star.fill")
            }
            
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: URL(string: imageURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    Color.gray.opacity(0.3)
                }
                .frame(height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.white, lineWidth: 2))
                
                if isAvailable {
                    HStack {
                        Text("⚡ Available today!")
                            .font(.subheadline.bold())
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color("AvailabilityBackground"))
                            .cornerRadius(15)
                        Spacer()
                    }
                }
            }
            
            HStack {
                Circle()
                    .frame(width: 20, height: 20)
                Circle()
                    .frame(width: 20, height: 20)
                
                Spacer()
                
                Circle()
                    .frame(width: 20, height: 20)
            }
            
            HStack {
                Text("⭐️")
                Text(String(rating))
                Text("(\(String(reviewsCount)))")
                Spacer()
            }
            
            HStack {
                Text("🔥")
                Text(String(price))
                Text("/1Hr")
                Spacer()
            }
        }
        .frame(width: 200, height: 300)
    }
}

// Preview with light and dark modes
struct UserCardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UserCardView(
                name: "Zynx",
                rating: 4.9,
                reviewsCount: 61,
                price: 110.0,
                imageURL: "https://example.com/image.jpg",
                isAvailable: true
            )
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.light)
            
            UserCardView(
                name: "Zynx",
                rating: 4.9,
                reviewsCount: 61,
                price: 110.0,
                imageURL: "https://example.com/image.jpg",
                isAvailable: true
            )
            .previewLayout(.sizeThatFits)
            .preferredColorScheme(.dark)
        }
    }
}

