//
//  StarRating.swift
//  futzin
//
//  Created by Kelven Galvao on 11/06/23.
//

import SwiftUI

struct StarRating: View {
    @Binding var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        rating = index
                    }
            }
        }
    }
}

struct StaticStarRating: View {
    var rating: Int
    
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.yellow)
            }
        }
    }
}

struct StarRating_Previews: PreviewProvider {
    @State static var rating: Int = 4
    
    static var previews: some View {
        StarRating(rating: $rating)
    }
}
