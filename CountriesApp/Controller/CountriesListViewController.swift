    //
//  CountriesListViewController.swift
//  CountriesApp
//
//  Created by Maksim Torburg on 25.04.2020.
//  Copyright © 2020 Maksim Torburg. All rights reserved.
//

import UIKit

class CountriesListViewController: UIViewController {

    @IBOutlet weak var countriesList: UITableView!
    
    private var viewModel: CountriesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Countries"
        countriesList.register(UINib(nibName: "CountryViewCell", bundle: .main), forCellReuseIdentifier: CountryViewCell.reuseIdentifier)
        countriesList.prefetchDataSource = self
        viewModel = CountriesViewModel(with: self)
        viewModel.fetchCountries()
    }
}

extension CountriesListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countries.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dequedCell = countriesList.dequeueReusableCell(withIdentifier: CountryViewCell.reuseIdentifier, for: indexPath)

        guard let cell = dequedCell as? CountryViewCell else {
            print("Can't create reusable Cell in TableView")
            return dequedCell
        }
        let country = viewModel.countries[indexPath.row]
        cell.fill(with: country)
    
        return cell
    }
}

extension CountriesListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {

        viewModel.fetchCountries()
        if indexPaths.contains(where: isLoadingCell) {
            print("done")
        }
    }
}

extension CountriesListViewController: CountriesViewModelDelegate {
    func fetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        guard let newIndexPathsToReload = newIndexPathsToReload,
            let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload),
            !indexPathsToReload.isEmpty else {
                countriesList.reloadData()
                return
        }
        countriesList.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    func fetchFailed() {
        
    }
}

extension CountriesListViewController {

    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.countries.count
    }

    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath]? {
        let indexPathsForVisibleRows = countriesList.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
