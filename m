Return-Path: <stephen@networkplumber.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=mT3SAA+givHB6f6KHamQh+MmpKRRciPaKbqjT1zIRPU=;
	b=rbyfwfu/AgBLqLODXoOCC7YmmUk5B9yD30wDTK8y5c0EUbm1fzwij71u5Eatmtv5Sh
	9lngzPyZ2GxufIcQdZn3wMNTD/Y46Gj7lWfSSGRCayYHce83MTVjtuTLC96PMdCE2obl
	BlRo7NZx5lm62Tig1HhgTrAV4h0u/4Vc7fENjwFIcBVEKjoAhNsLXUM3PNBUjxhzFvi6
	1hC03kKVLATa/btDPsTS5SL384i0Dgnd3ybhep9bG3ZWqHsT8U081m4sIHhZuauZ/PnU
	WXguVIKCWAmDeRh4q45mvmX1DmjK0ZSARBNKhuPqbKaL7A7uCsRE6to/DUDoJ994FCGd
	hTiw==
Date: Tue, 27 Feb 2018 09:05:56 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
Message-ID: <20180227090556.02a24a0d@xeon-e3>
In-Reply-To: <CACna6rz9L09g9oeHhvt209Tg1E3gKgmhGnYF653AdkXfZf=4kw@mail.gmail.com>
References: <CACna6rz9L09g9oeHhvt209Tg1E3gKgmhGnYF653AdkXfZf=4kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] Problem with bridge (mcast-to-ucast + hairpin) and
 Broadcom's 802.11f in their FullMAC fw
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, BROADCOM

On Tue, 27 Feb 2018 11:08:20 +0100
Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> wrote:

> I've problem when using OpenWrt/LEDE on a home router with Broadcom's
> FullMAC WiFi chipset.
>=20
>=20
> First of all OpenWrt/LEDE uses bridge interface for LAN network with:
> 1) IFLA_BRPORT_MCAST_TO_UCAST
> 2) Clients isolation in hostapd
> 3) Hairpin mode enabled
>=20
> For more details please see Linus's patch description:
> https://patchwork.kernel.org/patch/9530669/
> and maybe hairpin mode patch:
> https://lwn.net/Articles/347344/
>=20
> Short version: in that setup packets received from a bridged wireless
> interface can be handled back to it for transmission.
>=20
>=20
> Now, Broadcom's firmware for their FullMAC chipsets in AP mode
> supports an obsoleted 802.11f AKA IAPP standard. It's a roaming
> standard that was replaced by 802.11r.
>=20
> Whenever a new station associates, firmware generates a packet like:
> ff ff ff ff  ff ff ec 10  7b 5f ?? ??  00 06 00 01  af 81 01 00
> (just masked 2 bytes of my MAC)
>=20
> For mode details you can see discussion in my brcmfmac patch thread:
> https://patchwork.kernel.org/patch/10191451/
>=20
>=20
> The problem is that bridge (in setup as above) handles such a packet
> back to the device.
>=20
> That makes Broadcom's FullMAC firmware believe that a given station
> just connected to another AP in a network (which doesn't even exist).
> As a result firmware immediately disassociates that station. It's
> simply impossible to connect to the router. Every association is
> followed by immediate disassociation.
>=20
>=20
> Can you see any solution for this problem? Is that an option to stop
> multicast-to-unicast from touching 802.11f packets? Some other ideas?
> Obviously I can't modify Broadcom's firmware and drop that obsoleted
> standard.
>=20

ebtables is your friend in dealing with weird and broken devices.
