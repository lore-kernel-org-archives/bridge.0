Return-Path: <davem@davemloft.net>
Date: Mon, 19 Jan 2015 15:45:36 -0500 (EST)
Message-Id: <20150119.154536.999083093407802603.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <1421430962-18119-1-git-send-email-f.fainelli@gmail.com>
References: <1421430962-18119-1-git-send-email-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 0/2] net: DSA fixes for bridge and
 ip-autoconf
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kaber@trash.net, buytenh@wantstofly.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 16 Jan 2015 09:56:00 -0800

> These two patches address some real world use cases of the DSA master and slave
> network devices.
> 
> You have already seen patch 1 previously and you rejected it since my
> explanations were not good enough to provide a justification as to why it is
> useful, hopefully this time my explanation is better.
> 
> Patch 2 solves a different, yet very real problem as well at the bridge layer
> when using DSA network devices.

Series applied, thanks.
