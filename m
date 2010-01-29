Date: Thu, 28 Jan 2010 21:33:44 -0800 (PST)
Message-Id: <20100128.213344.226776729.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <201001271105.15733.arnd@arndb.de>
References: <201001271104.20607.arnd@arndb.de>
	<201001271105.15733.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/3] net: maintain namespace isolation between
 vlan and real device
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: arnd@arndb.de
Cc: herbert@gondor.apana.org.au, mst@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, ogerlitz@voltaire.com

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 27 Jan 2010 11:05:15 +0100

> + * skb_dev_set -- assign a buffer to a new device

My english is terrible, but I think this should be
"assign a new device to a buffer".

If you agree, please fix this up when you resubmit patches #1 and #2
along with the fix you already plan to make to patch #3.

Thanks!
