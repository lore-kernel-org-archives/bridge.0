Date: Fri, 08 May 2009 16:00:08 -0700 (PDT)
Message-Id: <20090508.160008.127530143.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090508153842.65ce3bed@s6510>
References: <20090505124827.GB3473@psychotron.englab.brq.redhat.com>
	<20090505.122718.51237316.davem@davemloft.net>
	<20090508153842.65ce3bed@s6510>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: introduce a list of device addresses
 dev_addr_list (v6)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: shemminger@vyatta.com
Cc: ivecera@redhat.com, fubar@us.ibm.com, jpirko@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, jgarzik@pobox.com, dada1@cosmosbay.com, bonding-devel@lists.sourceforge.net

From: Stephen Hemminger <shemminger@vyatta.com>
Date: Fri, 8 May 2009 15:38:42 -0700

> Not sure if this is such a good idea since the purpose of this was to fix
> a bonding/bridging interaction, but it breaks STP on bridging.

Thanks for not paying attention... :-/

The Intel folks want to have an address list functionality so
they can public MAC addresses meant for FCOE and other purposes.

So even if the bonding bits bomb, we still need this.
