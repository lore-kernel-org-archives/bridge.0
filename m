From: Ben Hutchings <bhutchings@solarflare.com>
In-Reply-To: <20110902122630.GC1991@minipsycho>
References: <1314905304-16485-1-git-send-email-jpirko@redhat.com>
	<20110902122630.GC1991@minipsycho>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 02 Sep 2011 19:46:01 +0100
Message-ID: <1314989161.3419.5.camel@bwh-desktop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [patch net-next-2.6 v2] net: consolidate and fix
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

On Fri, 2011-09-02 at 14:26 +0200, Jiri Pirko wrote:
> This patch does several things:
> - introduces __ethtool_get_settings which is called from ethtool code and
>   from dev_ethtool_get_settings() as well.
> - dev_ethtool_get_settings() becomes rtnl wrapper for
>   __ethtool_get_settings()
[...]

I don't like this locking change.  Most other dev_*() functions require
the caller to hold RTNL, and it will break any OOT module calling
dev_ethtool_get_settings() without producing any warning at compile
time.  Why not put an ASSERT_RTNL() in it instead?

The rest of this looks fine.

Ben. 

-- 
Ben Hutchings, Staff Engineer, Solarflare
Not speaking for my employer; that's the marketing department's job.
They asked us to note that Solarflare product names are trademarked.

