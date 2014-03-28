Return-Path: <davem@davemloft.net>
Date: Fri, 28 Mar 2014 16:33:42 -0400 (EDT)
Message-Id: <20140328.163342.1681357800958748572.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1395924416-12325-2-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1395924416-12325-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
	<1395924416-12325-2-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net 2/2] bridge: Fix handling stacked vlan tags
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
Date: Thu, 27 Mar 2014 21:46:56 +0900

> If a bridge with vlan_filtering enabled receives frames with stacked
> vlan tags, i.e., they have two vlan tags, br_vlan_untag() strips not
> only the outer tag but also the inner tag.
> 
> br_vlan_untag() is called only from br_handle_vlan(), and in this case,
> it is enough to set skb->vlan_tci to 0 here, because vlan_tci has already
> been set before calling br_handle_vlan().
> 
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>

Applied.
