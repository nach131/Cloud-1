

### **Página 1**

[cite_start]Cloud-1 [cite: 1]

[cite_start]Despliegue automatizado de Inception [cite: 2]

[cite_start]Rémy Léone rleone@scaleway.com [cite: 3]

[cite_start]**Resumen:** Despliegue automatizado de Inception en un servidor remoto. [cite: 4]

[cite_start]**Versión:** 7.3 [cite: 5]

***

### **Página 2**

[cite_start]No existe la nube, es solo el ordenador de otra persona. [cite: 6]

***

### **Página 3**

[cite_start]**Índice** [cite: 7]

[cite_start]La siguiente tabla: [cite: 8]
| | | |
| :--- | :--- | :--- |
| I | Introducción | 3 |
| II | Elección de la plataforma | 4 |
| III | Parte obligatoria | 5 |
| IV | Puntos clave | 6 |
| V | Entrega y evaluación por pares | 7 |

***

### **Página 4**

[cite_start]**Capítulo I** [cite: 10]

[cite_start]**Introducción** [cite: 11]

Este tema está inspirado en el proyecto Inception. [cite_start]El objetivo es desplegar tu sitio y la infraestructura de docker necesaria en una instancia proporcionada por un proveedor de servicios en la nube. [cite: 12]

En esta versión, cada proceso tendrá su propio contenedor. [cite_start]NO PUEDES desplegar las mismas imágenes de Inception y darlo por terminado ;) Puedes, por supuesto, obtener el código fuente del sitio web (tu blog de WordPress, por ejemplo), pero tienes que desplegarlo utilizando un contenedor por proceso y automatización. [cite: 13]

La automatización es esencial aquí. [cite_start]Las fases de despliegue deben ser automatizadas por una herramienta de tu elección (sugerimos Ansible). [cite: 14]

[cite_start]Este servidor web completo debe ser capaz de ejecutar varios servicios en paralelo, como WordPress, PHPmyadmin y una base de datos. [cite: 15]

***

### **Página 5**

[cite_start]**Capítulo II** [cite: 17]

[cite_start]**Elección de la plataforma** [cite: 18]

[cite_start]42 no proporciona los servidores necesarios para ejecutar tu aplicación. [cite: 19]

[cite_start]Todo tu código deberá alojarse en servidores externos a la escuela, que deberás conseguir (y pagar) por tu cuenta. [cite: 20]

Este proyecto requiere acceso a recursos en la nube. [cite_start]Hay varias opciones disponibles en función de tus necesidades y de las oportunidades a tu alcance. [cite: 21]

[cite_start]Aquí tienes algunas posibilidades: [cite: 22]

* [cite_start]Aprovechar los créditos gratuitos para estudiantes que ofrecen proveedores como Azure, AWS, GCP [cite: 23]
* [cite_start]Verificar si tu campus puede cubrir los costes de alojamiento en la nube con un proveedor. [cite: 24]

[cite_start]Te animamos a explorar estas soluciones para elegir la opción que mejor se adapte a tu proyecto. [cite: 25]

[cite_start]**!** [cite: 26]

Si decides utilizar un proveedor, es posible que se te facture. [cite_start]Asegúrate de leer las condiciones de uso y los servicios que puedes utilizar con tus créditos. [cite: 27, 28]

[cite_start]Recuerda apagar los servicios que no estés utilizando. [cite: 29]

[cite_start]En resumen, ten cuidado, es TU responsabilidad, te proporcionamos todo lo que necesitas para que este proyecto no te cueste absolutamente nada. [cite: 30]

[cite_start]Estás en un entorno de trabajo REAL, tus decisiones tienen consecuencias REALES. [cite: 31]

***

### **Página 6**

[cite_start]**Capítulo III** [cite: 32]

[cite_start]**Parte obligatoria** [cite: 33]

El despliegue de tu aplicación debe estar totalmente automatizado. [cite_start]Te sugerimos que utilices Ansible, pero eres libre de utilizar otra herramienta si lo deseas. [cite: 34]

[cite_start]Es imperativo proporcionar un sitio funcional equivalente al obtenido con Inception utilizando únicamente tu script. [cite: 35]

Necesitas instalar un sitio simple de WordPress en una instancia. [cite_start]Debes asegurarte de que: [cite: 36]

