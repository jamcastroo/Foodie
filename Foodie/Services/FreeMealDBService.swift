//
//  FreeMealDBService.swift
//  Foodie
//
//  Created by Jamile Castro on 17/10/22.
//

import Foundation
import UIKit

struct FreeMealDBService {
    var baseURL = "https://www.themealdb.com/api/json/v1/1/"
    
    //Usamos 3 rotas diferentes da API, todas elas recebem apenas uma parametro que é uma string
    enum Route {
        case search(meal: String)
        case recipe(country: String)
        case details(id: String)
    }
    //A partir da rota escolhida, criaremos a url final para acessar a api
    func createURLForRoute(_ route: Route) -> URL {
        var path: String
        switch route {
        case .search(let meal):
            path = "search.php?s=\(meal)"
        case .recipe(let country):
            path = "filter.php?a=\(country.uppercased())"
        case .details(let id):
            path = "lookup.php?i=\(id)"
        }
        let finalPath = baseURL + path
        
        return URL(string: finalPath)!
    }
    //Pega todos os itens a partir de uma rota, como todas as respostas da api são padronizadas, usamos o APIResponse para o decode
    func getAll(route: Route) async -> [Recipie] {
        let url = createURLForRoute(route)
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(APIReponse.self, from: data)
            return response.meals
        } catch(let error) {
            print(error.localizedDescription)
            return []
        }
    }
    
    func getImageFrom(path: String) async -> UIImage? {
        //Nossa imagem padrão é uma da biblioteca
        //Caso o path não retorne uma url válida, retornaremos a imagem padrão
        guard let url = URL(string: path) else { return nil }
        // Se o arquivo existir no file manager, retorna dele
        if let fmData = retrieveFromFileManager(fileURL: url) {
            return UIImage(data: fmData) ?? nil
        }
        //Caso o arquivo não exista, precisamos fazer o download da imagem
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            //Após o download, caso o data seja uma imagem, salvaremos no file manager para não precisar pegar novamente
            saveToFileManager(data: data, fileURL: url)
            return image
        } catch {
            return UIImage(named: "AMERICAN")
        }
    }
    //Salva um arquivo no file manager
    func retrieveFromFileManager(fileURL: URL) -> Data? {
        guard let url = createPath(for: fileURL) else { return nil }
        let data = try? Data(contentsOf: url)
        return data
    }
    
    //Pega um arquivo já salvo no file manager
    func saveToFileManager(data: Data, fileURL: URL) {
        guard let url = createPath(for: fileURL) else { return }
        do {
            try data.write(to: url)
        } catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    //A partir da url retornada pela api, criamos nosso proprio path pra salvar no folder de cache, pegando a url através do file manager
    private func createPath(for file: URL) -> URL? {
        let baseFMPath = "/foodie-"
        let id = baseFMPath + file.lastPathComponent
        let folderURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        let path = folderURL?.appendingPathComponent(id, isDirectory: false)
        return path
    }
}
