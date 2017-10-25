Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=aiEUJ7QrB9Of/KbgK7hbHyaNNJuaQmLdWDXrBZ60i1o=;
	b=NyKZgQG+zjlOvwhKgbxKfDu0/L2guZskow31o0ph3w8rRFNsefOpwCxNQkJNyboelp
	RXVrCkzDrrQ5qhmE29ln6t/X2Z8QGSvP23ZwCRKDuhl9NHA/RKoC2YLEjerlmuqLrBQ/
	XdTemty2oteXi1DuBpxQiAKif6HkIwPewAZQ0=
References: <43f36fb0-8543-7e60-a80e-6da35d74b69a@cumulusnetworks.com>
	<1508968782-15530-1-git-send-email-nikolay@cumulusnetworks.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <f6c0da96-77f0-db19-7a9a-13b246d83d39@cumulusnetworks.com>
Date: Thu, 26 Oct 2017 01:14:19 +0300
MIME-Version: 1.0
In-Reply-To: <1508968782-15530-1-git-send-email-nikolay@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 0/2] bridge: make setlink/dellink
 notifications more accurate
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org
Cc: roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, mrv@mojatatu.com, dsa@cumulusnetworks.com, davem@davemloft.net

On 26/10/17 00:59, Nikolay Aleksandrov wrote:
...
> 
> v3: rebased to latest net-next and fixed non-vlan config functions reported
>     by kbuild test bot

And obviously fixed them wrong, grr... sorry about the noise again, I'll resend v4
with the proper fix.

> v2: pass changed down to vlan add instead of masking errors
> 
> Thanks,
>  Nik
> 
> 
> Nikolay Aleksandrov (2):
>   bridge: netlink: make setlink/dellink notifications more accurate
>   bridge: vlan: signal if anything changed on vlan add
> 
>  net/bridge/br_netlink.c        | 51 ++++++++++++++++-----------
>  net/bridge/br_netlink_tunnel.c | 14 +++++---
>  net/bridge/br_private.h        | 12 ++++---
>  net/bridge/br_private_tunnel.h |  3 +-
>  net/bridge/br_vlan.c           | 78 ++++++++++++++++++++++++++++++------------
>  5 files changed, 106 insertions(+), 52 deletions(-)
> 

