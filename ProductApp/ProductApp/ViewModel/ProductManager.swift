//
//  ProductManager.swift
//  ProductApp
//
//  Created by alumno on 22/10/24.
//

import Foundation

class ProductManager {
    static let categoriasValidas = Categoria.allCases.map { $0.rawValue }
    
    static func guardarProductoNuevo(nombre: String, modelo: String, marca: String, cantidadInventario: String, categoria: String, onSave: ((Producto) -> Void)?) {
        let nuevoProducto = Producto(
            id: UUID(),
            nombre: nombre,
            modelo: modelo,
            marca: marca,
            cantidadInventario: Int(cantidadInventario) ?? 0,
            categoria: Categoria(rawValue: categoria)!
        )
        
        onSave?(nuevoProducto)
    }
    
    // Función para editar un producto existente
    static func editarProductoExistente(producto: Producto?, nombre: String, modelo: String, marca: String, cantidadInventario: String, categoria: String, onEdit: ((Producto) -> Void)?) {
        let productoEditado = Producto(
            id: producto?.id ?? UUID(),
            nombre: nombre,
            modelo: modelo,
            marca: marca,
            cantidadInventario: Int(cantidadInventario) ?? 0,
            categoria: Categoria(rawValue: categoria)!
        )
        
        onEdit?(productoEditado)
    }
    // Función para eliminar un producto existente
    static func eliminarProducto(productos: inout [Producto], at offsets: IndexSet) {
        productos.remove(atOffsets: offsets)
    }
    
    static func validarDatosIncorrectos(nombre: String, modelo: String, marca: String, cantidadInventario: String, categoria: String) -> Bool {
        guard !nombre.isEmpty else {
            return true
        }
        
        guard !modelo.isEmpty else {
            return true
        }
        
        guard !marca.isEmpty else {
            return true
        }
        
        guard let cantidad = Int(cantidadInventario), cantidad >= 0 else {
            return true
        }
            
        guard let _ = Categoria(rawValue: categoria) else {
            return true
        }
        return false
    }
}
