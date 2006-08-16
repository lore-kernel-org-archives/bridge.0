Message-ID: <003601c6c0e4$72058a40$6514a8c0@home.djasolutions.com>
From: "Jon Sjoberg" <jsjoberg@djasolutions.com>
Date: Tue, 15 Aug 2006 23:31:21 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [Bridge] VLAN handling in br_netfilter.c:br_nf_pre_routing
List-Id: Linux Ethernet Bridging <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@osdl.org

Hi all,

Noticed that br_nf_pre_routing has some code to handle VLANs, but does not
update the nh header.  This appears to cause the IP validity checks to fail
(i.e. "if (iph->ihl < 5...").

There is a check:
if (skb->protocol == __constant_htons(ETH_P_8021Q)){
sk_pull(skb, VLAN_HLEN);
}

If this was changed to:
if (skb->protocol == __constant_htons(ETH_P_8021Q)){
sk_pull(skb, VLAN_HLEN);
skb->nh.raw += VLAN_HLEN;
}

the checks pass.  Note that this updated behavior is already doen elsewhere
in the code.

Thanks,
Jon
----------------------------------------------------------------
Jon Sjoberg
DJA Solutions
E-mail: jsjoberg@djasolutions.com
Phone: 978.448.3659

