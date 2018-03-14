Return-Path: <arend.vanspriel@broadcom.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=/W8khm62aK064ersf9BbxBRVAXtb6sPuxQ1t0Zt23rk=;
	b=cYRMTASSzx1QtIa2g9m8KKIsgXWLS7O8u3s6T5nJHKrCd4j1EKwTVf8D/Tl3dwmByV
	M2rFLz0lh0YOux8rdsz5UNSl+1eueF2qiTyTMoJj252uy12KoIeMPx0Hv/dl0uIBKc9/
	0eMvgUVGmV/3gpegNfdv2MyYafYU39pcrWSFE=
References: <20180314110119.13631-1-zajec5@gmail.com>
	<878tau7n23.fsf@codeaurora.org>
	<52b1812dd3e843adb63ff67fbe95975f@milecki.pl>
	<877eqe63kr.fsf@codeaurora.org>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AA98C3B.2070406@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <877eqe63kr.fsf@codeaurora.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
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
Date: Wed, 14 Mar 2018 20:55:28 -0000
To: Kalle Valo <kvalo@codeaurora.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc: James Hughes <james.hughes@raspberrypi.org>, brcm80211-dev-list.pdl@broadcom.com, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, linux-wireless@vger.kernel.org, Hante Meuleman <hante.meuleman@broadcom.com>, Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>, Wright Feng <wright.feng@cypress.com>, Felix Fietkau <nbd@nbd.name>, brcm80211-dev-list@cypress.com, Franky Lin <franky.lin@broadcom.com>

On 3/14/2018 5:10 PM, Kalle Valo wrote:
> Rafał Miłecki <rafal@milecki.pl> writes:
>
>>>> +	unsigned char *eth_data = skb_mac_header(skb) + ETH_HLEN;
>>>> +#if !defined(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS)
>>>
>>> #ifndef?
>>
>> I followed what is used in the include/linux/etherdevice.h. Is that a
>> good exceuse? Could it be there any some good reason for #if defined()?
>
> Don't know, maybe just a matter of taste? But it would be nice to know
> the background behind #ifdef vs #if defined(), never figured it out why
> two different forms.

Well. In this case you could use either one, but if you have more 
conditions #if defined() is bit more efficient:

#ifdef A
#ifdef B
#endif
#endif

vs.

#if defined(A) && defined(B)

Regards,
Arend

