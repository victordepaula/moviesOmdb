//
//  ViewController.swift
//  Zup
//
//  Created by Victor de Paula on 01/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import UIKit
import SDWebImage
import ScalingCarousel

class HomeViewController: BaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var carousel: ScalingCarouselView!
    @IBOutlet weak var mySearchBox: UISearchBar!
    
    // MARK: - Variables
    
    var movieDataSource: MovieDataSource = MovieDataSource()
    var moviesResponse: MoviesResponse = MoviesResponse()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set Delegates
        carousel.register(UINib.init(nibName: "cardMovie", bundle: Bundle.main), forCellWithReuseIdentifier: "cardMovieCell")
        
        self.configView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.setTabBarVisible(visible: true, animated: false)
    }
    
    // MARK: - Misc
    
    func configView() {
        self.mySearchBox.delegate = self
        self.movieDataSource.dataSourceDelegate = self
    }
}

// MARK: - UICollectionViewDataSource

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.moviesResponse.movies?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = self.moviesResponse.movies?[indexPath.row] {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
                vc.imdbId = movie.imdbID
                self.tabBarController?.setTabBarVisible(visible: false, animated: true)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardMovieCell", for: indexPath)
        if let movie = self.moviesResponse.movies?[indexPath.row] {
            if let scalingCell = cell as? CardMovieCollectionViewCell {
                if let movieImage = movie.posterMovie {
                    if movieImage != "N/A" {
                        scalingCell.imageTest.sd_setImage(with: URL(string : movieImage), completed: nil)
                        scalingCell.movieName.text = movie.title
                    }else {
                        scalingCell.imageTest.image = UIImage(named: "indisponible")
                    }
                }
            }
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension HomeViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        carousel.didScroll()
        self.mySearchBox.endEditing(true)
        guard let currentCenterIndex = carousel.currentCenterCellIndex?.row else { return }
    }
}
// MARK: - UISearchBarDelegate

extension HomeViewController: UISearchBarDelegate, UISearchDisplayDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let textinSearch = searchBar.text {
            let newString = NSString(string:  textinSearch).replacingCharacters(in: range, with: text)
            if  newString.characters.count >=
                3 {
                if self.checkConnectionBeforeSearch() {
                    self.showLoading()
                    if let regex = try? NSRegularExpression(pattern: "\\s+", options: []) {
                        let replacement = regex.stringByReplacingMatches(in: newString, options: .withTransparentBounds, range: NSMakeRange(0, (newString as NSString).length), withTemplate: "_")
                        self.movieDataSource.requestMovies(person: String(describing: replacement))
                    }
                }else {
                    self.showAlert(title: "Atenção", message: "Por favor verifique sua conexão com a internet!")
                }
            }else if newString.characters.count == 0 {
                self.moviesResponse.movies = []
                self.carousel.reloadData()
            }
        }
        return true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.mySearchBox.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.mySearchBox.endEditing(true)
    }
}

// MARK: - MoviesDataSourceProtocol

extension HomeViewController: MoviesDataSourceProtocol {
    func responseMovies(movies: [MoviesResponse]) {
        self.dismissLoading()
        self.moviesResponse = movies.first ?? MoviesResponse()
        self.carousel.reloadData()
    }
    func errorData(_ dataSource: GenericDataSource?, error: Error) {
        self.dismissLoading()
        self.showAlert(title: "Atenção!", message: "Ocorreu um erro ao processar sua requisição")
    }
    
    func responseMovieById(movies: [Movie]) {
        
        
    }
}

