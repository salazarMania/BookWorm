//
//  AddBookView.swift
//  BookWorm
//
//  Created by SANIYA KHATARKAR on 24/07/24.
//

import SwiftUI

struct AddBookView :View{
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror","Mystery" ,"Romance","Poetry", "Kids","Thriller"]
    
    var body: some View{
        NavigationView {
            Form {
                Section {
                    TextField("Name of the book" , text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre){
                        ForEach(genres , id: \.self){
                            Text($0)
                        }
                        
                    }
                }
                
                Section {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                    }
                header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.id = UUID()
                        newBook.title = title
                        newBook.author = author
                        newBook.rating =  Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        
                        try? moc.save()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
}

struct AddBookView_Preview : PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}


