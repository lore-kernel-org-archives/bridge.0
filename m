Return-Path: <davem@davemloft.net>
Date: Mon, 03 Aug 2015 16:21:06 -0700 (PDT)
Message-Id: <20150803.162106.34968979073178630.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1438643998-9259-1-git-send-email-razor@blackwall.org>
References: <201508040606.8x0wKgcJ%fengguang.wu@intel.com>
	<1438643998-9259-1-git-send-email-razor@blackwall.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] bridge: mdb: fix vlan_enabled access
 when vlans are not configured
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: razor@blackwall.org
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, nikolay@cumulusnetworks.com

From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Tue,  4 Aug 2015 01:19:58 +0200

> From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 
> Instead of trying to access br->vlan_enabled directly use the provided
> helper br_vlan_enabled().
> 
> Signed-off-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied.
