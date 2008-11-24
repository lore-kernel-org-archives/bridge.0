Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Nov 2008 12:20:23 +0100
Message-ID: <7B7881568CF40E4388B615CD06F87B98057A05@clara.maurer-it.com>
In-Reply-To: <492A8A22.1090509@gmxpro.de>
References: <492A8A22.1090509@gmxpro.de>
From: "Dietmar Maurer" <dietmar@proxmox.com>
Subject: Re: [Bridge] Using 2 Bridges Simultaneously for "Load Balancing"
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: noway@gmx.org, bridge@lists.linux-foundation.org

> iface br0 inet static
> 	address xxx.xxx.xxx.1
> 	netmask 255.255.255.0
> 	gateway xxx.xxx.xxx.254
> 	bridge_ports eth0
>=20
> iface br1 inet static
> 	address xxx.xxx.xxx.2
> 	netmask 255.255.255.0
> 	gateway xxx.xxx.xxx.254
> 	bridge_ports eth1

But AFAIK you can only have one gateway in debian.

- Dietmar

