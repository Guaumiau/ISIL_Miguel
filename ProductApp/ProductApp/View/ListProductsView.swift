//
//  ListProductsView.swift
//  ProductApp
//
//  Created by alumno on 22/10/24.
//

import SwiftUI

struct ListProductsView: View {
    @State private var productos: [Producto] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(productos) { producto in  // Producto ya es Identifiable, así que no hace falta especificar el id.
                    NavigationLink(destination: EditProductView(producto: producto, onSave: { editedProducto in
                        if let index = productos.firstIndex(where: { $0.id == editedProducto.id }) {
                            productos[index] = editedProducto
                        }
                    })) {
                        Text(producto.nombre)
                    }
                }
                .onDelete { indexSet in
                    ProductManager.eliminarProducto(productos: &productos, at: indexSet)
                }
            }
            .navigationTitle("Productos")
            .navigationBarItems(trailing: NavigationLink(destination: EditProductView(onSave: { nuevoProducto in
                productos.append(nuevoProducto)
            })) {
                Image(systemName: "plus")
            })
        }
    }
}

#Preview {
    ListProductsView()
}
