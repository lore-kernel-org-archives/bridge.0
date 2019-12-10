Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Qsqd9AhQRa9hpfqkhwfNfWPl8RmlEkObLmWrw1kINII=;
 b=OqngQHNHaO353lzZWpAk0HRzC3O/em2CcW87cQh0dU3Ey712Iqvge8hFyxEePGfoFt
 Q3eiH4OUMllIF1E3BKJe3dFOHNsdlr//N9sD8L0hyTXV07uTHisY1I6+N4mcN/z1VddG
 mdCJhMzLIjtgu7KKhatbmuddVKXYzULywZT9c=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <20191209230522.1255467-1-vivien.didelot@gmail.com>
 <a3b8e24d-5152-7243-545f-8a3e5fbaa53a@cumulusnetworks.com>
Message-ID: <1a32ac69-a802-e039-215a-feec740e682c@cumulusnetworks.com>
Date: Tue, 10 Dec 2019 09:54:05 +0200
MIME-Version: 1.0
In-Reply-To: <a3b8e24d-5152-7243-545f-8a3e5fbaa53a@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: add STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@gmail.com>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org

On 10/12/2019 09:49, Nikolay Aleksandrov wrote:
> On 10/12/2019 01:05, Vivien Didelot wrote:
>> This adds rx_bpdu, tx_bpdu, rx_tcn, tx_tcn, transition_blk,
>> transition_fwd xstats counters to the bridge ports copied over via
>> netlink, providing useful information for STP.
>>
>> Signed-off-by: Vivien Didelot <vivien.didelot@gmail.com>
>> ---
>>  include/uapi/linux/if_bridge.h | 10 ++++++++++
>>  net/bridge/br_if.c             |  8 ++++++++
>>  net/bridge/br_netlink.c        |  9 +++++++++
>>  net/bridge/br_private.h        |  9 +++++++++
>>  net/bridge/br_stp.c            | 25 +++++++++++++++++++++++++
>>  net/bridge/br_stp_bpdu.c       | 12 ++++++++++++
>>  net/bridge/br_stp_if.c         | 27 +++++++++++++++++++++++++++
>>  7 files changed, 100 insertions(+)
>>
[snip]
>>  }
>>  
>> @@ -419,6 +420,12 @@ static struct net_bridge_port *new_nbp(struct net_bridge *br,
>>  	if (p == NULL)
>>  		return ERR_PTR(-ENOMEM);
>>  
>> +	p->stp_stats = netdev_alloc_pcpu_stats(struct br_stp_stats);
>> +	if (!p->stp_stats) {
>> +		kfree(p);
>> +		return ERR_PTR(-ENOMEM);
>> +	}
>> +
>>  	p->br = br;
>>  	dev_hold(dev);
>>  	p->dev = dev;
>> @@ -432,6 +439,7 @@ static struct net_bridge_port *new_nbp(struct net_bridge *br,
>>  	err = br_multicast_add_port(p);
>>  	if (err) {
>>  		dev_put(dev);
>> +		free_percpu(p->stp_stats);
>>  		kfree(p);
>>  		p = ERR_PTR(err);
>>  	}
>> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
>> index a0a54482aabc..03aced1f862b 100644
>> --- a/net/bridge/br_netlink.c
>> +++ b/net/bridge/br_netlink.c
>> @@ -1597,6 +1597,15 @@ static int br_fill_linkxstats(struct sk_buff *skb,
>>  		}
>>  	}
>>  
>> +	if (p) {
>> +		struct bridge_stp_xstats xstats;
> 
> Please rename the local var here, using just xstats is misleading.
> Maybe stp_xstats ?
> 

Actually if this gets re-written to follow the mcast dump the local var
would disappear altogether.


