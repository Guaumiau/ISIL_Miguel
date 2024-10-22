//
//  Product.swift
//  ProductApp
//
//  Created by alumno on 22/10/24.
//

import Foundation

struct Producto: Identifiable {
    var id: UUID
    var nombre: String
    var modelo: String
    var marca: String
    var cantidadInventario: Int
    var categoria: Categoria
}

enum Categoria: String, CaseIterable, Identifiable {
    case Laptops, Teclados, Parlantes, Procesadores
    var id: String { self.rawValue }
}
