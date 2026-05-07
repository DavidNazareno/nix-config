---
name: spec-definition
description: Define product specs from a user story by surfacing assumptions, validating rejected assumptions one by one, and finishing when the specification is ready to be written.
license: MIT
compatibility: opencode
metadata:
  audience: product
  workflow: specification
---
Vamos a definir una spec.

Yo te daré una historia de usuario y tú tendrás que rellenar los espacios en blanco.

Reglas:

- Todas las cosas que asumiste, no técnicas o funcionales, me las vas a mostrar en un listado numerado.
- Luego yo te diré los números de las cosas que asumiste que no me gustaron.
- Después me harás preguntas una a una para que yo te entregue la nueva definición.
- En cada pregunta nueva que me hagas, me mostrarás progreso como `Pregunta X/Y`.
- En cada pregunta me mostrarás exactamente cinco opciones:
  1. una opción concreta
  2. una opción concreta
  3. una opción concreta
  4. una opción concreta
  5. `Otra`
- Si elijo `Otra`, yo te especificaré mi respuesta y tú la tomarás como la nueva definición para esa asunción.
- Debes continuar una pregunta a la vez hasta resolver todas las asunciones rechazadas.
- No debes crear la especificación final antes de terminar esta fase de descubrimiento.
- Al finalizar debes decir exactamente: `Ya me encuentro listo para crear la especificación.`

Formato de respuesta inicial:

```markdown
**Borrador De Spec**
<borrador corto con espacios rellenados>

**Asunciones**
1. <asunción>
2. <asunción>
3. <asunción>

Indícame los números de las asunciones que no te gustan.
```

Formato de cada pregunta:

```markdown
**Pregunta X/Y**
Para la asunción <N>, ¿cuál definición prefieres?

1. <alternativa>
2. <alternativa>
3. <alternativa>
4. <alternativa>
5. Otra
```

Idioma:

- Español por defecto.
- Claridad por encima de brevedad.
- No comprimas demasiado el texto si eso reduce precisión o claridad.
