//
//  DetailViewController.swift
//  Zup
//
//  Created by Victor de Paula on 02/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class DetailViewController: BaseViewController {
    // MARK: - Properties
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var savedButton: UIButton!
    
    @IBOutlet weak var heightTableConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonConstraintHeight: NSLayoutConstraint!
    
   // MARK: - Variables
    var verifyWhereIsComming = false
    var movie : Movie = Movie()
    var imdbId: String?
    
    
    // MARK: - DataSource utilizado para networking 
    var  movieDataSource : MovieDataSource = MovieDataSource()
    
    
   // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.movieDataSource.dataSourceDelegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.register(UINib(nibName: "movieDetailCell", bundle: nil), forCellReuseIdentifier: "movieDetailCell")
        self.tableView.register(UINib(nibName: "movieDescriptionDetailCell", bundle: nil), forCellReuseIdentifier: "movieDescriptionCell")
        
        if let id = imdbId {
            self.showLoading()
            self.movieDataSource.requestMovieById(id: id)
        }else {
            configFields(movie: movie)
        }
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        self.tabBarController?.setTabBarVisible(visible: true, animated: false)
    }
    
    // MARK: - Misc
    func configFields(movie:Movie){
        self.titleLbl.text = movie.title ?? ""
        if !verifyWhereIsComming {
            if let moviePoster = movie.poster {
                if moviePoster == "N/A" {
                     self.movieImageView.image = UIImage(named: "indisponible")
                }else {
                       self.movieImageView.sd_setImage(with: URL(string: moviePoster), completed: nil)
                }
            }
        }else {
            self.movieImageView.image = UIImage(data: (movie.moviedata as! NSData) as Data)
            
            self.savedButton.isHidden = true
            self.heightTableConstraint.constant += self.buttonConstraintHeight.constant
                self.buttonConstraintHeight.constant = 0
        }
        self.movie.convertFieldsToDictionary()
        self.tableView.reloadData()
    }
  

    func prepareObjectToSave(){
        var movie = Movie()
        movie.id = self.imdbId
        movie.year = self.movie.year
        movie.rated = self.movie.rated
        movie.actors = self.movie.actors
        movie.country = self.movie.country
        movie.released = self.movie.released
        movie.runtime = self.movie.runtime
        movie.genre = self.movie.genre
        movie.director = self.movie.director
        movie.writer = self.movie.writer
        movie.plot = self.movie.plot
        movie.title = self.movie.title
        
        movie.moviedata = self.movieImageView.image?.convertToNSData()
        if let id = self.imdbId {
            let movies = MovieData.sharedInstance.getMoviesWithId(movieId: id)
            if movies?.count ?? 0 > 0 {
                self.showAlert(title: "Atenção!", message: "Filme já cadastrado em nossa base de dados!")
            }else {
                MovieData.sharedInstance.saveMovie(movie)
                self.showAlert(title: "Atenção!", message: "Inserido com sucesso!")
                
            }
        }
    }

    @IBAction func movieButtonSave(_ sender: UIButton) {
       self.prepareObjectToSave()
    }
    


}

// MARK: - UITableViewDelegate
extension DetailViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
// MARK: - UITableViewDataSource
extension DetailViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movie.dictionary.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dict = self.movie.dictionary.getElementByIndex(i: indexPath.row)
        if dict.key.elementsEqual("plot") {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "movieDescriptionCell", for: indexPath) as? MovieDetailCell {
                cell.descriptionMovie.text = String(describing :  dict.value ?? "") ??  ""
                return cell
            }
        }
        else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "movieDetailCell", for: indexPath) as? MovieDetailCell {
                cell.titleDetail.text = dict.key
                cell.descriptionDetail.text = dict.value
                return cell
            }
        }
        return UITableViewCell()
    }
}

// aqui sao implementados os metodos de networking localizado na camada responsavel pelas requisicoes do aplicativo
// MARK: - MovieDataSource
extension DetailViewController : MoviesDataSourceProtocol {
    func responseMovieById(movies: [Movie]) {
        self.dismissLoading()
        self.movie = movies.first ?? Movie()
        if let movie = movies.first {
            self.configFields(movie: movie)
        }
        self.movie.convertFieldsToDictionary()
        self.tableView.reloadData()
    }
  
    func responseMovies(movies: [MoviesResponse]) {
        
    }
    
    func errorData(_ dataSource: GenericDataSource?, error: Error) {
        self.dismissLoading()
        self.showAlert(title: "Atenção!", message: "Ocorreu um erro ao processar sua requisição")
    }
    
}

