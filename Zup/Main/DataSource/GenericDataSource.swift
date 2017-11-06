//
//  GenericDataSource.swift
//  Zup
//
//  Created by Victor de Paula on 02/11/17.
//  Copyright © 2017 Victor de Paula. All rights reserved.
//

import Foundation

import UIKit
/// Esse protocolo é o responsavel por gerenciar o carregamento de todas as informações que serão utilizadas na camada de ViewModel.Cada ViewController tem seu proprio manager que deve implementa um protocolo extendido de GenericDataProvider, essa estrutura facilita no gerenciamento e assim todas as ViewControllers trabalharem de maneira uniforme, e caso seja necessário algum tratamento especifico voce deve utilizar o protocolo do manager que  voce criou para a ViewController.
@objc protocol GenericDataSource : class {
    
    @objc optional func reloadData(model: Any)
    func errorData(_ dataSource: GenericDataSource?, error: Error)
    
}

/// Essa é a Classe Super de todos os managers de ViewControllers utilizadas no app. Ele possui uma propriedade dataProvider que é um generic pois cada manager especifico pode ter o seu proprio comportamento e protocolos.
class DataSourceManager<T, S> {
    
    var dataSourceDelegate: T?
    var model: S?
    
}
