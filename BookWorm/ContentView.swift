//
//  ContentView.swift
//  BookWorm
//
//  Created by SANIYA KHATARKAR on 24/07/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books : FetchedResults<Book>
    
    @State private var showingAddScreen = false
    //made for showing sheets
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach (books) {
                    book in
                    NavigationLink {
                        DetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating : book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text (book.title ?? "Unknown Title")
                                    .font(.headline)
                                
                                Text (book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("Bookworm")
                .toolbar{
                    ToolbarItem(placement: .navigationBarLeading){
                        EditButton()
                    }
                }
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button{
                            showingAddScreen.toggle()
                        } label: {
                            Label("Add Book", systemImage: "plus")
                        }
                    }
                }
                .sheet(isPresented: $showingAddScreen){
                    AddBookView()
                }
        }
    }
    
    func deleteBooks(at offsets: IndexSet){
        for offset in offsets {//looping over every offset
            
            let book = books[offset]
            moc.delete(book)
        }
        
        try? moc.save()
        //writes changes out to persistent storage
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
