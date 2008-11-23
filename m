Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Nov 2008 14:29:41 +0100
Message-ID: <7B7881568CF40E4388B615CD06F87B98057A00@clara.maurer-it.com>
In-Reply-To: <ggbi50$cf1$1@ger.gmane.org>
References: <gg92a9$5ot$1@ger.gmane.org> <20081122224021.39238f0c@extreme>
	<ggbi50$cf1$1@ger.gmane.org>
From: "Dietmar Maurer" <dietmar@proxmox.com>
Subject: Re: [Bridge] bridge changes id on addif - is that normal?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Thomas Mueller <thomas@chaschperli.ch>, bridge@osdl.org

> > First off the hardware address of the bridge is by default the
lowest
> of
> > all the interfaces (unless you set it). This was done by original
> author
> > to deal with case of interfaces added out of order on boot.
>=20
> ok, this would be nice if that would be mentioned on the https://
> www.linuxfoundation.org/en/Net:Bridge#FAQ page. I couldn't find any
> information on how the bridge-id is evaluated on searching the
> internet.

Or simply remove that strange behavior - it total nonsense IMO.

- Dietmar

