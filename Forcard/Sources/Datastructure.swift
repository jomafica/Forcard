//
//  Datastructure.swift
//  Forcard
//
//  Created by Daniel Pereira on 14/11/2020.
//

//{"id_art": "post-723462",
//"content": {"title_art": "Holandeses criam drone versátil que voa mais de 3 horas a hidrogénio", "description": "Os drones de há poucos anos atrás, eram gadgets que despertavam curiosidade por serem uma novidade. Mas com a evolução tecnológica, atualmente estes equipamentos tornaram-se verdadeiras máquinas capazes de apresentar um desempenho extraordinário com diversas finalidades.", "date": "14 Nov 2020", "url_art": "https://pplware.sapo.pt/motores/holandeses-dizem-ter-criado-o-mais-versatil-drone-do-mundo-que-voa-a-hidrogenio/", "img_art": "https://pplware.sapo.pt/wp-content/uploads/2020/11/drone-holanda-hidrogenio-720x401.jpg"}}

import Foundation

struct Art_jbody: Decodable, Equatable {
    var id: String
     let content: Art
    
    enum CodingKeys: String, CodingKey {
           case id = "id_art"
           case content = "content"
        }
    static func ==(lhs: Art_jbody, rhs: Art_jbody) -> Bool {
        return lhs.id == rhs.id && lhs.content == rhs.content
    }
}

struct Art: Decodable, Equatable {
     let title_art: String
     let description: String!
     let url_art: String
     let img_art: String
    
    enum CodingKeys: String, CodingKey {
            case title_art = "title_art"
            case description = "description"
            case url_art = "url_art"
            case img_art = "img_art"
        }
}
