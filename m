Message-ID: <023001c4861c$7f9935d0$8805640a@chriss>
From: "Chris Shaw" <chriss@watertech.com>
References: <20040819120454.7403.qmail@web41004.mail.yahoo.com>
Subject: Re: [Bridge] Routing Problem within LAN
Date: Thu, 19 Aug 2004 11:44:02 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Reply-To: Chris Shaw <chriss@watertech.com>
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

----- Original Message -----
From: "Yong Chu Eu (=D1=EE=D7=D3=D3=D3)" <ceyong@yahoo.com>
To: <bridge@osdl.org>
Sent: Thursday, August 19, 2004 5:04 AM
Subject: [Bridge] Routing Problem within LAN


>                                    |
>                                    |
>                                   fxp0
>                            FreeBSD 4.10 Router
>                            vr0               rl0
>                            |                 |
>                            |                 |
>                            |                 |
>                           eth0              eth0
>                   Linux Access Point  Linux Access Point
>                      (HOSTAP 0.13)      (HOSTAP 0.13)
>                            |                 |
>                          wlan0             wlan0
>                        192.168.2.4        192.168.3.4
>
> Roaming notebook with Linux Kernel 2.4.22 with MIPL 1.0(Dlink Wireless
> Card with acx100 driver)-192.168.4.1
>
> i setup a bridge(br0) between eth0 with wlan0 for each access point. The
> problem i encounter is i cannot setup a routing between notebook with
> access point. How i am going to setup a statix routing(gateway,ipv6
> gateway) if my notebook need to roam  between this 2 access point(with
> different IP address on each access point as gateway)? Since i setup the
> bridge with not ip address on wlan0(even i set an ip address on it),i
> cannot configure a routing from notebook to access point(error message
> always said network unreachable). Anyone can help? Thanks!
>

Hmmm I see a couple problems here... First of all, if I am understanding
correctly, you cannot assign an IP address to WLAN0 if it is part of a
bridge. Assign the IP to BR0 and not WLAN0 if you want to be able to
communicate with the access point.

I don't understand your routing question, sorry, but it looks like you've
got 3 different networks here? Are you using a class B subnet? (E.g.
255.255.0.0) if so, this is ok, otherwise your laptop which seems to be at
192.168.4.1 will not be able to see either access point at 192.168.3.4 and
192.168.3.3 respectively...

Why not put everything on the same subnet?

Accesspoint 1 192.168.3.2
Accesspoint 2 192.168.3.3
Laptop 192.168.3.4
Router 192.168.3.1

Also, if your router is a different box than the Access point, then your
static route shouldn't point to the Access Point, it should be pointing to
the router IP...

Sounds like maybe you have some confusion with how to use IP subnetting? If
not I appologize, I may not be understanding correctly...

Hope this helps!

-Chris

