Date: Fri, 8 May 2009 15:38:42 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
Message-ID: <20090508153842.65ce3bed@s6510>
In-Reply-To: <20090505.122718.51237316.davem@davemloft.net>
References: <20090418085848.GC3370@psychotron.englab.brq.redhat.com>
	<20090504111417.GE3402@psychotron.englab.brq.redhat.com>
	<20090505124827.GB3473@psychotron.englab.brq.redhat.com>
	<20090505.122718.51237316.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: David Miller <davem@davemloft.net>
Cc: ivecera@redhat.com, fubar@us.ibm.com, jpirko@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, jgarzik@pobox.com, dada1@cosmosbay.com, bonding-devel@lists.sourceforge.net

On Tue, 05 May 2009 12:27:18 -0700 (PDT)
David Miller <davem@davemloft.net> wrote:

> From: Jiri Pirko <jpirko@redhat.com>
> Date: Tue, 5 May 2009 14:48:28 +0200
> 
> > This patch introduces a new list in struct net_device and brings a set of
> > functions to handle the work with device address list. The list is a replacement
> > for the original dev_addr field and because in some situations there is need to
> > carry several device addresses with the net device. To be backward compatible,
> > dev_addr is made to point to the first member of the list so original drivers
> > sees no difference.
> > 
> > Signed-off-by: Jiri Pirko <jpirko@redhat.com>
> 
> Applied to net-next-2.6, thanks!
> --
> To unsubscribe from this list: send the line "unsubscribe netdev" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Not sure if this is such a good idea since the purpose of this was to fix
a bonding/bridging interaction, but it breaks STP on bridging.
