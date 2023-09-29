//
//  UsersListViewModel.swift
//  Brainstromtech Task
//
//  Created by Diana Sargsyan on 18.08.23.
//

import Foundation

class UsersListViewModel: ObservableObject {
    
    @Published var listOptions = ListSegmentOptions.allCases
    @Published var segmentationSelection: ListSegmentOptions = .receiving {
        didSet {
            getSavedUsers()
        }
    }
    
    // MARK: Configuration
    private let itemsFromEndThreshold = 5
    
    // MARK: Pagination data
    private var totalItemsAvailable: Int = 500
    private var itemsLoadedCount: Int?
    private var page = 0
    
    // MARK: Output
    @Published var currentUsers: [Result] = []
    @Published var savedUsers: [SavedUserModel] = []
    @Published var dataIsLoading = false
    
    init () {
        SQLliteDBContactsHandler.sharedInstance.createTable()
        getSavedUsers()
        requestInitialSetOfItems()
    }
    
    func requestInitialSetOfItems() {
        page = 0
        requestItems(page: page)
    }
    
    func requestMoreItemsIfNeeded(index: Int) {
        guard let itemsLoadedCount = itemsLoadedCount else {
            return
        }
        
        if thresholdMeet(itemsLoadedCount, index) &&
            moreItemsRemaining(itemsLoadedCount, totalItemsAvailable) {
            // Request next page
            page += 1
            requestItems(page: page)
        }
    }
    
    private func thresholdMeet(_ itemsLoadedCount: Int, _ index: Int) -> Bool {
        print("page:", itemsLoadedCount - index, "index:", index, itemsLoadedCount)
        return (itemsLoadedCount - index) == itemsFromEndThreshold
    }
    
    private func moreItemsRemaining(_ itemsLoadedCount: Int, _ totalItemsAvailable: Int) -> Bool {
        return itemsLoadedCount < totalItemsAvailable
    }
    
    private func requestItems(page: Int) {
        if !dataIsLoading {
            dataIsLoading = true
            NetworkingManager.sharedManager.getBrainstormUsers(page: page) { [weak self] info in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    if let resopnse = info {
                        self.currentUsers.append(contentsOf: resopnse.results)
                        self.itemsLoadedCount = self.currentUsers.count
                        self.dataIsLoading = false
                        self.objectWillChange.send()
                    } else {
                        
                    }
                }
            }
        }
    }
    
    func getSavedUsers() {
        savedUsers = SQLliteDBContactsHandler.sharedInstance.getItemListFromDB()
    }
}
