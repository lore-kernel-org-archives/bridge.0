Return-Path: <zajec5@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=842sQDKdlY8W6JfNiR85+7zrjqw7LEOZRwy++JvhKHo=;
	b=aXQcyiJaDNsMYZGsmvXAhfiW/+N7bZmSczAHixNzVVnBWgaOtodavY4xMfS0Zv8N0R
	agjw7831gwkmG+Wi5Ibh0KPYUAHolkx5C4WbLoc8Fke1oJNtr34p2e6HWR7tpSz9oL9f
	GOS30eHIHFF4C2L62p7q+sO3Iko95kb/9777K3kqrOqf3z/fkZUQ3fs1wA6VSthhn4k3
	yghdsMU7l3s4xcBn64o08TCgjWMz8jIqy0wq4D1+wJOxgU4s/ZBDeZOraoLAsF4DP3zu
	b3dqoDAvL6MFlaIFISnVa2XbWwCn7fIz6yVxrmsraNKmwCNLgIaU5y+AKg6OVft0a/TV
	ep9g==
MIME-Version: 1.0
In-Reply-To: <20180312114815.GN2470@otheros>
References: <CACna6rz9L09g9oeHhvt209Tg1E3gKgmhGnYF653AdkXfZf=4kw@mail.gmail.com>
	<20180312110856.GL2470@otheros> <20180312114815.GN2470@otheros>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <CACna6ryTv0XOREodnERjA4irX0_XdoG95bjQVShqDC+BA3fRLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Date: Mon, 12 Mar 2018 21:52:17 -0000
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" <brcm80211-dev-list.pdl@broadcom.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, Network Development <netdev@vger.kernel.org>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, bridge@lists.linux-foundation.org, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Hante Meuleman <hante.meuleman@broadcom.com>, Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>, Wright Feng <wright.feng@cypress.com>, Felix Fietkau <nbd@nbd.name>, "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER
	<brcm80211-dev-list.pdl@broadcom.com>, " <brcm80211-dev-list@cypress.com>, Franky Lin <franky.lin@broadcom.com>

On 12 March 2018 at 12:48, Linus L=C3=BCssing <linus.luessing@c0d3.blue> wr=
ote:
> On Mon, Mar 12, 2018 at 12:08:56PM +0100, Linus L=C3=BCssing wrote:
>> On Tue, Feb 27, 2018 at 11:08:20AM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
>> > I've problem when using OpenWrt/LEDE on a home router with Broadcom's
>> > FullMAC WiFi chipset.
>>
>> Hi Rafa=C5=82,
>>
>> Thanks for reporting this issue!
>>
>> > Can you see any solution for this problem? Is that an option to stop
>> > multicast-to-unicast from touching 802.11f packets? Some other ideas?
>> > Obviously I can't modify Broadcom's firmware and drop that obsoleted
>> > standard.
>>
>> Just to avoid some potential confusion: This is more an issue of
>> hairpinning than it is an issue of multicast-to-unicast per se,
>> right?
>>
>> That is, if you set this to 0 manually:
>> /sys/class/net/<ap-iface>/brport/multicast_to_unicast
>> Then the issue still occurs, right?
>
> Btw., if in OpenWRT/LEDE you set 'option multicast_to_unicast 0'
> in /etc/config/network for the bridge (and not bridge port)
> then netifd should refrain from setting the bridge hairpinning and
> AP isolation on wireless devices, too, if I remember correctly.
>
> Can you confirm that the issue disappears for you then?

Yes, absolutely. This reverts OpenWrt/LEDE to the old setup (no
mcast-to-ucast + hairpin) and it works. I was hoping we can make
mcast-to-ucast + hairpin work with Broadcom's 802.11f however instead
of moving OpenWrt/LEDE back to the old setup.

--=20
Rafa=C5=82
