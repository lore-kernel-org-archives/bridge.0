Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BS2nmejjK8PFe/qEJ+mPxfa0gAg77/DJy1RcdnRmJqo=;
 b=kDxSK0Pm+zdmrkB5fd83GDsg1eEmfcLeRDiPeLtUqPUraM/MgAaxOzQuexkQs5YsCm
 XxWSHF9v3a+3gSjRvgG5G7Y1wXGXm4lEnUvvjcDq4tbNyfsd72ZO+d8cgpJqzisZzEb8
 zPPcoyVh/u6RrMbduwuFjE4XHF/+hpyOBLqVJ7WRfM0Nxdi2gazt64njfM3alph30t3t
 hNhAsBXTiuX34GYiDlUKFZ6NjJ0c+d8n0KVh89xRVL1m9tGao9Jmgb22wBVfJWb6/QAe
 ZzISWiXMlZaaASyCKjAHIKr6oLKmUMWQl0rZFSO+xmDactrcpyWgY5+y9Q23VIpr0hvQ
 7UUQ==
Date: Sun, 23 Aug 2020 10:19:38 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20200823101938.0f956d96@hermes.lan>
In-Reply-To: <20200823154239.GA2302@otheros>
References: <20200816202424.3526-1-linus.luessing@c0d3.blue>
 <20200816150813.0b998607@hermes.lan>
 <20200823154239.GA2302@otheros>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [RFC PATCH net-next] bridge: Implement MLD Querier
 wake-up calls / Android bug workaround
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Linus =?UTF-8?B?TMO8c3Npbmc=?= <linus.luessing@c0d3.blue>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, gluon@luebeck.freifunk.net, openwrt-devel@lists.openwrt.org, "David S . Miller" <davem@davemloft.net>

On Sun, 23 Aug 2020 17:42:39 +0200
Linus L=C3=BCssing <linus.luessing@c0d3.blue> wrote:

> On Sun, Aug 16, 2020 at 03:08:13PM -0700, Stephen Hemminger wrote:
> > Rather than adding yet another feature to the bridge, could this hack b=
e done by
> > having a BPF hook? or netfilter module? =20
>=20
> Hi Stephen,
>=20
> Thanks for the constructive feedback and suggestions!
>=20
> The netfilter approach sounds tempting. However as far as I know
> OpenWrt's firewall has no easy layer 2 netfilter integration yet.
> So it has default layer 3 netfilter rules, but not for layer 2.
>=20
> Ideally I'd want to work towards a solution where things "just
> work as expected" when a user enables "IGMP Snooping" in the UI.
> I could hack the netfilter rules into netifd, the OpenWrt network
> manager, when it configures the bridge. But not sure if the
> OpenWrt maintainers would like that...
>=20
> Any preferences from the OpenWrt maintainers side?
>=20
> Regards, Linus
>=20
>=20
> PS: With BPF I don't have that much experience yet. I would need
> to write a daemon which would parse the MLD packets and would
> fetch the FDB via netlink, right? If so, sounds like that would
> need way more than 300 lines of code. And that would need to be
> maintained within OpenWrt, right?

With BPF you would need to write a small program that transforms the packet
as you want. The BPF program and the userspace program would share a
map table.  The userspace program would monitor netlink messages about
FDB and update the map. Yes it would be a few hundred lines but not huge.
The userspace could even be selective and only do it for devices where
it knows they are using the broken Android code.

Sorry, no idea how OpenWrt manages their packages.
