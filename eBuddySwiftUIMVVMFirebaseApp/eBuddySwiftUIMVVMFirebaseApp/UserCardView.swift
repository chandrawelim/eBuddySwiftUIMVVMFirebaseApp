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
                    .foregroundStyle(.textPrimary)
                
                Image("ic_green_dots")
                
                Spacer()
                
                Image("ic_verified")
                
                Image("ic_instagram")
            }
            .padding(.horizontal, 4)
            
            ZStack(alignment: .topTrailing) {
                Image("ic_people")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 158, height: 180)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 1))
                
                if isAvailable {
                    HStack {
                        Image("ic_pill")
                            .padding(.leading, 8)
                            .padding(.top, 12)
                        Spacer()
                    }
                }
            }
            
            HStack(spacing: -8) {
                Image("ic_cod")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40)
                    .clipShape(Circle())
                
                ZStack {
                    Image("ic_mobile_legend")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color.textSecondary, lineWidth: 1)
                        )
                    
                    Circle()
                        .fill(Color.textPrimary.opacity(0.3))
                        .frame(width: 40, height: 40)
                    
                    Text("+3")
                        .foregroundStyle(.textSecondary)
                }
                
                Spacer()
                
                Image("ic_voice")
            }
            .padding(.top, -30)
            .padding(.horizontal, 8)
            
            HStack(spacing: 4) {
                Image("ic_star")
                Text(String(rating))
                    .foregroundStyle(.textPrimary)
                Text("(\(String(reviewsCount)))")
                    .foregroundStyle(.tertitary)
                Spacer()
            }
            
            HStack(spacing: 4) {
                Image("ic_mana")
                HStack(spacing: 0) {
                    Text(String(price))
                        .foregroundStyle(.textPrimary)
                    Text("/1Hr")
                        .foregroundStyle(.textPrimary)
                }
                Spacer()
            }
        }
        .frame(width: 158, height: 312)
        .padding(.horizontal, 4)
        .padding(.vertical, 8)
        .background(.bgCardNetral)
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

