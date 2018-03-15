Return-Path: <arend.vanspriel@broadcom.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
	h=subject:to:references:cc:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-transfer-encoding;
	bh=7/lSj80AZ7Wx9+YDtI3Yw9P+JQm9uS4iU8L9RQ8qOXA=;
	b=NABCiouhOLpESGbGc10Xi9UXGmYaoaYhifitdmNjNC2nm909UVw/bQpVneYsC1DqhY
	DO95RjiK+ClvqcWrpDcjGSo05D/hZZSJdRF240Q+WvzQj0LtURiONopnwUKEXACmIMlh
	dylMVv02gv98A2kN6AAG7ZYiybr2IzD3l0gqg=
References: <20180315072909.1512-1-zajec5@gmail.com>
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AAA308D.4090100@broadcom.com>
MIME-Version: 1.0
In-Reply-To: <20180315072909.1512-1-zajec5@gmail.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
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
Date: Thu, 15 Mar 2018 08:36:35 -0000
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>, Kalle Valo <kvalo@codeaurora.org>
Cc: James Hughes <james.hughes@raspberrypi.org>, brcm80211-dev-list.pdl@broadcom.com, netdev@vger.kernel.org, Chi-Hsien Lin <chi-hsien.lin@cypress.com>, bridge@lists.linux-foundation.org, linux-wireless@vger.kernel.org, Hante Meuleman <hante.meuleman@broadcom.com>, Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>, Wright Feng <wright.feng@cypress.com>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Felix Fietkau <nbd@nbd.name>, brcm80211-dev-list@cypress.com, Franky Lin <franky.lin@broadcom.com>

On 3/15/2018 8:29 AM, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
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
>     disassociation perfromed by a firmware (possible local DoS attack).
>
> It appears there are some Broadcom's clients/users who care about this
> feature despite the drawbacks. They can switch it on using a new module
> param.
>
> This change results in only two more comparisons (check for module param
> and check for Ethernet packet length) for 99.9% of packets. Its overhead
> should be very minimal.

Hi Rafał,

Thanks for this patch.

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   .../wireless/broadcom/brcm80211/brcmfmac/common.c  |  5 ++
>   .../wireless/broadcom/brcm80211/brcmfmac/common.h  |  1 +
>   .../wireless/broadcom/brcm80211/brcmfmac/core.c    | 57 ++++++++++++++++++++++
>   3 files changed, 63 insertions(+)

