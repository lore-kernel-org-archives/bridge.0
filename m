Return-Path: <davem@davemloft.net>
Date: Sun, 02 Oct 2016 22:44:30 -0400 (EDT)
Message-Id: <20161002.224430.154500634033567062.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20160928220528.17478-1-stefan@agner.ch>
References: <20160928220528.17478-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] netfilter: bridge: clarify bridge/netfilter
	message
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: stefan@agner.ch
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, pablo@netfilter.org

From: Stefan Agner <stefan@agner.ch>
Date: Wed, 28 Sep 2016 15:05:28 -0700

> When using bridge without bridge netfilter enabled the message
> displayed is rather confusing and leads to belive that a deprecated
> feature is in use. Use IS_MODULE to be explicit that the message only
> affects users which use bridge netfilter as module and reword the
> message.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied to net-next, thanks.
