

class Vendedor {
	var property certificaciones = [] 
	//cada certificacion otorga puntos
	//algunas son sobre productos, otras no
	
	method esVersatil(){
		return certificaciones.size() >= 3 
		and certificaciones.any( { c => c.especialidad() == "productos" } )
		and not certificaciones.any( { c => c.especialidad() == "productos" } )
	}
	method esFirme(){ return certificaciones.sum( { c => c.puntos() >= 30 } ) }
	method adquirirCertificacion(certificacionAAdquirir){
		certificaciones.add(certificacionAAdquirir)
	}
	method afinidadAlCentro(centro)
	method esCandidato(centro){ return self.esVersatil() }
}

class VendedorFijo inherits Vendedor {
	var property ciudadDeResidencia
	
	method puedeTrabajar(ciudad){ return ciudadDeResidencia == ciudad }
	method esInfluyente() = false
	override method afinidadAlCentro(centro){
		return self.puedeTrabajar(centro.ciudad())
	}
	override method esCandidato(centro){
		return super(centro) and self.afinidadAlCentro(centro)
	}
	method esHumano() = true
	
}

class Viajante inherits Vendedor {
	var property provinciasHabilitadas = []
	
	method puedeTrabajar(ciudad){ return provinciasHabilitadas.contains(ciudad.provincia())	}
	method esInfluyente(){
		return provinciasHabilitadas.sum( { p => p.poblacion() >= 10000000 } )
	}
	override method afinidadAlCentro(centro){
		return self.puedeTrabajar(centro.ciudad())
	}
	override method esCandidato(centro){
		return super(centro) and self.afinidadAlCentro(centro)
	}
	method esHumano() = true
}

class ComercioCorresponsal inherits Vendedor {
	var property ciudadesConSucursales = []
	
	method puedeTrabajar(ciudad){ return ciudadesConSucursales.contains(ciudad) }
	method esInfluyente(){
		return ciudadesConSucursales.size() >= 5
		or ciudadesConSucursales.map( { c => c.provincia() } ).asSet().size() >= 3
	}
	override method afinidadAlCentro(centro){
		return self.puedeTrabajar(centro.ciudad())
		and ciudadesConSucursales.any( { c => not centro.puedeCubrir(c) } )
	} 
	override method esCandidato(centro){
		return super(centro) and self.afinidadAlCentro(centro)
	}
	method esHumano() = false
}


class Ciudad {
	var property provincia
}

class Provincia {
	var property poblacion
}


class Certificaciones {
	var property especialidad
	var property puntos
}