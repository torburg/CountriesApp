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

extension CountriesListViewController: CountriesViewModelDelegate {
    func fetchCompleted() {
        countriesList.reloadData()
    }
    
    func fetchFailed() {
        
    }
}
