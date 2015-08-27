Return-Path: <davem@davemloft.net>
Date: Thu, 27 Aug 2015 15:35:44 -0700 (PDT)
Message-Id: <20150827.153544.1324848960394791457.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1440657146-23437-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
References: <1440657146-23437-1-git-send-email-makita.toshiaki@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next] bridge: Add netlink support for
 vlan_protocol attribute
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: makita.toshiaki@lab.ntt.co.jp
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org

From: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
Date: Thu, 27 Aug 2015 15:32:26 +0900

> This enables bridge vlan_protocol to be configured through netlink.
> 
> When CONFIG_BRIDGE_VLAN_FILTERING is disabled, kernel behaves the
> same way as this feature is not implemented.
> 
> Signed-off-by: Toshiaki Makita <makita.toshiaki@lab.ntt.co.jp>
> ---
> v2: Fix u16 to __be16

Applied, thank you.
