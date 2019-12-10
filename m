Return-Path: <vivien.didelot@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:message-id:from:to:cc:subject:in-reply-to:references
 :mime-version:content-disposition:content-transfer-encoding;
 bh=lhiNdVC12nCt8MlphHeNeXsppJHwJXSdVTCOLb3ahXE=;
 b=mVxM7iSVV/fJa7CCTSh9gS1EjUUhQtROEIUQEHdzVn1zNAU3PG0vNxRzPjSWofjHgZ
 ugWkGOdN4LCE8DKbwHJL0DJt24YFP4bxZXjgApONHGBb5y8IJmVwx574VvhcVHf2sBlL
 HB60b42pfla8/r1sKziGjeGJv5oce1uCdqEij3r6hN+uK5UqDIBMLwyb/wvCHsGNo5l5
 RrS+sVIJUmgSJPgnU3BoP6UOEiMRvQn3RnrYdoNYsK6/WJ6De1qrREgshWFvxG3WCsCW
 cmov1+bx9aKLaloZm+BQP31YIJOJr4vX+soePPXfHPgO8GdjDniAPsZZwoDf1VoTMcyv
 GexA==
Date: Tue, 10 Dec 2019 14:39:31 -0500
Message-ID: <20191210143931.GF1344570@t480s.localdomain>
From: Vivien Didelot <vivien.didelot@gmail.com>
In-Reply-To: <a3b8e24d-5152-7243-545f-8a3e5fbaa53a@cumulusnetworks.com>
References: <20191209230522.1255467-1-vivien.didelot@gmail.com>
 <a3b8e24d-5152-7243-545f-8a3e5fbaa53a@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

Hi Nikolay,

On Tue, 10 Dec 2019 09:49:59 +0200, Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:

> Why did you send the bridge patch again ? Does it have any changes ?

The second iproute2 patch does not include the include guards update, but
I kept the bridge_stp_stats structure and the BRIDGE_XSTATS_STP definition
otherwise iproute2 wouldn't compile.

> 
> Why do you need percpu ? All of these seem to be incremented with the
> bridge lock held. A few more comments below.

All other xstats are incremented percpu, I simply followed the pattern.

> >  	struct net_bridge_port *p
> >  		= container_of(kobj, struct net_bridge_port, kobj);
> > +	free_percpu(p->stp_stats);
> 
> Please leave a new line between local var declaration and the code. I know
> it was missing, but you can add it now. :)

OK.

> > +	if (p) {
> > +		struct bridge_stp_xstats xstats;
> 
> Please rename the local var here, using just xstats is misleading.
> Maybe stp_xstats ?

This isn't misleading to me since its scope is limited to the current block
and not the entire function. The block above dumping the VLAN xstats is
using a local "struct br_vlan_stats stats" variable for example.

> 
> > +
> > +		br_stp_get_xstats(p, &xstats);
> > +
> > +		if (nla_put(skb, BRIDGE_XSTATS_STP, sizeof(xstats), &xstats))
> > +			goto nla_put_failure;
> 
> Could you please follow how mcast xstats are dumped and do something similar ?
> It'd be nice to have similar code to audit.

Sure. I would also love to have easily auditable code in net/bridge. For
the bridge STP xstats I followed the VLAN xstats code above, which does:

    if (nla_put(skb, BRIDGE_XSTATS_VLAN, sizeof(vxi), &vxi))
        goto nla_put_failure;

But I can change the STP xstats code to the following:

    if (p) {
        nla = nla_reserve_64bit(skb, BRIDGE_XSTATS_STP,
                                sizeof(struct bridge_stp_xstats),
                                BRIDGE_XSTATS_PAD);
        if (!nla)
            goto nla_put_failure;

        br_stp_get_xstats(p, nla_data(nla));
    }

Would that be preferred?


Thanks,

	Vivien