* [cite_start]Tu sitio pueda reiniciarse automáticamente si el servidor se reinicia. [cite: 37]
* [cite_start]En caso de reinicio, todos los datos del sitio persistan (imágenes, cuentas de usuario, artículos, ...). [cite: 38]
* [cite_start]Sea posible desplegar tu sitio en varios servidores en paralelo. [cite: 39]
* [cite_start]El script debe poder funcionar de forma automatizada con la única suposición de que la instancia de destino tenga un sistema operativo como Ubuntu 20.04 LTS, con un demonio SSH en ejecución y Python instalado. [cite: 40]
* [cite_start]Tus aplicaciones se ejecutarán en contenedores separados que puedan comunicarse entre sí (1 proceso = 1 contenedor). [cite: 41]
* [cite_start]El acceso público a tu servidor debe ser limitado y seguro (por ejemplo, no es posible conectarse directamente a tu base de datos desde Internet). [cite: 42]
* Los servicios serán los diferentes componentes de un WordPress que deberás instalar tú mismo. [cite_start]Por ejemplo, Phpmyadmin, MySQL, ... [cite: 43]
* [cite_start]Debes tener un archivo `docker-compose.yml`. [cite: 44]
* [cite_start]Deberás asegurarte de que tu base de datos SQL funcione con WordPress y PHPMyAdmin. [cite: 45]
* [cite_start]Tu servidor debería poder utilizar TLS siempre que sea posible. [cite: 46]
* [cite_start]Deberás asegurarte de que, dependiendo de la URL solicitada, tu servidor redirija al sitio correcto. [cite: 47]

***

### **Página 7**

[cite_start]**Capítulo IV** [cite: 49]

[cite_start]**Puntos clave** [cite: 50]

Este párrafo es muy importante, léelo con atención, tantas veces como sea necesario. [cite_start]Si tienes alguna duda, pregunta. [cite: 51]

[cite_start]La mayoría de los proveedores (AWS o GCP, por ejemplo) ofrecen un nivel de uso gratuito que permitirá realizar este proyecto a un coste reducido o incluso de forma gratuita. [cite: 52]

[cite_start]En cualquier caso, TÚ ERES RESPONSABLE DE ELEGIR Y DETENER LAS INSTANCIAS Y SERVICIOS DESPLEGADOS: si olvidas un servidor o dejas una tarea ejecutándose en bucle, puedes superar los créditos que se te han asignado y tendrás que pagar por ese uso. [cite: 53, 54]

[cite_start]**!** [cite: 55]

[cite_start]Prestarás especial atención al tamaño de todos los servidores y servicios que pongas en marcha. [cite: 56]

[cite_start]Si sobredimensionas tus recursos, podría resultar caro y agotar tus créditos más rápidamente. [cite: 57] [cite_start]Además, no todos los servicios o tamaños de servidor son elegibles para los niveles de uso gratuito que ofrecen los proveedores en general. [cite: 58]

[cite_start]**!** [cite: 59]

[cite_start]El uso de servicios de terceros es enteramente TU responsabilidad, SE TE COBRARÁ si SUPERAS tus créditos gratuitos. [cite: 61] [cite_start]La escuela no puede ayudarte en tus relaciones con proveedores externos. [cite: 62]

[cite_start]Además, presta atención al código alojado en GitHub u otro repositorio público: no dejes claves o identificadores a la vista. [cite: 63]

[cite_start]En resumen, no estamos en un entorno de pruebas, estos son recursos reales. [cite: 64]

***

### **Página 8**

[cite_start]**Capítulo V** [cite: 66]

[cite_start]**Entrega y evaluación por pares** [cite: 67]

[cite_start]Entrega tu trabajo en tu repositorio de Git como de costumbre. [cite: 68]

[cite_start]Solo el trabajo que se encuentre dentro de tu repositorio será evaluado durante la defensa. [cite: 69] [cite_start]No dudes en comprobar dos veces los nombres de tus carpetas y archivos para asegurarte de que son correctos. [cite: 70]

[cite_start]No incluye una parte de bonus. [cite: 71]

[cite_start]No prestaremos demasiada atención al aspecto del sitio, un WordPress básico es suficiente. [cite: 72]

[cite_start]Toleraremos la ausencia de un nombre de dominio memorable, pero si tienes un nombre de dominio, es un punto a favor. [cite: 73] [cite_start]Especialmente cuando este nombre memorable te permita acceder a tu sitio a través de HTTPS. [cite: 74] Existen proveedores de nombres de dominio gratuitos como:

* [cite_start]DuckDNS [cite: 75]
* [cite_start].tk TLD [cite: 76]

[cite_start]Si quieres adquirir un nuevo nombre de dominio específicamente para este ejercicio, correrá de tu cuenta. [cite: 78]