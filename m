Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:content-transfer-encoding:date:from
 :in-reply-to:message-id:mime-version:references:subject:to
 :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
 fm2; bh=E0wceg3xkmnmO0owKD+Ur3r9Ne13G1p5ItMUZ5WVi/g=; b=XFIma2hN
 1X76BLHIwxM2l+ebuv19KRWJz2Kh3J3V4+1HvD+tJpXOleuEdbpRc9hNVlHFetn/
 jXVKIr/TwDdbUR9AdL4CFLCWMRez16MIRCVUyZ7eTEdqedl1ho1FR4FW0txIIgB5
 qOQT90jyES/eIJtAQeNgEeg42ACauHA7x6K/1MdLTbLDQjsi4uD6pr1se3Mih4BU
 UmaZWuIpRRkUY606QqdFLsNgng/owCwIbKry49iRQhcu3EB/+sJVolmkjebfzpMa
 lihuye/NtDLF8R1E+btqrfbVAH8GD2jTZ46sfdI5yLTfdHIli1JhoIeJfExVTEUT
 9JDrVkdnMnbK9g==
From: Ido Schimmel <idosch@idosch.org>
Date: Mon,  1 Jun 2020 15:58:55 +0300
Message-Id: <20200601125855.1751343-3-idosch@idosch.org>
In-Reply-To: <20200601125855.1751343-1-idosch@idosch.org>
References: <20200601125855.1751343-1-idosch@idosch.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Bridge] [PATCH net 2/2] vxlan: Avoid infinite loop when
	suppressing NS messages with invalid options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@vger.kernel.org, bridge@lists.linux-foundation.org
Cc: mlxsw@mellanox.com, nikolay@cumulusnetworks.com, roopa@cumulusnetworks.com, dlstevens@us.ibm.com, Ido Schimmel <idosch@mellanox.com>, allas@mellanox.com, kuba@kernel.org, davem@davemloft.net

From: Ido Schimmel <idosch@mellanox.com>

When proxy mode is enabled the vxlan device might reply to Neighbor
Solicitation (NS) messages on behalf of remote hosts.

In case the NS message includes the "Source link-layer address" option
[1], the vxlan device will use the specified address as the link-layer
destination address in its reply.

To avoid an infinite loop, break out of the options parsing loop when
encountering an option with length zero and disregard the NS message.

This is consistent with the IPv6 ndisc code and RFC 4886 which states
that "Nodes MUST silently discard an ND packet that contains an option
with length zero" [2].

[1] https://tools.ietf.org/html/rfc4861#section-4.3
[2] https://tools.ietf.org/html/rfc4861#section-4.6

Fixes: 4b29dba9c085 ("vxlan: fix nonfunctional neigh_reduce()")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
---
 drivers/net/vxlan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/vxlan.c b/drivers/net/vxlan.c
index a5b415fed11e..779e56c43d27 100644
--- a/drivers/net/vxlan.c
+++ b/drivers/net/vxlan.c
@@ -1924,6 +1924,10 @@ static struct sk_buff *vxlan_na_create(struct sk_buff *request,
 	ns_olen = request->len - skb_network_offset(request) -
 		sizeof(struct ipv6hdr) - sizeof(*ns);
 	for (i = 0; i < ns_olen-1; i += (ns->opt[i+1]<<3)) {
+		if (!ns->opt[i + 1]) {
+			kfree_skb(reply);
+			return NULL;
+		}
 		if (ns->opt[i] == ND_OPT_SOURCE_LL_ADDR) {
 			daddr = ns->opt + i + sizeof(struct nd_opt_hdr);
 			break;
-- 
2.26.2

