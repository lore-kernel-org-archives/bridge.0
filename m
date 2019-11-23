Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YSheOqV8iD7jxySZ325Tj32xDvn2ymFuhmX2zrp3R38=;
 b=FNJUXy7YAwPw0tggQAcI0TVyRXBrWT/zRay/BS7Etjjbpa8ERh5oOzY9NQeIXt0DSA
 04z89UjIDido70Z5dYtdJNt1AlzH9ethfXEmOUKnlt36yXHhtjIZMItGYRkAw+UgWEfL
 pUfYc4XkIKe3/mlFrfhZEHmnW08RpsdThb0ZE=
References: <20191122230742.1515752-1-vivien.didelot@gmail.com>
 <20191122152137.33f9f9d7@hermes.lan>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <dbedcfa0-4ece-2690-d93f-7601b0755b95@cumulusnetworks.com>
Date: Sat, 23 Nov 2019 18:58:23 +0200
MIME-Version: 1.0
In-Reply-To: <20191122152137.33f9f9d7@hermes.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add STP stat counters
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>, Vivien Didelot <vivien.didelot@gmail.com>
Cc: f.fainelli@gmail.com, netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On 23/11/2019 01:21, Stephen Hemminger wrote:
> On Fri, 22 Nov 2019 18:07:42 -0500
> Vivien Didelot <vivien.didelot@gmail.com> wrote:
> 
>> This adds rx_bpdu, tx_bpdu, rx_tcn, tx_tcn, transition_blk,
>> transition_fwd stat counters to the bridge ports, along with sysfs
>> statistics nodes under a "statistics" directory of the "brport" entry,
>> providing useful information for STP, for example:
>>
>>     # cat /sys/class/net/lan0/brport/statistics/tx_bpdu
>>     26
>>     # cat /sys/class/net/lan5/brport/statistics/transition_fwd
>>     3
>>
>> At the same time, make BRPORT_ATTR define a non-const attribute as
>> this is required by the attribute group structure.
>>
>> Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
> 
> Please don't add more sysfs stuff. put it in netlink.
> 

+1

You should be able to use the bridge xstats netlink infra to expose these. We already
support master and slave stats (e.g. vlan and mcast stats are retrieved through it).

>> ---
>>  net/bridge/br_private.h  |  8 ++++++++
>>  net/bridge/br_stp.c      |  8 ++++++++
>>  net/bridge/br_stp_bpdu.c |  4 ++++
>>  net/bridge/br_sysfs_if.c | 35 ++++++++++++++++++++++++++++++++++-
>>  4 files changed, 54 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
>> index 36b0367ca1e0..360d8030e3b2 100644
>> --- a/net/bridge/br_private.h
>> +++ b/net/bridge/br_private.h
>> @@ -283,6 +283,14 @@ struct net_bridge_port {
>>  #endif
>>  	u16				group_fwd_mask;
>>  	u16				backup_redirected_cnt;
>> +
>> +	/* Statistics */
>> +	atomic_long_t			rx_bpdu;
>> +	atomic_long_t			tx_bpdu;
>> +	atomic_long_t			rx_tcn;
>> +	atomic_long_t			tx_tcn;
>> +	atomic_long_t			transition_blk;
>> +	atomic_long_t			transition_fwd;
>>  };
>>  
> 
> There is no these need to be atomic.
> Atomic is expensive.
> 
