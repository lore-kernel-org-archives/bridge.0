Return-Path: <davem@davemloft.net>
Date: Thu, 01 Oct 2015 18:07:29 -0700 (PDT)
Message-Id: <20151001.180729.1453077933138144189.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1443637015-4153-1-git-send-email-razor@blackwall.org>
References: <1443637015-4153-1-git-send-email-razor@blackwall.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 0/5] bridge: vlan: cleanups & fixes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: razor@blackwall.org
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, vyasevich@gmail.com

From: Nikolay Aleksandrov <razor@blackwall.org>
Date: Wed, 30 Sep 2015 20:16:50 +0200

> This is the first follow-up set, patch 01 reduces the default rhashtable
> size and the number of locks that can be allocated. Patch 02 and 04 fix
> possible null pointer dereferences due to the new ordering and
> initialization on port add/del, and patch 03 moves the "pvid" member in
> the net_bridge_vlan_group struct in order to simplify code (similar to how
> it was with the older struct). Patch 05 fixes adding a vlan on a port which
> is pvid and doesn't have a global context yet.
> Please review carefully, I think this is the first use of rhashtable's
> "locks_mul" member in the tree and I'd like to make sure it's correct.
> Another thing that needs special attention is the nbp_vlan_flush() move
> after the rx_handler unregister.

Series applied, thanks.
