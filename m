From: FEANORKND <FEANORKND@terra.es>
Message-ID: <72f7d6cdee.6cdee72f7d@teleline.es>
Date: Sun, 12 Jun 2005 04:38:11 +0200
MIME-Version: 1.0
Content-Language: es
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Bridging........... necesito entender algo...
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hola, en primer lugar, agradecer una gu=EDa como la que teneis publicada,=20
y desde la cual, recojo la direccion mail para escribiros... es un=20
placer encontrar en espa=F1ol manuales tan bien explicados, y que=20
resultan practicos.

Mi caso particular es el siguiente:=20

En un hotel, acabo de instalar un firewall/router linux debian 2.6.8,=20
que enruta el tr=E1fico de las habitaciones de un eth1 (local) a un eth0=20
(wan)... he a=F1adido un sistema de autentificacion web por php,=20
gestionado desde recepcion, de forma, que con iptables, al mismo tiempo=20
que hago DROP en FORWARD a MACs no registradas, redirijo su trafico web=20
con -j REDIRECT al servidor apache, para que tecleen la url que=20
tecleen, le aparezca la web del hotel... cuando se registran, php=20
ejecuta shell para introducir las reglas de filtrado por MAC dandoles=20
acceso completo a internet...

EL PROBLEMA!!! tengo puesto un servidor DHCP, pero me interesa que los=20
clientes no tengan que tocar la configuraci=F3n TCPIP para poder=20
conectarse... es decir, me hace falta que la eth1 est=E9 en modo=20
promiscuo, y reciba los paquetes de cualquier puerta de enlace que un=20
cliente tenga configurada...... los paquetes salientes saldrian sin=20
problemas, supongo... pero los entrantes, se perder=EDan... por mucho=20
nat..

LA POSIBLE SOLUCION..... usar un brigde, y filtrar igualmente por=20
iptables como bien dice vuestra guia.... si los eth est=E1n en modo=20
promiscuo, todos los paquetes saldr=EDan sin problemas sea cual fuera la=20
gateway configurada en los clientes, e igualmente les llegarian de=20
vuelta las respuestas por nat...=20

LAS PREGUNTAS.... =BFestoy en lo cierto?=BFel bridging permitiria enrutar=20
trafico por nat sin importar las configuraciones ip de los clientes?
=BFaun asi, y puesto que he leido algo m=E1s de ebtables, y de bridges...=20
podria filtrar por -m mac en la tabla FILTER EN FORWARD (dicen creo que=20
la mac ya llegar=EDa a =E9ste punto cambiada por la del bridge)?=BFse me va=
=20
la cabeza y quizas con poner mi eth1 en modo promiscuo funcionaria el=20
invento sin usar bridge?=BFtendria que a=F1adir 'routes' o solo me valdria =

con el default, en el caso de que use un bridge?

UFFFF......... me estoy volviendo un poco loco con =E9sto, y es que soy=20
un poco novato.. el lunes o martes tengo que resolver =E9ste problema...=20
y es que los clientes son un poco torpes, y la mayoria no sabe ni poner=20
la IP en modo automatico (DHCP), y claro, yo no estoy en el hotel...=20

muchas gracias de antemano... espero que podais ayudarme.



