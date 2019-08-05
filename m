Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=IRwF9LcUlQWxUq9PPqblhb72po/0PsaeK9IhbHvtKSw=;
	b=J8VTnqEcl+q++gkO5ZCmeaPUmNOK6ILcZdiBSqJo0A9e8dNBhIqrJRW3YuA+D3kpdr
	QL37mz/OkJbx7yhpVmEW57PnEBXqHFhWwBjxv7Kpte2ZKkWpVxv2Is4q+nxnOy+rFul3
	vOfaER055skqSa2Np5QydqprkANU+AVb5PkyygjQIPSvkw2kqpQ2MhzeCtLDJ/LfcBj6
	h/4sFHIz71DZDzREXbUe2eGY9i3YpA9gYaafanN3ftHbEE678/wIAty8K9jsA3kImMJc
	cgvyiEdeOsmXYoD99q/VjXaH0XKKdxPjntGsUq4PuqG52/WCexF6LqJxp5wghg9j8XMf
	hkJw==
Date: Mon, 5 Aug 2019 08:32:32 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20190805083232.202d0d47@hermes.lan>
In-Reply-To: <A23F6E83-0634-4BFA-AE82-DA947D3544CF@aim.com>
References: <A23F6E83-0634-4BFA-AE82-DA947D3544CF@aim.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Split path for packets,
 and bridge configuration problem.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: John Clark via Bridge <bridge@lists.linux-foundation.org>
Cc: John Clark <jeclark2006@aim.com>

On Wed, 31 Jul 2019 11:55:37 -0700
John Clark via Bridge <bridge@lists.linux-foundation.org> wrote:

> I=E2=80=99m trying to configure a Linux system to bridge an ethernet link=
 for packet ingress from a local network and combine that with a radio link=
 for the reply packet egress.
>=20
> I vaguely recall something like this use to be used for Satellite links, =
where the incoming packets from the outside world were via the Sat link, bu=
t outgoing packets were via a terrestrial link, phone modem or DSL, dependi=
ng.
>=20
> What I have working is the packet entering the bridge on the ethernet lin=
k, then I see the MAC address of the node from the in the =E2=80=98bridge s=
how=E2=80=99 output, but even if I assign the MAC address to the =E2=80=98r=
adio=E2=80=99 tap interface, I see both the =E2=80=98ethernet=E2=80=99 port=
 as =E2=80=98master=E2=80=99, and the tap device as =E2=80=98self=E2=80=99,=
 but no packets are sent to the tap device.
>=20
> In the past I=E2=80=99ve just written user apps that basically implement =
tunnels and using collection of such apps and taps, gotten packets to where=
 I need them to be.
>=20
> I was trying to use more standard tools, and not write more custom code.
>=20
> Thanks for any assistance.
> John Clark.
>=20

Hacks like this are best done with netfilter.
