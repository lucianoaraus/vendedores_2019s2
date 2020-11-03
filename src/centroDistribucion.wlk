import vendedores.*

//López y López es una empresa de distribución de productos de consumo masivo. Trabajan a nivel nacional.
//Cada CENTRO de distribucion trabaja con distintos VENDEDORES.

class CentroDistribucion {
	var property ciudad
	var property vendedores = []
	
	method agregarVendedor(vendedor){
		if(not vendedores.contains(vendedor)){ vendedores.add(vendedor)}
		else{ self.error("el vendedor ya se encuentra en el centro") }
	}
	method vendedorEstrella(){
		return vendedores.max( { v => v.certificaciones().sum( { c => c.puntos() } ) } )
	}
	method puedeCubrir(ciudadRequerida){
		return vendedores.any( { v => v.puedeTrabajar(ciudadRequerida) } )
	}
	method vendedoresGenericos(){
		return vendedores.any( { v => v.certificaciones() != "productos" } )
	}
	method esRobusto(){
		return vendedores.count( { v => v.esFirme() } ) >= 3
	}
	method repartirCertificacion(certificacionAOtorgar){
		 vendedores.forEach( { v => v.adquirirCertificacion(certificacionAOtorgar) } )
	}
}

