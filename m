Message-ID: <20061106152538.20092.qmail@web27903.mail.ukl.yahoo.com>
Date: Mon, 6 Nov 2006 16:25:38 +0100 (CET)
From: Filippo Graziola <graziolafilippo@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Subject: [Bridge] Problems with Bridging 3 pc's network
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org
Content-Transfer-Encoding: quoted-printable

Hi sir,
I'm a student of Trento University and I'm working on
a network
project. I need to create a network like this:

PC.1>--ethernet cable-->MAIN_PC(ubuntu
linux)>------wireless----->PC.2

PC.1 ip: 192.168.0.1
MAIN_PC ip: 192.168.0.2
PC.2 ip: 192.168.0.3
netmask 255.255.255.0

I followed the instruction of the HOWTO and I made a
bridge on MAIN_PC.
Previously I set the wireless interface (eth0 - intel
2200B/G) with
ad-hoc mode and I gave it a essid and a channel.
Without the bridge I can
ping from MAIN_PC all the others but I noticed that
when the bridge is
up I can't ping from the PC.2 the PC.1 (problem nr=B01)
and I can ping
from PC.2 the MAIN_PC only for a short start time
(problem nr=B02).

When I give this command as root:

echo "1" > /proc/sys/net/ipv4/ip_forward

this is the answer:

bash: /proc/sys/net/ipv4/ip_forward: Permission denied

Maybe I think this is the reason because I get problem
nr=B01, is it
true?
What should I do?

I have no idea for the second problem.
Can you please help.
Sorry for my english, I hope that my explanation were
enough clear
Thanks a lot

Filippo Graziola


__________________________________________________
Do You Yahoo!?
Poco spazio e tanto spam? Yahoo! Mail ti protegge dallo spam e ti da tanto =
spazio gratuito per i tuoi file e i messaggi=20
http://mail.yahoo.it=20
