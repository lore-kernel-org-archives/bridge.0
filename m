Date: Wed, 15 Apr 2009 02:31:04 -0700 (PDT)
Message-Id: <20090415.023104.82135803.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <49E5A896.90408@cosmosbay.com>
References: <49E59A1C.9030108@cn.fujitsu.com>
	<20090415083223.GF21342@psychotron.englab.brq.redhat.com>
	<49E5A896.90408@cosmosbay.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/3] net: introduce a list of device addresses
 dev_addr_list
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: dada1@cosmosbay.com
Cc: ivecera@redhat.com, fubar@us.ibm.com, jpirko@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, mschmidt@redhat.com, jgarzik@pobox.com, bonding-devel@lists.sourceforge.net

From: Eric Dumazet <dada1@cosmosbay.com>
Date: Wed, 15 Apr 2009 11:27:50 +0200

> Since you obviously need a write lock here to be sure following
> can be done by one cpu only.
> 
> You have same problem all over this patch.

RTNL semaphore is held across all modification operations.
