From: Ben Hutchings <bhutchings@solarflare.com>
Date: Sat, 03 Sep 2011 14:46:47 +0100
In-Reply-To: <20110903133428.GA2821@minipsycho>
References: <1314905304-16485-1-git-send-email-jpirko@redhat.com>
	<20110902122630.GC1991@minipsycho>
	<1314989161.3419.5.camel@bwh-desktop>
	<20110903133428.GA2821@minipsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Message-ID: <1315057614.3092.160.camel@deadeye>
Mime-Version: 1.0
Subject: Re: [Bridge] [patch net-next-2.6 v3] net: consolidate and fix
 ethtool_ops->get_settings calling
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jpirko@redhat.com>
Cc: amit.salecha@qlogic.com, bridge@lists.linux-foundation.org, linux-mips@linux-mips.org, devel@open-fcoe.org, linux-scsi@vger.kernel.org, decot@google.com, therbert@google.com, robert.w.love@intel.com, eric.dumazet@gmail.com, fubar@us.ibm.com, JBottomley@parallels.com, xiaosuo@gmail.com, paulmck@linux.vnet.ibm.com, alexander.h.duyck@intel.com, mirq-linux@rere.qmqm.pl, greearb@candelatech.com, bprakash@broadcom.com, laijs@cn.fujitsu.com, netdev@vger.kernel.org, ralf@linux-mips.org, davem@davemloft.net, loke.chetan@gmail.com

On Sat, 2011-09-03 at 15:34 +0200, Jiri Pirko wrote:
> This patch does several things:
> - introduces __ethtool_get_settings which is called from ethtool code and
>   from drivers as well. Put ASSERT_RTNL there.
> - dev_ethtool_get_settings() is replaced by __ethtool_get_settings()
> - changes calling in drivers so rtnl locking is respected. In
>   iboe_get_rate was previously ->get_settings() called unlocked. This
>   fixes it. Also prb_calc_retire_blk_tmo() in af_packet.c had the same
>   problem. Also fixed by calling __dev_get_by_index() instead of
>   dev_get_by_index() and holding rtnl_lock for both calls.
> - introduces rtnl_lock in bnx2fc_vport_create() and fcoe_vport_create()
>   so bnx2fc_if_create() and fcoe_if_create() are called locked as they
>   are from other places.
> - use __ethtool_get_settings() in bonding code
> 
> Signed-off-by: Jiri Pirko <jpirko@redhat.com>
Reviewed-by: Ben Hutchings <bhutchings@solarflare.com> [except FCoE bits]

Ben.

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

