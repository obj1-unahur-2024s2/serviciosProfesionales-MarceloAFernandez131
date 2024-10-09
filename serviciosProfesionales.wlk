class Universidad {
    const property provincia
    var property honorarios
}

class AsociadoAUniversidad {
    const property universidad
    method honorarios() = universidad.honorarios()
    method puedeTrabajar() = [universidad.provincia()]
    
    method cobrar(unImporte) {
        universidad.recibirDonaciones(unImporte*0.5)
    }
}

class AsociadosAlLitoral {
    const property universidad
    method honorarios() = 3000
    method puedeTrabajar() = ["EntreRios","SantaFe","Corrientes"]

    method cobrar(unImporte) {
        asociacionProfesionalesDelLitoral.recaudar(unImporte)
    }
}

class Libres {
    const property universidad
    var property puedeTrabajar = []
    
    method cobrar(unImporte) {
        universidad.recibirDonaciones(unImporte*0.5)
    }

    
}

class Empresas {
    const property profesionales = []
    var property honorariosReferencia 
    
    method agregarProfesional(unProfesional) {
        profesionales.add(unProfesional)
    }

    method cuantos(unaUniversidad) {
        return profesionales.count({p => p.universidad() == unaUniversidad})
    }

    method profesionalesCaros() {
        return profesionales.filter({p => p.honorarios() > honorariosReferencia})
    }

    method universidadesFormadoras() {
        return profesionales.map({p => p.universidad()}).asSet()    
    }
    
    method profesionalMasBarato() { 
        return profesionales.min({p => p.honorarios()})
    }

    method genteAcotada() {
        return profesionales.all({p => p.puedeTrabajar().size() <= 3})
    }

    method puedeSatisfacerSolicitante(unSolicitante) {
        return profesionales.any({p => unSolicitante.puedeSerAtendidoPor(p)})
    }
}

class SolicitantePersona {
    var property provincia
    
    method puedeSerAtendidoPor(unProfesional) {
        return unProfesional.puedeTrabajar().contains(provincia)
    }
}

class SolicitanteInstitucion {
    var property universidades
    
    method puedeSerAtendidoPor(unProfesional) {
        return universidades.contains(unProfesional.universidad())
    }
}

class SolicitanteClub {
    var property provincias

    method puedeSerAtendidoPor(unProfesional) {
        return not provincias.asSet().intersection(
            unProfesional.puedeTrabajar().asSet()
            ).isEmpty()
    }
    
}

object asociacionProfesionalesDelLitoral {
    var recaudacion = 0
    
    method recaudar(unImporte) {
        recaudacion += unImporte
    }
}