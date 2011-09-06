Message-ID: <4E65C326.3010506@broadcom.com>
Date: Mon, 5 Sep 2011 23:52:22 -0700
From: "Bhanu Prakash Gollapudi" <bprakash@broadcom.com>
MIME-Version: 1.0
References: <1314905304-16485-1-git-send-email-jpirko@redhat.com>
	<20110902122630.GC1991@minipsycho>
	<1314989161.3419.5.camel@bwh-desktop>
	<20110903133428.GA2821@minipsycho> <1315057614.3092.160.camel@deadeye>
	<5A9BD224CEA58D4CB62235967D650C160A1B7D1C@orsmsx509.amr.corp.intel.com>
In-Reply-To: <5A9BD224CEA58D4CB62235967D650C160A1B7D1C@orsmsx509.amr.corp.intel.com>
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
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
To: "Zou, Yi" <yi.zou@intel.com>
Cc: "amit.salecha@qlogic.com" <amit.salecha@qlogic.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "devel@open-fcoe.org" <devel@open-fcoe.org>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "decot@google.com" <decot@google.com>, "therbert@google.com" <therbert@google.com>, "eric.dumazet@gmail.com" <eric.dumazet@gmail.com>, "fubar@us.ibm.com" <fubar@us.ibm.com>, "JBottomley@parallels.com" <JBottomley@parallels.com>, "xiaosuo@gmail.com" <xiaosuo@gmail.com>, "paulmck@linux.vnet.ibm.com" <paulmck@linux.vnet.ibm.com>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, "mirq-linux@rere.qmqm.pl" <mirq-linux@rere.qmqm.pl>, Ben Hutchings <bhutchings@solarflare.com>, "greearb@candelatech.com" <greearb@candelatech.com>, "Love,
	Robert W" <robert.w.love@intel.com>, "laijs@cn.fujitsu.com" <laijs@cn.fujitsu.com>, Jiri Pirko <jpirko@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "davem@davemloft.net" <davem@davemloft.net>, "loke.chetan@gmail.com" <loke.chetan@gmail.com>

On 9/5/2011 8:25 PM, Zou, Yi wrote:
>>
>> On Sat, 2011-09-03 at 15:34 +0200, Jiri Pirko wrote:
>>> This patch does several things:
>>> - introduces __ethtool_get_settings which is called from ethtool code
>> and
>>>    from drivers as well. Put ASSERT_RTNL there.
>>> - dev_ethtool_get_settings() is replaced by __ethtool_get_settings()
>>> - changes calling in drivers so rtnl locking is respected. In
>>>    iboe_get_rate was previously ->get_settings() called unlocked. This
>>>    fixes it. Also prb_calc_retire_blk_tmo() in af_packet.c had the same
>>>    problem. Also fixed by calling __dev_get_by_index() instead of
>>>    dev_get_by_index() and holding rtnl_lock for both calls.
>>> - introduces rtnl_lock in bnx2fc_vport_create() and fcoe_vport_create()
>>>    so bnx2fc_if_create() and fcoe_if_create() are called locked as they
>>>    are from other places.
>>> - use __ethtool_get_settings() in bonding code
>>>
>>> Signed-off-by: Jiri Pirko<jpirko@redhat.com>
>> Reviewed-by: Ben Hutchings<bhutchings@solarflare.com>  [except FCoE bits]
>>
>> Ben.
> FCoE bits look ok to me. Thanks,
>
> Reviewed-by: Yi Zou<yi.zou@intel.com>

bnx2fc changes looks OK to me.
Reviewed-by: Bhanu Prakash Gollapudi <bprakash@broadcom.com>
>
>>
>> --
>> Ben Hutchings, Staff Engineer, Solarflare
>> Not speaking for my employer; that's the marketing department's job.
>> They asked us to note that Solarflare product names are trademarked.
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-scsi" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


