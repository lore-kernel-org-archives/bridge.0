Date: Wed, 26 Sep 2007 15:57:26 -0700 (PDT)
Message-Id: <20070926.155726.43027883.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070926153330.77aade4d@freepuppy.rosehill>
References: <20070926140608.6e6d3d0c@freepuppy.rosehill>
	<Pine.LNX.4.64.0709270017120.17414@fbirervta.pbzchgretzou.qr>
	<20070926153330.77aade4d@freepuppy.rosehill>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: [Bridge] Re: why network devices don't do reference counting?
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: jengelh@computergmbh.de, olecom@flower.upol.cz, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jbeulich@novell.com

From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Wed, 26 Sep 2007 15:33:30 -0700

> ipv6 is not a network driver, it is a protocol. You might be able to
> remove it if you zap all the routes and applications, ...

It is purposefully set to have a permanent elevated reference
count because it is not designed to be unloaded safely.

It has been unloadable forever.
