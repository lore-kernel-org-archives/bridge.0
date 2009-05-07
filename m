Date: Thu, 07 May 2009 15:03:07 -0700 (PDT)
Message-Id: <20090507.150307.195857213.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090506122645.456d9af4@nehalam>
References: <20090415082118.GC21342@psychotron.englab.brq.redhat.com>
	<20090506144624.GI28637@psychotron.englab.brq.redhat.com>
	<20090506122645.456d9af4@nehalam>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: use device address list
 instead of dev_addr (repost)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@linux-foundation.org
Cc: ivecera@redhat.com, fubar@us.ibm.com, jpirko@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, dada1@cosmosbay.com, jgarzik@pobox.com, bonding-devel@lists.sourceforge.net

From: Stephen Hemminger <shemminger@linux-foundation.org>
Date: Wed, 6 May 2009 12:26:45 -0700

> Won't this all break spanning tree which expects 1:1 relationship
> between address and port.

Indeed, this could be a fundamental issue with this change.
