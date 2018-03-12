Return-Path: <zajec5@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=ybWeATIJaxTJSTEswYs8EE9cVODm8BNC09XFii2fMS0=;
	b=uVwywgl9T5RNBjB1s6OW00KdylHyelZa9oJQlulShi127jwdjBFTjidEXWRtSUpM6E
	YfJvsEW97h7dSp7V1gNrqyl7IPcop9Gvfw2usc5hAJAeLwjq91xm6F4hqn15PyidjZeW
	O4Apg7S4Ufv5kjRDKV+w0+kI7QZH/ifZEU3pQTQ8fbMxk8m/uwbIhJvqlPqCOdhyRgK+
	EqZY5RlOWXGbhBgL/AZb1oRPcOvml7kFM/Fc9Ml3zIUjq3aXLAVwN7zUdJWdKaBq1qB9
	6iIcjWNmg12Z6UvSF+QPXoF3DA7OYFNHCUSQWQmKpr+M+RnAymHG4meCQj14+CCJvHZN
	sBwg==
MIME-Version: 1.0
In-Reply-To: <5A969313.5050501@broadcom.com>
References: <CACna6rz9L09g9oeHhvt209Tg1E3gKgmhGnYF653AdkXfZf=4kw@mail.gmail.com>
	<88d080df-4cce-98d1-6482-0408a3dcb015@gmail.com>
	<5A969313.5050501@broadcom.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <CACna6rwbEAshSi4hFHFu5dAinwbXKrwoSkB0NWmQki7-VkX0Rg@mail.gmail.com>
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
Date: Mon, 12 Mar 2018 09:49:06 -0000
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" <brcm80211-dev-list.pdl@broadcom.com>, Network Development <netdev@vger.kernel.org>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, bridge@lists.linux-foundation.org, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Hante Meuleman <hante.meuleman@broadcom.com>, Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>, Wright Feng <wright.feng@cypress.com>, Felix Fietkau <nbd@nbd.name>, "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER
	<brcm80211-dev-list.pdl@broadcom.com>, " <brcm80211-dev-list@cypress.com>, Franky Lin <franky.lin@broadcom.com>

On 28 February 2018 at 12:31, Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
> On 2/27/2018 11:14 AM, Rafa=C5=82 Mi=C5=82ecki wrote:
>>
>> Sending with a fixed linux-wireless ML address. Please kindly send your
>> replies using linux-wireless@
>>
>> On 02/27/2018 11:08 AM, Rafa=C5=82 Mi=C5=82ecki wrote:
>>>
>>> I've problem when using OpenWrt/LEDE on a home router with Broadcom's
>>> FullMAC WiFi chipset.
>>>
>>>
>>> First of all OpenWrt/LEDE uses bridge interface for LAN network with:
>>> 1) IFLA_BRPORT_MCAST_TO_UCAST
>>> 2) Clients isolation in hostapd
>>> 3) Hairpin mode enabled
>>>
>>> For more details please see Linus's patch description:
>>> https://patchwork.kernel.org/patch/9530669/
>>> and maybe hairpin mode patch:
>>> https://lwn.net/Articles/347344/
>>>
>>> Short version: in that setup packets received from a bridged wireless
>>> interface can be handled back to it for transmission.
>>>
>>>
>>> Now, Broadcom's firmware for their FullMAC chipsets in AP mode
>>> supports an obsoleted 802.11f AKA IAPP standard. It's a roaming
>>> standard that was replaced by 802.11r.
>>>
>>> Whenever a new station associates, firmware generates a packet like:
>>> ff ff ff ff  ff ff ec 10  7b 5f ?? ??  00 06 00 01  af 81 01 00
>>> (just masked 2 bytes of my MAC)
>>>
>>> For mode details you can see discussion in my brcmfmac patch thread:
>>> https://patchwork.kernel.org/patch/10191451/
>>>
>>>
>>> The problem is that bridge (in setup as above) handles such a packet
>>> back to the device.
>
>
> From reading the referenced links I understand the hairpin mode is causin=
g
> the packet to be sent back to the device, and the hairpin mode is require=
d
> for MCAST_TO_UCAST, right?
>
>>> That makes Broadcom's FullMAC firmware believe that a given station
>>> just connected to another AP in a network (which doesn't even exist).
>>> As a result firmware immediately disassociates that station. It's
>>> simply impossible to connect to the router. Every association is
>>> followed by immediate disassociation.
>>>
>>>
>>> Can you see any solution for this problem? Is that an option to stop
>>> multicast-to-unicast from touching 802.11f packets? Some other ideas?
>>> Obviously I can't modify Broadcom's firmware and drop that obsoleted
>>> standard.
>
>
> As far as I can tell you are correct that the 802.11f amendment was never
> adopted into the 802.11 standard. I will ask internally if we still have =
a
> reason for carrying it in our firmware.

Thanks! Having at least a way to disable it would be nice.

That said I think we still should look for a solution for existing
firmwares. I guess it may takes months to years to never to release
new firmwares for all supported chipsets.

--=20
Rafa=C5=82
