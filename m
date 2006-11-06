Message-ID: <454F5FF0.4010500@cambridgebroadband.com>
Date: Mon, 06 Nov 2006 16:16:48 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
References: <20061106152538.20092.qmail@web27903.mail.ukl.yahoo.com>
In-Reply-To: <20061106152538.20092.qmail@web27903.mail.ukl.yahoo.com>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Problems with Bridging 3 pc's network
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Filippo Graziola <graziolafilippo@yahoo.it>
Cc: bridge@osdl.org

Filippo Graziola wrote:
> Hi sir,
> I'm a student of Trento University and I'm working on
> a network
> project. I need to create a network like this:
>=20
> PC.1>--ethernet cable-->MAIN_PC(ubuntu
> linux)>------wireless----->PC.2
>=20
> PC.1 ip: 192.168.0.1
> MAIN_PC ip: 192.168.0.2
> PC.2 ip: 192.168.0.3
> netmask 255.255.255.0
>=20
> I followed the instruction of the HOWTO and I made a
> bridge on MAIN_PC.
> Previously I set the wireless interface (eth0 - intel
> 2200B/G) with
> ad-hoc mode and I gave it a essid and a channel.
> Without the bridge I can
> ping from MAIN_PC all the others but I noticed that
> when the bridge is
> up I can't ping from the PC.2 the PC.1 (problem nr=B01)
> and I can ping
> from PC.2 the MAIN_PC only for a short start time
> (problem nr=B02).
>=20
> When I give this command as root:
>=20
> echo "1" > /proc/sys/net/ipv4/ip_forward
>=20
> this is the answer:
>=20
> bash: /proc/sys/net/ipv4/ip_forward: Permission denied
>=20

This is not the cause of your problem.  You are trying to
bridge ethernet packets at layer 2, not route IP packets
at layer 3.


> Maybe I think this is the reason because I get problem
> nr=B01, is it
> true?
> What should I do?
>=20

  * Do a "brctl show" and send the results to the list.

  * Do an "ifconfig -a" and send the results to the list.

You may have an IP address problem.  After you have added interfaces
(e.g. eth0 and wlan0) to a bridge (br0) you must remove the IP addresses
from the interfaces with, for example,  "ifconfig eth0 0.0.0.0 up" and "ifc=
onfig
wlan 0.0.0.0 up", and then apply the IP address to br0, e.g. "ifconfig
br0 192.168.0.2 up"

Alex


> I have no idea for the second problem.
> Can you please help.
> Sorry for my english, I hope that my explanation were
> enough clear
> Thanks a lot
>=20
> Filippo Graziola
>=20
>=20
> __________________________________________________
> Do You Yahoo!?
> Poco spazio e tanto spam? Yahoo! Mail ti protegge dallo spam e ti da tant=
o spazio gratuito per i tuoi file e i messaggi=20
> http://mail.yahoo.it=20
> _______________________________________________
> Bridge mailing list
> Bridge@lists.osdl.org
> https://lists.osdl.org/mailman/listinfo/bridge

