Message-Id: <200403181835.i2IIZpo4031856@mail.kaixo.com>
Date: Thu, 18 Mar 2004 19:35:51 -0000
From: "Zaikxtox" <zaikxtox@kaixo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="iso-8859-1";
MIME-Version: 1.0
Subject: [Bridge] Iptables does not filter on 2.4.25 - Continued
Reply-To: Zaikxtox <zaikxtox@kaixo.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

Hello.
I have tested again and the default policy for INPUT, FORWARD and OUTPUT is
DROP
also there is a single rule matching anything as source and anything as
destination with action DROP
also
"cat /proc/sys/net/ipv4/ip_forward "
says "0"
The connecting machine has a single cable to my bridge, so there is no other
way to go trough the net.
But netfilter does not stop the trafic!!!
i tried with a stock debian 2.4.25 kernel, and a 2.4.25 kernel comiled in
house.
I have already used bridge + iptables with 2.4.19 kernel, so i know how it
should work.
some help or know bugs??
is someone used bridge + netfilter on a 2.4.25 kernel and it works please
write me!
thanks.
IVan


________________________________________________
Kaixo! (http://www.kaixo.com)
Portal de Euskadi - Euskadiko ataria
