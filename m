Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XA2aP5Nic7Ru8rrrtaAb2aP/czbKdSvuHA7SK90mhFk=;
 b=JUfo9hahsbfyOV+1YWAdpd7ZQSi79AgJRln0bTaBY/kfgygleF/697oK4v0gYvWLmz
 Jpmhfqe3luT0Y1Dc15sA4D/CzyksBSiLk14ahgqip36BhsvtRRnj5P15SrA698KiE5IW
 AP5/GWrVwu/R7UCBkhdJros6ehhCPIvRnF/svwkbOuly8QwHVUeuRxbZf0Y+uy1FzRaE
 Dh9Gc1aAZ9Jrv+ZzTvy6Tns7KcPmV1H17e/pCLN+RsMkVjAlppMDvwLFIPa8W1Lyt2AQ
 M2/xfla50ew6JqyMKHw+FLYeLSpUXo5wOGcXI0r81HZzWBc+wZfgUiYdgEggzClum1ti
 5cMw==
Date: Mon, 14 Mar 2022 22:20:40 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220314202040.f2r4pidcy6ws34qv@skbuf>
References: <20220314095231.3486931-1-tobias@waldekranz.com>
 <20220314095231.3486931-10-tobias@waldekranz.com>
 <20220314165649.vtsd3xqv7htut55d@skbuf>
 <20220314175556.7mjr4tui4vb4i5qn@skbuf>
 <87mthsl2wn.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mthsl2wn.fsf@waldekranz.com>
Subject: Re: [Bridge] [PATCH v3 net-next 09/14] net: dsa: Validate hardware
 support for MST
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Petr Machata <petrm@nvidia.com>, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 09:01:12PM +0100, Tobias Waldekranz wrote:
> On Mon, Mar 14, 2022 at 19:55, Vladimir Oltean <olteanv@gmail.com> wrote:
> > On Mon, Mar 14, 2022 at 06:56:49PM +0200, Vladimir Oltean wrote:
> >> > diff --git a/net/dsa/port.c b/net/dsa/port.c
> >> > index 58291df14cdb..1a17a0efa2fa 100644
> >> > --- a/net/dsa/port.c
> >> > +++ b/net/dsa/port.c
> >> > @@ -240,6 +240,10 @@ static int dsa_port_switchdev_sync_attrs(struct dsa_port *dp,
> >> >  	if (err && err != -EOPNOTSUPP)
> >> >  		return err;
> >> >  
> >> > +	err = dsa_port_mst_enable(dp, br_mst_enabled(br), extack);
> >> > +	if (err && err != -EOPNOTSUPP)
> >> > +		return err;
> >> 
> >> Sadly this will break down because we don't have unwinding on error in
> >> place (sorry). We'd end up with an unoffloaded bridge port with
> >> partially synced bridge port attributes. Could you please add a patch
> >> previous to this one that handles this, and unoffloads those on error?
> >
> > Actually I would rather rename the entire dsa_port_mst_enable() function
> > to dsa_port_mst_validate() and move it to the beginning of dsa_port_bridge_join().
> > This simplifies the unwinding that needs to take place quite a bit.
> 
> Well you still need to unwind vlan filtering if setting the ageing time
> fails, which is the most complicated one, right?

Yes, but we can leave that for another day :)

...ergo

> Should the unwinding patch still be part of this series then?

no.

> Still, I agree that _validate is a better name, and then _bridge_join
> seems like a more reasonable placement.
> 
> While we're here, I actually made this a hard error in both scenarios
> (but forgot to update the log - will do that in v4, depending on what we
> decide here). There's a dilemma:
> 
> - When reacting to the attribute event, i.e. changing the mode on a
>   member we're apart of, we _can't_ return -EOPNOTSUPP as it will be
>   ignored, which is why dsa_port_mst_validate (nee _enable) returns
>   -EINVAL.
> 
> - When joining a bridge, we _must_ return -EOPNOTSUPP to trigger the
>   software fallback.
> 
> Having something like this in dsa_port_bridge_join...
> 
> err = dsa_port_mst_validate(dp);
> if (err == -EINVAL)
> 	return -EOPNOTSUPP;
> else if (err)
> 	return err;
> 
> ...works I suppose, but feels somewhat awkwark. Any better ideas?

What you can do is follow the model of dsa_switch_supports_uc_filtering(),
and create a dsa_switch_supports_mst() which is called inside an
"if br_mst_enabled(br)" check, and returns bool. When false, you could
return -EINVAL or -EOPNOTSUPP, as appropriate.

This is mostly fine, except for the pesky dsa_port_can_configure_learning(dp)
check :) So while you could name it dsa_port_supports_mst() and pass it
a dsa_port, the problem is that you can't put the implementation of this
new dsa_port_supports_mst() next to dsa_switch_supports_uc_filtering()
where it would be nice to sit for symmetry, because the latter is static
inline and we're missing the definition of dsa_port_can_configure_learning().
So.. the second best thing is to keep dsa_port_supports_mst() in the
same place where dsa_port_mst_enable() currently is.

What do you think?
