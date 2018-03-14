Return-Path: <kvalo@codeaurora.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1521043819;
	bh=6L1J7OporaLSRW/aT7D4J7Mp1b9HdMQJhzG/bmTzE+M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=R4yeTu6QOM5ym8U04R7e7Rc1JLXR39vfYR5IZZPaObq8VdGMYNMw/fhiMq8u2QC5/
	O5YGh3I5GgpAD19/pOHcPkpSv8RAPx6QgBecDejRhE4pMm6q4PT3ctKV2tPf7LVE9u
	9Vuw51QAo9Sj5NiBFg7FFVsFNeHwpTSpT9Fe8MXY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1521043818;
	bh=6L1J7OporaLSRW/aT7D4J7Mp1b9HdMQJhzG/bmTzE+M=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=m8nq2/u/QRBSQKsmJLAzCSdLdsZixvLnLbUukFJ4U52Xa3oc3CGJcu0fD/SFhuqCJ
	yeV/f3j68NeKaYD2bW6RrJNm2YucY3QCMJtg7GmLTQ1VoavXvifZyxLX9Wel1IKuXy
	FJCcDklOJ41QcGgMLyNan2wWbla4030RfFZ6Kt5k=
From: Kalle Valo <kvalo@codeaurora.org>
References: <20180314110119.13631-1-zajec5@gmail.com>
	<878tau7n23.fsf@codeaurora.org>
	<52b1812dd3e843adb63ff67fbe95975f@milecki.pl>
In-Reply-To: <52b1812dd3e843adb63ff67fbe95975f@milecki.pl> (=?utf-8?Q?=22R?=
	=?utf-8?Q?afa=C5=82_Mi=C5=82ecki=22's?=
	message of "Wed, 14 Mar 2018 16:44:43 +0100")
Message-ID: <877eqe63kr.fsf@codeaurora.org>
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
Date: Wed, 14 Mar 2018 16:10:21 -0000
To: =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Cc: James Hughes <james.hughes@raspberrypi.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>, linux-wireless@vger.kernel.org, Hante Meuleman <hante.meuleman@broadcom.com>, Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>, brcm80211-dev-list.pdl@broadcom.com, Wright Feng <wright.feng@cypress.com>, Felix Fietkau <nbd@nbd.name>, brcm80211-dev-list@cypress.com, Franky Lin <franky.lin@broadcom.com>

Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl> writes:

>>> +	unsigned char *eth_data =3D skb_mac_header(skb) + ETH_HLEN;
>>> +#if !defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
>>
>> #ifndef?
>
> I followed what is used in the include/linux/etherdevice.h. Is that a
> good exceuse? Could it be there any some good reason for #if defined()?

Don't know, maybe just a matter of taste? But it would be nice to know
the background behind #ifdef vs #if defined(), never figured it out why
two different forms.

--=20
Kalle Valo
