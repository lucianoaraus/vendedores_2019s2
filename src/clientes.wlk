import vendedores.*

class Cliente {
	method puedeSerAtendido(vendedor)
}

class ClienteInseguro inherits Cliente {
	override method puedeSerAtendido(vendedor){
		return super(vendedor)
		and vendedor.esVersatil()
		and vendedor.esFirme()
	}
}

class ClienteDetallista inherits Cliente {
	override method puedeSerAtendido(vendedor){
		return super(vendedor)
		and vendedor.certificaciones().count( { c => c.especialidad() == "productos" } ) >= 3
	}
}

class ClienteHumanista inherits Cliente {
	override method puedeSerAtendido(vendedor){
		return super(vendedor) and vendedor.esHumano()
	}
}