Return-Path: <zajec5@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=poY9vLDjLynuLqjy1/SAXOJaP9RqS/zgdG7Eqm6H2Qg=;
	b=HExFYPRBDxuM9BRWOdWjjlVXSCFMO6R4nEElnOj0m6toBVEhau+c9No1H0dGy20V20
	oVA9Ln+QtcjoFcIBXGUVdBNEPZ81TGVe5HRyhMARUMZ0ULVTe22yRq9D9X9uQ0LL4shA
	hwQXCqainpV0HphOfU1uvXTqn/wS6u34VtIO1jR1h5WGE/HINMac8Yw541139uc0l3X3
	+uI4XqEqkYjQPgwAl1OkqP2yB2jERyW0HzoXlRbrwroq1iwrLXn2GuUSwURZA7ZUgFq+
	KCYpJZBfQJ/aW7gk7rZ7MVg4a5tN3KoKWybrf+T9n71zsTabc/XjG8scj6mueg6gzUIe
	wJaQ==
MIME-Version: 1.0
In-Reply-To: <20180315072909.1512-1-zajec5@gmail.com>
References: <20180315072909.1512-1-zajec5@gmail.com>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Message-ID: <CACna6ryQjhzXTbB0SBC_e_sJibhYyDjctOowhiVv_FMF6jEh3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Bridge] [PATCH V2] brcmfmac: drop Inter-Access Point Protocol
	packets by default
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
Date: Thu, 15 Mar 2018 07:34:38 -0000
To: Kalle Valo <kvalo@codeaurora.org>
Cc: James Hughes <james.hughes@raspberrypi.org>, Arend van Spriel <arend.vanspriel@broadcom.com>, Network Development <netdev@vger.kernel.org>, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, bridge@lists.linux-foundation.org, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Hante Meuleman <hante.meuleman@broadcom.com>, Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>, "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" <brcm80211-dev-list.pdl@broadcom.com>, Wright Feng <wright.feng@cypress.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Felix Fietkau <nbd@nbd.name>, "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER
	<brcm80211-dev-list.pdl@broadcom.com>, " <brcm80211-dev-list@cypress.com>, Franky Lin <franky.lin@broadcom.com>

On 15 March 2018 at 08:29, Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> wrote=
:
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> Testing brcmfmac with more recent firmwares resulted in AP interfaces
> not working in some specific setups. Debugging resulted in discovering
> support for IAPP in Broadcom's firmwares.
>
> Older firmwares were only generating 802.11f frames. Newer ones like:
> 1) 10.10 (TOB) (r663589)
> 2) 10.10.122.20 (r683106)
> for 4366b1 and 4366c0 respectively seem to also /respect/ 802.11f frames
> in the Tx path by performing a STA disassociation.
>
> This obsoleted standard and its implementation is something that:
> 1) Most people don't need / want to use
> 2) Can allow local DoS attacks
> 3) Breaks AP interfaces in some specific bridge setups
>
> To solve issues it can cause this commit modifies brcmfmac to drop IAPP
> packets. If affects:
> 1) Rx path: driver won't be sending these unwanted packets up.
> 2) Tx path: driver will reject packets that would trigger STA
>    disassociation perfromed by a firmware (possible local DoS attack).
>
> It appears there are some Broadcom's clients/users who care about this
> feature despite the drawbacks. They can switch it on using a new module
> param.
>
> This change results in only two more comparisons (check for module param
> and check for Ethernet packet length) for 99.9% of packets. Its overhead
> should be very minimal.
>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---

I forgot to include the changelog, sorry.

V2: Use module param to don't /abuse/ Kconfig
    Slightly optimize brcmf_skb_is_iapp
    Move some description from Kconfig to the code
    Update commit description: specify affected fws & mention impact
