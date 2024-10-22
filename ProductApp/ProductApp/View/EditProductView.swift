//
//  EditProductView.swift
//  ProductApp
//
//  Created by alumno on 22/10/24.
//

import SwiftUI

struct EditProductView: View {
    @Environment(\.dismiss) var dismiss
    @State var nombre: String = ""
    @State var modelo: String = ""
    @State var marca: String = ""
    @State var cantidadInventario: String = ""
    @State var categoria: String = ""
    @State private var guardado = false
    @State private var showAlert = false
    
    var producto: Producto?
    var onSave: ((Producto) -> Void)?
    
    var body: some View {
        VStack {
            TextField("Nombre", text: $nombre)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Modelo", text: $modelo)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Marca", text: $marca)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Cantidad en Inventario", text: $cantidadInventario)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            TextField("Categoria", text: $categoria)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding()
        .navigationTitle(producto == nil ? "Nuevo Producto" : "Editar Producto")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    if ProductManager.validarDatosIncorrectos(nombre: nombre, modelo: modelo, marca: marca, cantidadInventario: cantidadInventario, categoria: categoria) {
                            showAlert = true
                            return
                    } else {
                        if let producto = producto {
                            ProductManager.editarProductoExistente(
                                producto: producto,
                                nombre: nombre,
                                modelo: modelo,
                                marca: marca,
                                cantidadInventario: cantidadInventario,
                                categoria: categoria,
                                onEdit: { editedProducto in
                                    onSave?(editedProducto)
                                    guardado = true
                                    dismiss()
                                }
                            )
                        } else {
                            ProductManager.guardarProductoNuevo(
                                nombre: nombre,
                                modelo: modelo,
                                marca: marca,
                                cantidadInventario: cantidadInventario,
                                categoria: categoria,
                                onSave: { nuevoProducto in
                                    onSave?(nuevoProducto)
                                    guardado = true
                                    dismiss()
                                }
                            )
                        }
                    }
                }) {
                    Image(systemName: "tray.and.arrow.down")
                }
            }
        }
        .onAppear {
            if let producto = producto {
                nombre = producto.nombre
                modelo = producto.modelo
                marca = producto.marca
                cantidadInventario = "\(producto.cantidadInventario)"
                categoria = producto.categoria.rawValue
            }
        }
        .alert(isPresented: $showAlert){
            Alert(
                title: Text("Datos Inválidos"),
                message: Text("Revise los datos ingresados"),
                dismissButton: .default(Text("Aceptar"))
            )
        }
    }
}

#Preview {
    EditProductView()
}
