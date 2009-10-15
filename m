Message-ID: <4AD737A7.3090103@futureware.at>
Date: Thu, 15 Oct 2009 16:54:31 +0200
From: =?ISO-8859-15?Q?Philipp_G=FChring?= <pg@futureware.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Linux Dynamic Bridging Support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: bridge@osdl.org

Hi,

The scenario I have is that I have a computer with one network interface
eth0, that is receiving it's configuration through DHCP, and uses
complex firewalling rules for eth0.

Now I want to add a virtual machine on that computer

According to the usual recipies, I have to do the following:

ifconfig eth0 0.0.0.0
brctl addbr br0
brctl addif br0 eth0
dhclient br0

Afterwards I can add interfaces to the bridge:
brctl addif br0 tun0

This has several disadvantages:
* It causes a network outage for up to a few seconds (mostly due to the
unnecessary DHCP)
* It does not migrate the firewall rules to br0
* It breaks all firewall-rules that were written for eth0
* If I use eth0 in the office today, wlan0 at home, and ppp0 when I am
outside, then I would need lots of different scripts for all the
different bridging combinations.

Now the idea is to add migration support to Linux Bridging.

It could look like this:

brctl addbr br0
brctl takeif br0 eth0

take-interface would migrate the IP address, and routing entries from
the eth0 interface to the bridge, in a more-or-less atomic fashion, and
add eth0 as interface to the brige. It would also adapt iptables-rules
that were written for eth0 to be pointing to br0 now.

To release the bridge again, it could be done like this:
brctl releaseif br0 eth0
brctl delbr br0

Since all that is a bit complex, I still have an alternative proposal:
What if we bridge-enable all normal interfaces?
It could look like this:

brctl enablebr eth0

This would enable bridging mode for the eth0 interface. It automatically
is able to use the DHCP ip address it was given, the firewalling, ...
I can then easily add additional interfaces to the bridge-enabled
interface like this:

brctl addif eth0 tun0

And I don't need to worry about DHCP, firewalls, ... anymore.

So my question now is:
Which way should we go? Migrating interface configuration into bridges,
or bridge-enabling interfaces?

Best regards,
Philipp G=FChring

