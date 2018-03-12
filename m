Return-Path: <zajec5@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=HNCNgmmZMIj99jh0O/iLbDfoRi7odciqDpNG/h9WQes=;
	b=h0h99p3xo3qSkqEaOf28jXgLnNbiGY7qpHTHmRwDkwAQlbQYvEewfeNpw6T/3j8f24
	CB4oAPcDbZah0LhpJSzaJ4jnJpXHep4rwb1W8nSxEmXTfDuxvoavjCP5YeE8kf7Arph0
	Awpxo9olhJx5SghIzKeuyqq33Afnr1M26A4pOJ8uDtXM0DVOPI2kLdINjcvOhYQw9IVT
	b00SfNhecpTGED3U54992Xb/6WCA0NFobONhZqDFeUZj/0682tBieSLDMjY/t9UHlpCN
	V2tLpEfz6ZM1mBOT2c9mdND+HKO/3+BUN4lheQIfoNhOvEYxY8IkqXpSU/TtOKCrltEW
	0Cgg==
MIME-Version: 1.0
In-Reply-To: <20180227090556.02a24a0d@xeon-e3>
References: <CACna6rz9L09g9oeHhvt209Tg1E3gKgmhGnYF653AdkXfZf=4kw@mail.gmail.com>
	<20180227090556.02a24a0d@xeon-e3>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <CACna6rxP4ATE2f6XJi7XKDLe2L_Z43aLreEHDCfGicksYTb0xg@mail.gmail.com>
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
Date: Mon, 12 Mar 2018 09:46:47 -0000
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>, Network Development <netdev@vger.kernel.org>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, bridge@lists.linux-foundation.org, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Hante Meuleman <hante.meuleman@broadcom.com>, Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>, Wright Feng <wright.feng@cypress.com>, Felix Fietkau <nbd@nbd.name>, "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER
	<brcm80211-dev-list.pdl@broadcom.com>, " <brcm80211-dev-list@cypress.com>, Franky Lin <franky.lin@broadcom.com>

On 27 February 2018 at 18:05, Stephen Hemminger
<stephen@networkplumber.org> wrote:
> On Tue, 27 Feb 2018 11:08:20 +0100
> Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> wrote:
>
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
>>
>
> ebtables is your friend in dealing with weird and broken devices.

It may be weird, not sure if actually broken. Anyway I'd like to have
some generic solution instead of telling every user to use ebtables to
workaround the problem.

--=20
Rafa=C5=82
