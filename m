Return-Path: <roy.qing.li@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=eNyvm9ybJG4bGP25meSwbRH0zRcK+Xe/2oSjY4Ej7Fs=;
	b=tFmjUubj8ElnIQaOj1vuSHa5A7hmMddxiZTZYPi5YL8IO+AYHMJt7s9KsK6byV1WqO
	XuHHyKUbWHunbjODumOmJKpiV1UCUCdZIwsq4BgXew/1sxklJW6ILYpi9ggz8TS0Rvvx
	GF46BDaddxZIIOTcFP3zxKh/u78uZJlh6KH5pQhKGw71hBR6iNruBWUOhtx/bmPLzNF7
	hT8Aca1wlmCvci7vGTZEg441YqdlEtV1PqlLK/+dauhb8ilKxootLp+znceIL8sEpxLN
	zIQN+SSpJW6Apmq6gKEy0gw8K0wdr1XpubGoYRaWP0/MKvE+ypRaE6iF3N+/uWOFxj7H
	bplw==
MIME-Version: 1.0
References: <1539487305-12761-1-git-send-email-lirongqing@baidu.com>
	<2badfb2b-0a50-4d18-cdb4-d894b4ef7bec@cumulusnetworks.com>
In-Reply-To: <2badfb2b-0a50-4d18-cdb4-d894b4ef7bec@cumulusnetworks.com>
From: Li RongQing <roy.qing.li@gmail.com>
Date: Mon, 15 Oct 2018 16:31:05 +0800
Message-ID: <CAJFZqHznOMCyBWPd68LiF3gVM8-Y81_iydzVXj43KxG=wEANBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Bridge] [PATCH] net: bridge: fix a memory leak in __vlan_add
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev <netdev@vger.kernel.org>, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, Li RongQing <lirongqing@baidu.com>

> >
>
> Hi,
> Good catch, but the patch doesn't fix the bug entirely. The problem is that masterv can be
> created just for this vlan and the br_vlan_put_master() above can free it, so we can
> check a pointer that's not really up-to-date (and thus again leak memory).
> You should move the new code above the br_vlan_put_master() call.
>
> Also please tag the proper branch, this is for net-next, and CC all bridge
> maintainers (added Roopa).
>

Ok, thanks, I will send v2

-RongQing


> Thank you,
>  Nik
