From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 29 Jan 2010 11:12:05 +0100
References: <201001271104.20607.arnd@arndb.de>
	<201001271105.15733.arnd@arndb.de>
	<20100128.213344.226776729.davem@davemloft.net>
In-Reply-To: <20100128.213344.226776729.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201001291112.05278.arnd@arndb.de>
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
To: David Miller <davem@davemloft.net>
Cc: herbert@gondor.apana.org.au, mst@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, ogerlitz@voltaire.com

On Friday 29 January 2010, David Miller wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed, 27 Jan 2010 11:05:15 +0100
> 
> > + * skb_dev_set -- assign a buffer to a new device
> 
> My english is terrible, but I think this should be
> "assign a new device to a buffer".

Right, that seems clearer.

> If you agree, please fix this up when you resubmit patches #1 and #2
> along with the fix you already plan to make to patch #3.

Ok, will do.

Thanks,

	Arnd
