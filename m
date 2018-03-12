Return-Path: <zajec5@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=Q6J1AKg2TuPyOkx82nHWhGkqBZqgHdy7/qo4/uC+jq4=;
	b=jMBQEtipmzmyC/fdrDCmx4ug3e0jYLhmhRQfUh8gHQeR65/Jf6T1JRl2yxLnqRr1i2
	Yjf31WOZcLnC90mlWTMI0OhP4JxXQLyEZUevwg7FjJ5ZyZ8t+Bw7t6NMuq61wJnEWpJ7
	NyM/7uG4TzdUvW84ifw+MEWMYhReHoYM6vEcxVsOG+VOzDH6U+f9O4HyNlBJHrs0gjdT
	PD+ArIeeqoQhlEeEl3ms/EoYxKXAR5IGyjPpsvYLLy9SrI6B9+GU06jZFjQSiuuGCFrY
	oPI0O1uAWrJ11sj8HSrO9UWjSzjAxWU0z7V2qlHkJn+puonanCqJBWAR772IEdXvWhcC
	3cOg==
MIME-Version: 1.0
In-Reply-To: <20180312110856.GL2470@otheros>
References: <CACna6rz9L09g9oeHhvt209Tg1E3gKgmhGnYF653AdkXfZf=4kw@mail.gmail.com>
	<20180312110856.GL2470@otheros>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <CACna6rwHetzUN+SGD8SHa1V_O-MQDTQRKd_VUQn_iaHW6cdp=A@mail.gmail.com>
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
Date: Mon, 12 Mar 2018 21:49:53 -0000
To: =?UTF-8?Q?Linus_L=C3=BCssing?= <linus.luessing@c0d3.blue>
Cc: "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" <brcm80211-dev-list.pdl@broadcom.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, Network Development <netdev@vger.kernel.org>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, bridge@lists.linux-foundation.org, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Hante Meuleman <hante.meuleman@broadcom.com>, Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>, Wright Feng <wright.feng@cypress.com>, Felix Fietkau <nbd@nbd.name>, "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER
	<brcm80211-dev-list.pdl@broadcom.com>, " <brcm80211-dev-list@cypress.com>, Franky Lin <franky.lin@broadcom.com>

On 12 March 2018 at 12:08, Linus L=C3=BCssing <linus.luessing@c0d3.blue> wr=
ote:
> On Tue, Feb 27, 2018 at 11:08:20AM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
>> I've problem when using OpenWrt/LEDE on a home router with Broadcom's
>> FullMAC WiFi chipset.
>
> Hi Rafa=C5=82,
>
> Thanks for reporting this issue!
>
>> Can you see any solution for this problem? Is that an option to stop
>> multicast-to-unicast from touching 802.11f packets? Some other ideas?
>> Obviously I can't modify Broadcom's firmware and drop that obsoleted
>> standard.
>
> Just to avoid some potential confusion: This is more an issue of
> hairpinning than it is an issue of multicast-to-unicast per se,
> right?
>
> That is, if you set this to 0 manually:
> /sys/class/net/<ap-iface>/brport/multicast_to_unicast
> Then the issue still occurs, right?

I can't really tell, I didn't go into details on bridge +
mcast-to-unicast + hairpin.

By default OpenWrt/LEDE sets
/sys/class/net/<ap-iface>/brport/multicast_to_unicast
to 1. Changing it to 0 (with a simple echo) doesn't /fix/ the problem.

--=20
Rafa=C5=82
