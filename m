Return-Path: <zajec5@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:from:date:message-id:subject:to:cc
	:content-transfer-encoding;
	bh=lOBHHHre0Hr6nP383tKtlbjdBxD6k9SYgMotX5hRN0c=;
	b=ZMSwqWCDpVLC0O5GHOHDzgyw2IvZyFSesuFhDCAuWg1aIYfOEl/dzD1klygTnTldhx
	IrTT+5n1vV1RbKy5uBHU9vkEVc0z/R9CuI7SeKogSyfaSPORVdEvtLsrub2F87eOV4o/
	dvaRaVbRrvzznYWRi6+A+/Xp/gFYYu7Et8uPMsNILDgv9bsI0AET56Kqb1QdElureIDU
	SRB9uoWWIskh3tFM8BKfWabV2tUb96jdXOzcft6DX26K6lkCqd36b6gCJeTB5wYPFgVX
	b3mz24pAkzbMjeLPA0iEkj/cv6Lz7FYrLJ5TyPMm3gJ4BRmYIEvGOHoZzkILFEjrbs+2
	rFAg==
MIME-Version: 1.0
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <CACna6rz9L09g9oeHhvt209Tg1E3gKgmhGnYF653AdkXfZf=4kw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Bridge] Problem with bridge (mcast-to-ucast + hairpin) and
 Broadcom's 802.11f in their FullMAC fw
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Tue, 27 Feb 2018 10:08:22 -0000
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>, Felix Fietkau <nbd@nbd.name>, Arend van Spriel <arend.vanspriel@broadcom.com>, Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, Wright Feng <wright.feng@cypress.com>, Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Cc: Network Development <netdev@vger.kernel.org>, "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" <brcm80211-dev-list.pdl@broadcom.com>, bridge@lists.linux-foundation.org, brcm80211-dev-list@cypress.com, inux-wireless@vger.kernel.org

I've problem when using OpenWrt/LEDE on a home router with Broadcom's
FullMAC WiFi chipset.


First of all OpenWrt/LEDE uses bridge interface for LAN network with:
1) IFLA_BRPORT_MCAST_TO_UCAST
2) Clients isolation in hostapd
3) Hairpin mode enabled

For more details please see Linus's patch description:
https://patchwork.kernel.org/patch/9530669/
and maybe hairpin mode patch:
https://lwn.net/Articles/347344/

Short version: in that setup packets received from a bridged wireless
interface can be handled back to it for transmission.


Now, Broadcom's firmware for their FullMAC chipsets in AP mode
supports an obsoleted 802.11f AKA IAPP standard. It's a roaming
standard that was replaced by 802.11r.

Whenever a new station associates, firmware generates a packet like:
ff ff ff ff  ff ff ec 10  7b 5f ?? ??  00 06 00 01  af 81 01 00
(just masked 2 bytes of my MAC)

For mode details you can see discussion in my brcmfmac patch thread:
https://patchwork.kernel.org/patch/10191451/


The problem is that bridge (in setup as above) handles such a packet
back to the device.

That makes Broadcom's FullMAC firmware believe that a given station
just connected to another AP in a network (which doesn't even exist).
As a result firmware immediately disassociates that station. It's
simply impossible to connect to the router. Every association is
followed by immediate disassociation.


Can you see any solution for this problem? Is that an option to stop
multicast-to-unicast from touching 802.11f packets? Some other ideas?
Obviously I can't modify Broadcom's firmware and drop that obsoleted
standard.

--=20
Rafa=C5=82
