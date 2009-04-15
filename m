Date: Wed, 15 Apr 2009 02:21:31 -0700 (PDT)
Message-Id: <20090415.022131.157811430.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090415083223.GF21342@psychotron.englab.brq.redhat.com>
References: <20090415081819.GB21342@psychotron.englab.brq.redhat.com>
	<49E59A1C.9030108@cn.fujitsu.com>
	<20090415083223.GF21342@psychotron.englab.brq.redhat.com>
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
To: jpirko@redhat.com
Cc: ivecera@redhat.com, fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, mschmidt@redhat.com, jgarzik@pobox.com, dada1@cosmosbay.com, bonding-devel@lists.sourceforge.net

From: Jiri Pirko <jpirko@redhat.com>
Date: Wed, 15 Apr 2009 10:32:24 +0200

> This patch introduces a new list in struct net_device and brings a set of
> functions to handle the work with device address list. The list is a replacement
> for the original dev_addr field and because in some situations there is need to
> carry several device addresses with the net device. To be backward compatible,
> dev_addr is made to point to the first member of the list so original drivers
> sees no difference.
> 
> Note: patch adding list_first_entry_rcu (currently in Ingo's tip tree) needed.
> 
> Signed-off-by: Jiri Pirko <jpirko@redhat.com>

Jiri, please add some distinguishing text to your subject lines when
you post fixed up version of patches.  Like "v2" or something like
that, and make a note under the commit message of the changes you've
made from the previous version.

Otherwise I think it's a dup (because I get a thousand copies anyways)
and will just delete it both in my inbox and on patchwork.

Thanks.
