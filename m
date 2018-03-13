Return-Path: <arend.vanspriel@broadcom.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=Ztus7rqOnSGZQBjCBXVgvhq1o9diWWCBckYGb10IQgE=;
	b=hBdgLZdb2ez+ixkBpd2R11NpnbrnU0sdTRQqI7MZHw+OfIuLdKD78orhf2wJnd8ZiJ
	VjkqxdLi+sps0clX7N6wCA+HOSTlNJz63biTzsqFTb9DRFKNaF5P05qcz+VNShKR/tH1
	U+lsiT4qUe7EU4Y7BWhpVdfiC1HCUEMKLQo/s=
References: <CACna6rz9L09g9oeHhvt209Tg1E3gKgmhGnYF653AdkXfZf=4kw@mail.gmail.com>
	<c24304cf-7e0d-137a-94b1-d8f4e61a3b70@nbd.name>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AA79752.8070200@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <c24304cf-7e0d-137a-94b1-d8f4e61a3b70@nbd.name>
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
Date: Tue, 13 Mar 2018 09:18:15 -0000
To: Felix Fietkau <nbd@nbd.name>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>, Franky Lin <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, Wright Feng <wright.feng@cypress.com>, Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>
Cc: Network Development <netdev@vger.kernel.org>, "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" <brcm80211-dev-list.pdl@broadcom.com>, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, brcm80211-dev-list@cypress.com

On 3/13/2018 8:20 AM, Felix Fietkau wrote:
> [resent with fixed typo in linux-wireless address]
>
> On 2018-02-27 11:08, Rafał Miłecki wrote:
>> I've problem when using OpenWrt/LEDE on a home router with Broadcom's
>> FullMAC WiFi chipset.
>>
>>
>> First of all OpenWrt/LEDE uses bridge interface for LAN network with:
>> 1) IFLA_BRPORT_MCAST_TO_UCAST
>> 2) Clients isolation in hostapd
>> 3) Hairpin mode enabled
>>
>> For more details please see Linus's patch description:
>> https://patchwork.kernel.org/patch/9530669/
>> and maybe hairpin mode patch:
>> https://lwn.net/Articles/347344/
>>
>> Short version: in that setup packets received from a bridged wireless
>> interface can be handled back to it for transmission.
>>
>>
>> Now, Broadcom's firmware for their FullMAC chipsets in AP mode
>> supports an obsoleted 802.11f AKA IAPP standard. It's a roaming
>> standard that was replaced by 802.11r.
>>
>> Whenever a new station associates, firmware generates a packet like:
>> ff ff ff ff  ff ff ec 10  7b 5f ?? ??  00 06 00 01  af 81 01 00
>> (just masked 2 bytes of my MAC)
>>
>> For mode details you can see discussion in my brcmfmac patch thread:
>> https://patchwork.kernel.org/patch/10191451/
>>
>>
>> The problem is that bridge (in setup as above) handles such a packet
>> back to the device.
>>
>> That makes Broadcom's FullMAC firmware believe that a given station
>> just connected to another AP in a network (which doesn't even exist).
>> As a result firmware immediately disassociates that station. It's
>> simply impossible to connect to the router. Every association is
>> followed by immediate disassociation.
>>
>>
>> Can you see any solution for this problem? Is that an option to stop
>> multicast-to-unicast from touching 802.11f packets? Some other ideas?
>> Obviously I can't modify Broadcom's firmware and drop that obsoleted
>> standard.
> Let's look at it from a different angle: Since these packets are
> forwarded as normal packets by the bridge, and the Broadcom firmware
> reacts to them in this nasty way, that's basically local DoS security
> issue. In my opinion that matters a lot more than having support for an
> obsolete feature that almost nobody will ever want to use.
>
> I think the right approach to deal with this issue is to drop these
> garbage packets in both the receive and transmit path of brcmfmac.

My approach was to get rid of it in firmware as this never made it into 
the 802.11 spec. So I asked internally whether it was still used. Turns 
out that we still rely on it for some customers. I am fine with dropping 
these "garbage" packets, but given that there is still use for it I 
would like to see that under a Kconfig flag. Dropping it may be the default.

Regards,
Arend

