Date: Mon, 11 Sep 2006 12:59:09 -0700
From: David Kimdon <david.kimdon@devicescape.com>
Message-ID: <20060911195909.GB5754@devicescape.com>
References: <20060911174928.GA3451@devicescape.com>
	<bdfc5d6e0609111155s58677c8bx2533330a18238aca@mail.gmail.com>
	<4505B4ED.9080901@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4505B4ED.9080901@candelatech.com>
Subject: Re: [Bridge] RFC: [PATCH] bridge vlan integration
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: Ben Greear <greearb@candelatech.com>
Cc: bridge@lists.osdl.org

> >--- ./include/linux/skbuff.h.gospo      2006-09-11 14:41:54.000000000 -0400
> >+++ ./include/linux/skbuff.h    2006-09-11 14:43:27.000000000 -0400
> >@@ -297,6 +297,7 @@ struct sk_buff {
> >        __u32                   nfmark;
> > #endif /* CONFIG_NETFILTER */
> > #ifdef CONFIG_BRIDGE_VLAN
> >+       unsigned int            vlan_priority;
> >        unsigned int            vlan;
> > #endif


> 
> SKB bloat is not good for performance.  You can store the priority and the 
> VID in
> a single 32-bit number with room to spare...

I wonder if we can use skb->cb?

-David
