Return-Path: <davem@davemloft.net>
Date: Wed, 11 Jun 2014 15:23:21 -0700 (PDT)
Message-Id: <20140611.152321.799416344244730112.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1402401565-15423-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1402401565-15423-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next 0/4] bridge: 802.1ad vlan protocol
	support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: makita.toshiaki@lab.ntt.co.jp
Cc: stephen@networkplumber.org, vyasevic@redhat.com, bridge@lists.linux-foundation.org, netdev@vger.kernel.org

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Tue, 10 Jun 2014 20:59:21 +0900

> Currently bridge vlan filtering doesn't work fine with 802.1ad protocol.
> Only if a bridge is configured without pvid, the bridge receives only
> 802.1ad tagged frames and no STP is used, it will work.
> Otherwise:
> - If pvid is configured, it can put only 802.1Q tags but cannot put 802.1ad
>   tags.
> - If 802.1Q and 802.1ad tagged frames arrive in mixture, it applies filtering
>   regardless of their protocols.
> - While an 802.1ad bridge should use another mac address for STP BPDU and
>   should forward customer's BPDU frames, it can't.
> Thus, we can't properly handle frames once 802.1ad is used.
> 
> Handling 802.1ad is useful if we want to allow stacked vlans to be used,
> e.g., guest VMs wants to use vlan tags and the host also wants to segregate
> guest's traffic from other guests' by vlan tags.
> 
> Here is the image describing how to configure a bridge to filter VMs traffic.
> 
>          +-------+p/u   +-----+  +---------+
>  +----+  |       |------|vnet0|--|User A VM|
>  |eth0|--|802.1ad|      +-----+  +---------+
>  +----+  |bridge |p/u   +-----+  +---------+
>          |       |------|vnet1|--|User B VM|
>          +-------+      +-----+  +---------+
> p/u: pvid/untagged
> 
> This patch set enables us to set vlan protocols per bridge.
> This tries to implement a bridge like S-VLAN component in IEEE 802.1Q-2011
> spec.

Series applied, thanks.
