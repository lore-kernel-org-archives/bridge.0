Return-Path: <dan.carpenter@oracle.com>
Date: Tue, 7 Feb 2017 15:15:21 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20170207121520.GA15359@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [Bridge] [bug report] bridge: per vlan dst_metadata netlink support
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

The patch efa5356b0d97: "bridge: per vlan dst_metadata netlink
support" from Jan 31, 2017, leads to the following Smatch complaint:

    net/bridge/br_netlink_tunnel.c:144 br_fill_vlan_tinfo_range()
    error: we previously assumed 'vtbegin' could be null (see line 130)

net/bridge/br_netlink_tunnel.c
   129	
   130		if (vtbegin && vtend && (vtend->vid - vtbegin->vid) > 0) {
                    ^^^^^^^
Check for NULL.

   131			/* add range to skb */
   132			err = br_fill_vlan_tinfo(skb, vtbegin->vid,
   133						 vtbegin->tinfo.tunnel_id,
   134						 BRIDGE_VLAN_INFO_RANGE_BEGIN);
   135			if (err)
   136				return err;
   137	
   138			err = br_fill_vlan_tinfo(skb, vtend->vid,
   139						 vtend->tinfo.tunnel_id,
   140						 BRIDGE_VLAN_INFO_RANGE_END);
   141			if (err)
   142				return err;
   143		} else {
   144			err = br_fill_vlan_tinfo(skb, vtbegin->vid,
                                                      ^^^^^^^^^^^^
Unchecked dereference.

   145						 vtbegin->tinfo.tunnel_id,
   146						 0);

regards,
dan carpenter
