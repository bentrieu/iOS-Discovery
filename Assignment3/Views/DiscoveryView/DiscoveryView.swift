////
////  DiscoveryView.swift
////  Assignment3
////
////  Created by DuyNguyen on 18/09/2023.
////
//
//import SwiftUI
//
//struct DiscoveryView: View {
//    
//    @State var searchActive = false
//    @State var searchInput = ""
//    
//    private var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]
//    var body: some View {
//        ZStack{
//            Color("white")
//            NavigationView {
//                VStack{
//                    
//                    HStack{
//                        //MARK: - HEADER
//                        Text("Discovery")
//                            .font(.custom("Gotham-Black", size: 40))
//                            .modifier(BlackColor())
//                        Spacer()
//                    }
//                    .frame(height: searchActive ? 0 : nil)
//                    .opacity(searchActive ? 0 : 1)
//                    .padding(.bottom, searchActive ? -5 : 5)
//
//                    
//                    
//                    HStack{
//                        //MARK: - SEARCH BAR BUTTON
//                        SearchBarView(searchInput: $searchInput, prompt: "Search Tracks")
//                            .onTapGesture {
//                                withAnimation {
//                                    searchActive = true
//                                }
//                            }
//                        //MARK: - CANCEL SEARCH
//                        Button{
//                            withAnimation {
//                                searchActive = false
//                            }
//                            //remove focus on search bar when tap on other views
//                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
//                        }label: {
//                            Text("Cancel")
//                                .font(.custom("Gotham-Medium", size: 18))
//                                .modifier(BlackColor())
//                        }
//                        .frame(width: searchActive ? nil : 0, height: searchActive ? nil : 0)
//                        .opacity(searchActive ? 1 : 0)
//                        .disabled(!searchActive)
//                    }
//
//                    HStack{
//                        Text("Browse all")
//                            .font(.custom("Gotham-Medium", size: 20))
//                            .modifier(BlackColor())
//                        Spacer()
//                    }
//                    .padding(.top, searchActive ? 0 : 20)
//                    .frame(height: searchActive ? 0 : nil)
//                    .opacity(searchActive ? 0 : 1)
//                    .offset(y: searchActive ? 30 : 0)
//                    
//                    //MARK: - GENRE LIST
//                    LazyVGrid(columns: gridItemLayout){
//                        //for each
//                        NavigationLink {
//                            GenreView(genre: "K-pop", color: .blue)
//                        } label: {
//                            GenreCardView(genre: "K-pop", color: .blue)
//                                
//                        }
//                        
//                        NavigationLink {
//                            GenreView(genre: "Hip-Hop", color: .green)
//                        } label: {
//                            GenreCardView(genre: "Hip-Hop", color: .green)
//                                
//                        }
//                    }
//                    .frame(height: searchActive ? 0 : nil)
//                    .opacity(searchActive ? 0 : 1)
//                    .disabled(searchActive)
//                    .offset(y: searchActive ? 100 : 0)
//                    
//                    //MARK: - SEARCH LIST
//                    List{
//                        Button{
//                            
//                        }label: {
//                            ListRowView(imgName: "testImg",imgDimens: 60, title: "Song Name", titleSize: 23, subTitle: "Artists", subTitleSize: 20)
//                        }
//                        .listRowInsets(.init(top: -5, leading: 0, bottom: 5, trailing: 0))
//                        .listRowBackground(Color.clear)
//                        .listRowSeparator(.hidden)
//                        
//                    }
//                    .listStyle(PlainListStyle())
//                    .frame(height: searchActive ? nil : 0)
//                    .opacity(searchActive ? 1 : 0)
//                    .disabled(!searchActive)
//                    
//                    Spacer()
//                }.modifier(PagePadding())
//            }
//            
//            
//        }
//    }
//}
//
//struct GenreCardView: View{
//    let genre: String
//    let color: Color
//    
//    var body: some View{
//        ZStack{
//            color
//            Text(genre)
//                .font(.custom("Gotham-Black", size: 20))
//                .modifier(BlackColor())
//        }
//        .cornerRadius(15)
//        .frame(width: 170, height: 100)
//    }
//}
//
//struct DiscoveryView_Previews: PreviewProvider {
//    static var previews: some View {
//        DiscoveryView()
//    }
//}
