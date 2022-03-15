Return-Path: <tobias@waldekranz.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=waldekranz-com.20210112.gappssmtp.com; s=20210112;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=1eFaiU5+NXOZ2eF/q2c9hS91JEU83jBZdMPIUzAUG/M=;
 b=W9eHnbhnxZGkzFj4ctqYZx2unDRv0f6pILZnVE29yrAktO5wfV20/6Q5AYy2opt8kW
 mEsUioTGfGdUFxKKKJLC1YaxkOCTeW2Z1Sx0akQKquuDbdLVis6ZPKyWY5GwYnpzo4xP
 Jur81GGN4sb0B+FWmLvdm0DkYueYkSa2YrKABgXs+59DS3pNashgTBY1HOaB13LLpgow
 Ofn21eFrtSHyBy/7w3XlI0057PBHN1Rv0myExHyAZlaWtktSbhS3OFHBvG20IDG2LW6c
 jBVSKdDoRX5hO9X9MM+7RyHzzIgxbE7dObi9QuznBILzRbBqUSR80QmgHH1DaLxJG3n6
 PThA==
From: Tobias Waldekranz <tobias@waldekranz.com>
In-Reply-To: <20220315163349.k2rmfdzrd3jvzbor@skbuf>
References: <20220315002543.190587-1-tobias@waldekranz.com>
 <20220315002543.190587-10-tobias@waldekranz.com>
 <20220315163349.k2rmfdzrd3jvzbor@skbuf>
Date: Tue, 15 Mar 2022 23:26:59 +0100
Message-ID: <87ee32lumk.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Bridge] [PATCH v4 net-next 09/15] net: dsa: Never offload FDB
 entries on standalone ports
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 18:33, Vladimir Oltean <olteanv@gmail.com> wrote:
> On Tue, Mar 15, 2022 at 01:25:37AM +0100, Tobias Waldekranz wrote:
>> If a port joins a bridge that it can't offload, it will fallback to
>> standalone mode and software bridging. In this case, we never want to
>> offload any FDB entries to hardware either.
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>
> When you resend, please send this patch separately, unless something
> breaks really ugly with your MST series in place.

Sure. I found this while testing the software fallback. It prevents a
segfault in dsa_port_bridge_host_fdb_add, which (rightly, I think)
assumes that dp->bridge is valid. I feel like this should have a Fixes:
tag, but I'm not sure which commit to blame. Any suggestions?

>>  net/dsa/slave.c | 3 +++
>>  1 file changed, 3 insertions(+)
>> 
>> diff --git a/net/dsa/slave.c b/net/dsa/slave.c
>> index a61a7c54af20..647adee97f7f 100644
>> --- a/net/dsa/slave.c
>> +++ b/net/dsa/slave.c
>> @@ -2624,6 +2624,9 @@ static int dsa_slave_fdb_event(struct net_device *dev,
>>  	if (ctx && ctx != dp)
>>  		return 0;
>>  
>> +	if (!dp->bridge)
>> +		return 0;
>> +
>>  	if (switchdev_fdb_is_dynamically_learned(fdb_info)) {
>>  		if (dsa_port_offloads_bridge_port(dp, orig_dev))
>>  			return 0;
>> -- 
>> 2.25.1
>> 
