Return-Path: <roopa@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=message-id:date:from:user-agent:mime-version:to:cc:subject
	:references:in-reply-to:content-type:content-transfer-encoding;
	bh=KnGQ5ZU1HAcH7qOG8vCqjl+jJjHtMQU8g/kibwbcBYM=;
	b=UtgODOS2Ph25nR1EZT1AT6wxaeme80/8RclmuJ0yzYTyeHvCMghLj6P2jpma8DxPuW
	z6FXyMaJobKpOV3qz8EuhXegdmvlXSEJ0d8ZfB1k0eaCM68bgTH+Udzam4YoV8/Q1M/E
	XUX+Th4g6Ft7eGrrLzR3wCcoVO6i/jkSGWdAU=
Message-ID: <54D38041.6090600@cumulusnetworks.com>
Date: Thu, 05 Feb 2015 06:37:53 -0800
From: roopa <roopa@cumulusnetworks.com>
MIME-Version: 1.0
References: <20150205123415.GA12005@mwanda>
In-Reply-To: <20150205123415.GA12005@mwanda>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] bridge: offload bridge port attributes to switch asic
 if feature flag set
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: bridge@lists.linux-foundation.org

On 2/5/15, 4:34 AM, Dan Carpenter wrote:
> Hello Roopa Prabhu,
>
> This is a semi-automatic email about new static checker warnings.
>
> The patch 68e331c785b8: "bridge: offload bridge port attributes to
> switch asic if feature flag set" from Jan 29, 2015, leads to the
> following Smatch complaint:
>
> net/bridge/br_netlink.c:552 br_setlink()
> 	 error: we previously assumed 'p' could be null (see line 518)
>
> net/bridge/br_netlink.c
>     517	
>     518		if (p && protinfo) {
>                      ^
> Check for NULL.
>
>     519			if (protinfo->nla_type & NLA_F_NESTED) {
>     520				err = nla_parse_nested(tb, IFLA_BRPORT_MAX,
>     521						       protinfo, br_port_policy);
>     522				if (err)
>     523					return err;
>     524	
>     525				spin_lock_bh(&p->br->lock);
>     526				err = br_setport(p, tb);
>     527				spin_unlock_bh(&p->br->lock);
>     528			} else {
>     529				/* Binary compatibility with old RSTP */
>     530				if (nla_len(protinfo) < sizeof(u8))
>     531					return -EINVAL;
>     532	
>     533				spin_lock_bh(&p->br->lock);
>     534				err = br_set_port_state(p, nla_get_u8(protinfo));
>     535				spin_unlock_bh(&p->br->lock);
>     536			}
>     537			if (err)
>     538				goto out;
>     539		}
>     540	
>     541		if (afspec) {
>     542			err = br_afspec((struct net_bridge *)netdev_priv(dev), p,
>     543					afspec, RTM_SETLINK);
>     544		}
>     545	
>     546		if (!(flags & BRIDGE_FLAGS_SELF)) {
>     547			/* set bridge attributes in hardware if supported
>     548			 */
>     549			ret_offload = netdev_switch_port_bridge_setlink(dev, nlh,
>     550									flags);
>     551			if (ret_offload && ret_offload != -EOPNOTSUPP)
>     552				br_warn(p->br, "error setting attrs on port %u(%s)\n",
>                                          ^^^^^
> New dererference.
>
>     553					(unsigned int)p->port_no, p->dev->name);
>     554		}
>
>
> Also:
> 	net/bridge/br_netlink.c:592 br_dellink()
> 	error: we previously assumed 'p' could be null (see line 575)
Thanks, yes, looks like i don't address the case where the message comes 
in on the bridge device.
I will post a patch a patch soon.
