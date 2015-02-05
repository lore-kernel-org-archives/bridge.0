Return-Path: <dan.carpenter@oracle.com>
Date: Thu, 5 Feb 2015 15:34:15 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20150205123415.GA12005@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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
To: roopa@cumulusnetworks.com
Cc: bridge@lists.linux-foundation.org

Hello Roopa Prabhu,

This is a semi-automatic email about new static checker warnings.

The patch 68e331c785b8: "bridge: offload bridge port attributes to
switch asic if feature flag set" from Jan 29, 2015, leads to the
following Smatch complaint:

net/bridge/br_netlink.c:552 br_setlink()
	 error: we previously assumed 'p' could be null (see line 518)

net/bridge/br_netlink.c
   517	
   518		if (p && protinfo) {
                    ^
Check for NULL.

   519			if (protinfo->nla_type & NLA_F_NESTED) {
   520				err = nla_parse_nested(tb, IFLA_BRPORT_MAX,
   521						       protinfo, br_port_policy);
   522				if (err)
   523					return err;
   524	
   525				spin_lock_bh(&p->br->lock);
   526				err = br_setport(p, tb);
   527				spin_unlock_bh(&p->br->lock);
   528			} else {
   529				/* Binary compatibility with old RSTP */
   530				if (nla_len(protinfo) < sizeof(u8))
   531					return -EINVAL;
   532	
   533				spin_lock_bh(&p->br->lock);
   534				err = br_set_port_state(p, nla_get_u8(protinfo));
   535				spin_unlock_bh(&p->br->lock);
   536			}
   537			if (err)
   538				goto out;
   539		}
   540	
   541		if (afspec) {
   542			err = br_afspec((struct net_bridge *)netdev_priv(dev), p,
   543					afspec, RTM_SETLINK);
   544		}
   545	
   546		if (!(flags & BRIDGE_FLAGS_SELF)) {
   547			/* set bridge attributes in hardware if supported
   548			 */
   549			ret_offload = netdev_switch_port_bridge_setlink(dev, nlh,
   550									flags);
   551			if (ret_offload && ret_offload != -EOPNOTSUPP)
   552				br_warn(p->br, "error setting attrs on port %u(%s)\n",
                                        ^^^^^
New dererference.

   553					(unsigned int)p->port_no, p->dev->name);
   554		}


Also:
	net/bridge/br_netlink.c:592 br_dellink()
	error: we previously assumed 'p' could be null (see line 575)

regards,
dan carpenter
