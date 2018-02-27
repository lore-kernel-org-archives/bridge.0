Return-Path: <zajec5@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=HZgILjf8U79N4wVzp+962IPePqoHATV/+WM8VkxVHhI=;
	b=t4eYtEeBCLRjwgwDEjNxqiEs+V2S745BfIrNKGMQ1/WRn4GnOejrnfvH8f8ncWbIF+
	mT4LkKR2vyKfJi2VUv8glvBatuXlbUoaWEhlMCYLaYTTKPkiaa3kW+kkawawf3hkVHdg
	i5d+WPejJPSQDkYphQddWor1JC7wpIa33WkIqbrYotAxeiPI3tULP/5nMiZnh8ILnX7U
	MjRdEoCkUFZJYa1R1E7CGTYoDtbnF/Aa4QS5G8GAfLbccOnxkjssKq4ThRilgvrpt5Hj
	MrnI5FqnaVN8E/ph4eyASWC1i4FLu3Br5TGT9d47geIHHNS+ixv/x29aRz1/SC2jccji
	Rrgg==
References: <CACna6rz9L09g9oeHhvt209Tg1E3gKgmhGnYF653AdkXfZf=4kw@mail.gmail.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <88d080df-4cce-98d1-6482-0408a3dcb015@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACna6rz9L09g9oeHhvt209Tg1E3gKgmhGnYF653AdkXfZf=4kw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
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
Date: Tue, 27 Feb 2018 10:14:31 -0000
To: =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, Felix Fietkau <nbd@nbd.name>, Arend van Spriel <arend.vanspriel@broadcom.com>, Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, Wright Feng <wright.feng@cypress.com>, Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Cc: Network Development <netdev@vger.kernel.org>, "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" <brcm80211-dev-list.pdl@broadcom.com>, bridge@lists.linux-foundation.org, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, brcm80211-dev-list@cypress.com

Sending with a fixed linux-wireless ML address. Please kindly send your
replies using linux-wireless@

On 02/27/2018 11:08 AM, Rafał Miłecki wrote:
> I've problem when using OpenWrt/LEDE on a home router with Broadcom's
> FullMAC WiFi chipset.
>
>
> First of all OpenWrt/LEDE uses bridge interface for LAN network with:
> 1) IFLA_BRPORT_MCAST_TO_UCAST
> 2) Clients isolation in hostapd
> 3) Hairpin mode enabled
>
> For more details please see Linus's patch description:
> https://patchwork.kernel.org/patch/9530669/
> and maybe hairpin mode patch:
> https://lwn.net/Articles/347344/
>
> Short version: in that setup packets received from a bridged wireless
> interface can be handled back to it for transmission.
>
>
> Now, Broadcom's firmware for their FullMAC chipsets in AP mode
> supports an obsoleted 802.11f AKA IAPP standard. It's a roaming
> standard that was replaced by 802.11r.
>
> Whenever a new station associates, firmware generates a packet like:
> ff ff ff ff  ff ff ec 10  7b 5f ?? ??  00 06 00 01  af 81 01 00
> (just masked 2 bytes of my MAC)
>
> For mode details you can see discussion in my brcmfmac patch thread:
> https://patchwork.kernel.org/patch/10191451/
>
>
> The problem is that bridge (in setup as above) handles such a packet
> back to the device.
>
> That makes Broadcom's FullMAC firmware believe that a given station
> just connected to another AP in a network (which doesn't even exist).
> As a result firmware immediately disassociates that station. It's
> simply impossible to connect to the router. Every association is
> followed by immediate disassociation.
>
>
> Can you see any solution for this problem? Is that an option to stop
> multicast-to-unicast from touching 802.11f packets? Some other ideas?
> Obviously I can't modify Broadcom's firmware and drop that obsoleted
> standard.
