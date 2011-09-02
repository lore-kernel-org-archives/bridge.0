Date: Fri, 2 Sep 2011 22:42:41 +0200
From: Jiri Pirko <jpirko@redhat.com>
Message-ID: <20110902204239.GA14802@minipsycho>
References: <1314905304-16485-1-git-send-email-jpirko@redhat.com>
	<20110902122630.GC1991@minipsycho>
	<1314989161.3419.5.camel@bwh-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1314989161.3419.5.camel@bwh-desktop>
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
To: Ben Hutchings <bhutchings@solarflare.com>
Cc: amit.salecha@qlogic.com, bridge@lists.linux-foundation.org, linux-mips@linux-mips.org, devel@open-fcoe.org, linux-scsi@vger.kernel.org, decot@google.com, therbert@google.com, robert.w.love@intel.com, eric.dumazet@gmail.com, fubar@us.ibm.com, JBottomley@parallels.com, xiaosuo@gmail.com, paulmck@linux.vnet.ibm.com, alexander.h.duyck@intel.com, mirq-linux@rere.qmqm.pl, greearb@candelatech.com, bprakash@broadcom.com, laijs@cn.fujitsu.com, netdev@vger.kernel.org, ralf@linux-mips.org, davem@davemloft.net, loke.chetan@gmail.com

Fri, Sep 02, 2011 at 08:46:01PM CEST, bhutchings@solarflare.com wrote:
>On Fri, 2011-09-02 at 14:26 +0200, Jiri Pirko wrote:
>> This patch does several things:
>> - introduces __ethtool_get_settings which is called from ethtool code and
>>   from dev_ethtool_get_settings() as well.
>> - dev_ethtool_get_settings() becomes rtnl wrapper for
>>   __ethtool_get_settings()
>[...]
>
>I don't like this locking change.  Most other dev_*() functions require
>the caller to hold RTNL, and it will break any OOT module calling
>dev_ethtool_get_settings() without producing any warning at compile
>time.  Why not put an ASSERT_RTNL() in it instead?

Hmm. Okay, then I would remove dev_ethtool_get_settings() from
net/core/dev.c and only put __ethtool_get_settings() to
net/core/ethtool.c. Makes more sense to me to have it there...
ASSERT_RTNL woudl be good there as well.

>
>The rest of this looks fine.
>
>Ben. 
>
>-- 
>Ben Hutchings, Staff Engineer, Solarflare
>Not speaking for my employer; that's the marketing department's job.
>They asked us to note that Solarflare product names are trademarked.
>
