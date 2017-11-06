//
//  SavedMoviesViewController.swift
//  Zup
//
//  Created by Victor de Paula on 04/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import UIKit

class SavedMoviesViewController: BaseViewController {
    // MARK: - Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: - Variables
    var moviesSaved : [Movie]?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configView()
        self.tableView.register(UINib(nibName: "movieCell", bundle: nil), forCellReuseIdentifier: "moviesSave")
      
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        moviesSaved = MovieData.sharedInstance.getAllMovies()
        self.tableView.reloadData()
        self.tabBarController?.setTabBarVisible(visible: true, animated: false)
    }
    
    // MARK: - Misc
    func configView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.searchBar.delegate = self
    }
    
}


// MARK: - UITableViewDelegate
extension SavedMoviesViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let movie = self.moviesSaved?[indexPath.row] {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
                vc.verifyWhereIsComming = true
                vc.movie = movie
                self.tabBarController?.setTabBarVisible(visible: false, animated: true)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if  let valueMovie = self.moviesSaved?[indexPath.row] {
            if editingStyle == .delete
            {
                self.moviesSaved?.remove(at: indexPath.row)
                if MovieData.sharedInstance.removeMovie(currentUserID: valueMovie.id) ?? false {
                    self.showAlert(title: "Atenção", message: "Filme removido com sucesso!!")
                }else {
                    self.showAlert(title: "Atenção", message: "Ocorreu um erro ao remover o filme selecionado!")
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchBar.endEditing(true)
    }
}

// MARK: - UITableViewDataSource
extension SavedMoviesViewController :  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesSaved?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let movie = self.moviesSaved?[indexPath.row]{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "moviesSave", for: indexPath) as? MoviesSavedTableViewCell {
                cell.configCell(nameMovie: movie.title ?? "", imageBase64: movie.moviedata!)
                return cell
            }
        }
        return UITableViewCell()
    }
}

// MARK: - UISearchBarDelegate
extension SavedMoviesViewController : UISearchBarDelegate, UISearchDisplayDelegate {
    func filterContent(forSearchText searchText: String) {
        //if !searchText.isEmpty {
        let resultPredicate = NSPredicate(format: "title contains[c] %@", searchText)
        let searchResults: [Movie] = ((self.moviesSaved as NSArray?)?.filtered(using: resultPredicate) as? [Movie]) ?? [Movie]()
        self.moviesSaved?.removeAll()
        self.moviesSaved = searchResults
        self.tableView.reloadData()
    }
    
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let textinSearch = searchBar.text {
            let newString = NSString(string:  textinSearch).replacingCharacters(in: range, with: text)
            if newString.count > 0 {
                self.filterContent(forSearchText: newString)
            }else{
                self.moviesSaved = MovieData.sharedInstance.getAllMovies()
            }
            self.tableView.reloadData()
        }
        return true
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
}
