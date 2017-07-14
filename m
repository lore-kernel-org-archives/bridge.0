Return-Path: <davem@davemloft.net>
Date: Fri, 14 Jul 2017 08:19:42 -0700 (PDT)
Message-Id: <20170714.081942.1796952600877192514.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1499951350-2087-1-git-send-email-nikolay@cumulusnetworks.com>
References: <1499951350-2087-1-git-send-email-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net] net: bridge: fix dest lookup when vlan
 proto doesn't match
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: anitha@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Thu, 13 Jul 2017 16:09:10 +0300

> With 802.1ad support the vlan_ingress code started checking for vlan
> protocol mismatch which causes the current tag to be inserted and the
> bridge vlan protocol & pvid to be set. The vlan tag insertion changes
> the skb mac_header and thus the lookup mac dest pointer which was loaded
> prior to calling br_allowed_ingress in br_handle_frame_finish is VLAN_HLEN
> bytes off now, pointing to the last two bytes of the destination mac and
> the first four of the source mac causing lookups to always fail and
> broadcasting all such packets to all ports. Same thing happens for locally
> originated packets when passing via br_dev_xmit. So load the dest pointer
> after the vlan checks and possible skb change.
> 
> Fixes: 8580e2117c06 ("bridge: Prepare for 802.1ad vlan filtering support")
> Reported-by: Anitha Narasimha Murthy <anitha@cumulusnetworks.com>
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied.
