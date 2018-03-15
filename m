Return-Path: <kvalo@codeaurora.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1521105795;
	bh=YwYDI8cRNyVG2C1P6mgiDvI4ynE80Qge4I1Klvb+LhQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=gJ7vfOq78VVCVuAqNGGOJ62hSPrv+4b2WbLxDlUUjto3TVxcIXgXJF8VqJBuYzMfy
	lCOluIuHZ2iCWyt4L/YRghxfBJA+0qo0TSVidTPGGdhXmXztvRNANqj0tRmC8UFt6N
	hAms4KJiol3Om7m9h+GgBQc7OZ0Ufae42S6ZMCMY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1521105793;
	bh=YwYDI8cRNyVG2C1P6mgiDvI4ynE80Qge4I1Klvb+LhQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=P9a2Nto5zwAEhUMu0p/8yC884dGPaL6ycY920qK4n56VBulYhTm3yuR8slz5COa2u
	L36PxrdTGSlMlx96tjXH1Wo83TEuXzNsT/YQDs+n5LmQ9tlXYxu/N7pvUbER61jgu6
	+6EotWV8qScLLpmXRLfoIFbuczj+FTzu4+czX0AY=
From: Kalle Valo <kvalo@codeaurora.org>
References: <20180314110119.13631-1-zajec5@gmail.com>
	<878tau7n23.fsf@codeaurora.org>
	<52b1812dd3e843adb63ff67fbe95975f@milecki.pl>
	<877eqe63kr.fsf@codeaurora.org> <5AA98C3B.2070406@broadcom.com>
In-Reply-To: <5AA98C3B.2070406@broadcom.com> (Arend van Spriel's message of
	"Wed, 14 Mar 2018 21:55:23 +0100")
Message-ID: <87k1ud7kw4.fsf@kamboji.qca.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH] brcmfmac: drop Inter-Access Point Protocol
	packets by default
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Thu, 15 Mar 2018 09:23:15 -0000
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: James Hughes <james.hughes@raspberrypi.org>, brcm80211-dev-list.pdl@broadcom.com, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, =?utf-8?Q?Raf?= =?utf-8?Q?a=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, linux-wireless@vger.kernel.org, Hante Meuleman <hante.meuleman@broadcom.com>, Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>, Wright Feng <wright.feng@cypress.com>, =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, Felix Fietkau <nbd@nbd.name>, brcm80211-dev-list@cypress.com, Franky Lin <franky.lin@broadcom.com>

Arend van Spriel <arend.vanspriel@broadcom.com> writes:

> On 3/14/2018 5:10 PM, Kalle Valo wrote:
>> Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl> writes:
>>
>>>>> +	unsigned char *eth_data =3D skb_mac_header(skb) + ETH_HLEN;
>>>>> +#if !defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
>>>>
>>>> #ifndef?
>>>
>>> I followed what is used in the include/linux/etherdevice.h. Is that a
>>> good exceuse? Could it be there any some good reason for #if defined()?
>>
>> Don't know, maybe just a matter of taste? But it would be nice to know
>> the background behind #ifdef vs #if defined(), never figured it out why
>> two different forms.
>
> Well. In this case you could use either one, but if you have more
> conditions #if defined() is bit more efficient:
>
> #ifdef A
> #ifdef B
> #endif
> #endif
>
> vs.
>
> #if defined(A) && defined(B)

Oh yeah, here defined() definitely helps.

--=20
Kalle Valo
