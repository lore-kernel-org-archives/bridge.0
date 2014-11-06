Return-Path: <eric.dumazet@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding;
	bh=vLx37Dv60GzbMxSbWWBUzcw58Up4QMqZZulb7eeLxRY=;
	b=IAkZdJHpnWRzNwMdIKRSfS8NxRnayIxvym8rlArOYNtpusviia1HkFYxW8a1502JoT
	fxZk2XDL4KM/xjQGHcFsNk+AavlNF0E+ku1kx2yyaXbsabQBJtlGz4967QBBT2QQ13Tk
	VHXOKMNQPy6E/Yw6L+2USLyWJMLYXbiXXlBcw/pfyi0PKU48gfD+0ZgtVtWujyfDo59Z
	1HW6EgO0709V209gmJWTU4VRcG785ZTksvwL3D4xzsUXUXYka7MH1trNrF7RkeLZdQED
	WHo9FnkiKac7bWrJeZG3nsPkZlHhE2ca6JjPM5qqZ+GoJRM3yYMH1jjeL8z8/0LZsn4D
	XFpA==
Message-ID: <1415273711.13896.67.camel@edumazet-glaptop2.roam.corp.google.com>
From: Eric Dumazet <eric.dumazet@gmail.com>
Date: Thu, 06 Nov 2014 03:35:11 -0800
In-Reply-To: <8D1F1238A24CE743B8F3CED0F137C69E408AA087@EXMB02.ahnbang.ahnlab.com>
References: <1415255192-13584-1-git-send-email-suhyun.park@ahnlab.com>
	<545B1E27.3080302@lab.ntt.co.jp>
	<8D1F1238A24CE743B8F3CED0F137C69E408AA087@EXMB02.ahnbang.ahnlab.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH] bridge: missing null bridge device check
 causing null pointer dereference (bugfix)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: =?UTF-8?Q?=EB=B0=95=EC=88=98=ED=98=84?= <suhyun.park@ahnlab.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, "David S. Miller" <davem@davemloft.net>

On Thu, 2014-11-06 at 07:58 +0000, 박수현 wrote:
> >-----Original Message-----
> >From: Toshiaki Makita [mailto:makita.toshiaki@lab.ntt.co.jp]
> >Sent: Thursday, November 06, 2014 4:07 PM
> >To: 박수현; Stephen Hemminger; David S. Miller
> >Cc: bridge@lists.linux-foundation.org; netdev@vger.kernel.org; linux-
> >kernel@vger.kernel.org
> >Subject: Re: [PATCH] bridge: missing null bridge device check causing null
> >pointer dereference (bugfix)
> >
> >On 2014/11/06 15:26, Su-Hyun Park wrote:
> >> the bridge device can be null if the bridge is being deleted while
> >> processing the packet, which causes the null pointer dereference in
> >switch statement.
> >
> >How can this happen??
> >It is guarded by rcu.
> >netdev_rx_handler_unregister() ensures rx_handler_data is non NULL.
> >
> 
> The RCU protect rx_handler_data, not the bridge member port. It can be NULL according to below code.
> 

Where do you find this 'below code' ?

Are you sending a patch for an old linux kernel ?

> static inline struct net_bridge_port *br_port_get_rcu(const struct net_device *dev) {
> 	struct net_bridge_port *port = rcu_dereference(dev->rx_handler_data);
> 	return br_port_exists(dev) ? port : NULL; 
> }

Actual code is :

static inline struct net_bridge_port *br_port_get_rcu(const struct net_device *dev)
{
	return rcu_dereference(dev->rx_handler_data);
}


> 
> The crash happens at the below switch statement in br_handle_frame, where p is NULL.
> 
> 	switch (p->state)

Is your tree really including the fix we already did to fix this issue ?

(commit 716ec052d2280d511e10e90ad54a86f5b5d4dcc2 )
bridge: fix NULL pointer deref of br_port_get_rcu



