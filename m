From: =?ISO-8859-1?Q?KLEIN_St=E9phane?= <stephane@harobed.org>
Date: Sun, 25 Dec 2005 12:02:11 +0100
Message-ID: <dolu7k$anu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Sender: news <news@sea.gmane.org>
Subject: [Bridge] When I add br0 (brctl addbr br0),
 and I show bridge list  (brctl
 show) it's eth0 which is in the list. It's a bug ?
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

All is in subject.

Example :

root@harobed:~ # brctl show
bridge name     bridge id               STP enabled     interfaces
root@harobed:~ # ifconfig
lo        Lien encap:Boucle locale
           inet adr:127.0.0.1  Masque:255.0.0.0
           adr inet6: ::1/128 Scope:H=F4te
           UP LOOPBACK RUNNING  MTU:16436  Metric:1
           RX packets:16510 errors:0 dropped:0 overruns:0 frame:0
           TX packets:16510 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 lg file transmission:0
           RX bytes:5107285 (4.8 MiB)  TX bytes:5107285 (4.8 MiB)

root@harobed:~ # brctl addbr br0
root@harobed:~ # brctl show
bridge name     bridge id               STP enabled     interfaces
eth1            8000.000000000000       no               can't get port=20
info: Function not implemented
root@harobed:~ #

Supplementary informations :
* eth0 is Ethernet card
* eth1 is wireless card enabled (with On/off laptop button)

Thanks for your help.

-- Stephane

