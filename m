Date: Thu, 24 Aug 2006 20:20:32 +0200
From: Marek Kierdelewicz <marek@koba.pl>
Message-ID: <20060824202032.1e27d458@localhost.localdomain>
In-Reply-To: <44EDE259.4050009@dotr.com>
References: <44EDE259.4050009@dotr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] transparent bridge and proxies
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

> Now, for the twist. For development and testing, I assigned an ip=20
> address and gateway to the bridge. I need to be able for a "non-it"=20
> person to install this box without having to set it up at all , so it=20
> cannot have an ip address assigned, as it *may* be in use somewhere
> else on the lan or router.

One sure and elegant solution is using dhcpcd for bridge adressing.
Unfortunately this requires dhcp server on the net. Dhcp would also
ensure ip clashes avoidance.

Loot at http://www.isc.org/index.pl?/sw/dhcp/.

> So, I changed the ip address to 0.0.0.0. Everything except squid
> still worked. I presume that's because it does not know how to route
> the data to get stuff.

I don't think you could make squid work without IP address assigned.

> Can I add a rule to iptables or something to say "anything that's
> come from eth1 into the local box, after processing send to eth0" and=20
> vice-versa ?

Squid needs dns access and needs to know where to direct it's
requests.

regards,
--=20
Marek Kierdelewicz
Kierownik Dzia?u System=F3w Sieciowych, KoBa
Manager of Network Systems Department, KoBa
tel. (85) 7406466; fax. (85) 7406467
e-mail: admin@koba.pl

