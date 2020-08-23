Return-Path: <linus.luessing@c0d3.blue>
Date: Sun, 23 Aug 2020 17:42:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
 t=1598197362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WEBQve+/dxCnRS08yIZckUq5RKG1E82t8UUYVFRllgc=;
 b=ILCJaqwrUUwtXcXASdqvU6bwRTjjI3O76EQTyA2Ut7wHL7rzBNanxBPD43cmr6N+FMMl/M
 LLmpcEVcp7ajZG5uAxQrDVbwYmN6eNklcWR8N+BvtWN3xv0fYtYTuc+dzZBQm1XNZ2YEDt
 rNhPI9XIvcUmME120hMHI2jRxrdQ+xG/kx4C6fmBnrT1WxcLrq0QWDts5XFenJ63TitN+f
 v7Hg8issHGdvvrhScqo44ZgXqPvN3Lfz7XmLLYEIxWdJQ63yeejqI+buVjSXJ4wHW6qDo3
 88+eeB6t5dSz+6fPPqvG8rOKJiiMCy7Hy9fXcuwR20bwLPmNsmTQ/rJ9UAJ9RQ==
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
Message-ID: <20200823154239.GA2302@otheros>
References: <20200816202424.3526-1-linus.luessing@c0d3.blue>
 <20200816150813.0b998607@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200816150813.0b998607@hermes.lan>
Subject: Re: [Bridge] [RFC PATCH net-next] bridge: Implement MLD Querier
 wake-up calls / Android bug workaround
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, gluon@luebeck.freifunk.net, openwrt-devel@lists.openwrt.org, "David S . Miller" <davem@davemloft.net>

On Sun, Aug 16, 2020 at 03:08:13PM -0700, Stephen Hemminger wrote:
> Rather than adding yet another feature to the bridge, could this hack be done by
> having a BPF hook? or netfilter module?

Hi Stephen,

Thanks for the constructive feedback and suggestions!

The netfilter approach sounds tempting. However as far as I know
OpenWrt's firewall has no easy layer 2 netfilter integration yet.
So it has default layer 3 netfilter rules, but not for layer 2.

Ideally I'd want to work towards a solution where things "just
work as expected" when a user enables "IGMP Snooping" in the UI.
I could hack the netfilter rules into netifd, the OpenWrt network
manager, when it configures the bridge. But not sure if the
OpenWrt maintainers would like that...

Any preferences from the OpenWrt maintainers side?

Regards, Linus


PS: With BPF I don't have that much experience yet. I would need
to write a daemon which would parse the MLD packets and would
fetch the FDB via netlink, right? If so, sounds like that would
need way more than 300 lines of code. And that would need to be
maintained within OpenWrt, right?
