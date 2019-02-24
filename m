Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=to:cc:references:from:openpgp:autocrypt:subject:message-id:date
	:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=FXeSM/hYhtBw4Ou/zgFhI0RI1TbISbLzRsAnqreHMwY=;
	b=AnPQMOTmrIVEp4Vt5Liuh6Qz/ZyJCRlXz9guaPfyL4FJDsrJKJd4D+70eVKjX5J1hb
	m+hEx66fb8zZzfKGK5MgyM37MIuHW4eNVF1daXkl5V3ikUQAuycswlbRFpFWAhQkifkN
	7rstnpBXGo9vyMw6reR5eDNjf/G1XJGX6LfR4kOYY2H+hMqqRegCNfYuDM4Ji7knMlaC
	pItkp/P51pqEWtULsZc6N+IpCPEK1w5pFYz3Wx7JXwjgKb6azkJJmO6S+xX8yyaNzkyb
	rf2nKlRWsXuj398sHqgp56x27Vq2u1jE7S5/pNmDg695IaF9QD5dv4iAcFFOxLn8cCU3
	6TZA==
References: <20190222235927.10295-1-f.fainelli@gmail.com>
	<20190222235927.10295-8-f.fainelli@gmail.com>
	<20190223103207.GA13070@splinter>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <daaa3bb6-78b1-7c19-e2fd-6ec03d56201d@gmail.com>
Date: Sun, 24 Feb 2019 08:47:27 -0800
MIME-Version: 1.0
In-Reply-To: <20190223103207.GA13070@splinter>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Bridge] [PATCH net-next 7/8] net: switchdev: Replace port attr
 set SDO with a notification
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>, "andrew@lunn.ch" <andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>, open list <linux-kernel@vger.kernel.org>, "vivien.didelot@gmail.com" <vivien.didelot@gmail.com>, Jiri Pirko <jiri@mellanox.com>, "David S. Miller" <davem@davemloft.net>

Le 2/23/19 à 2:32 AM, Ido Schimmel a écrit :
> On Fri, Feb 22, 2019 at 03:59:25PM -0800, Florian Fainelli wrote:
>> Drop switchdev_ops.switchdev_port_attr_set. Drop the uses of this field
>> from all clients, which were migrated to use switchdev notification in
>> the previous patches.
>>
>> Add a new function switchdev_port_attr_notify() that sends the switchdev
>> notifications SWITCHDEV_PORT_ATTR_SET and takes care, depending on
>> SWITCHDEV_F_DEFER to call the blocking (process) or non-blocking
>> (atomic) notifier chain accordingly.
>>
>> Drop __switchdev_port_attr_set() and update switchdev_port_attr_set()
>> likewise.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  net/switchdev/switchdev.c | 96 +++++++++++----------------------------
>>  1 file changed, 26 insertions(+), 70 deletions(-)
>>
>> diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
>> index 94400f5b8e07..a1f16836ef89 100644
>> --- a/net/switchdev/switchdev.c
>> +++ b/net/switchdev/switchdev.c
>> @@ -174,81 +174,35 @@ static int switchdev_deferred_enqueue(struct net_device *dev,
>>  	return 0;
>>  }
>>  
>> -/**
>> - *	switchdev_port_attr_get - Get port attribute
> 
> Hmm, why do you remove it here? Can't you remove it in a separate patch?
> I thought we already got rid of it :p

Yes it should have been removed, looks like my previous series did not
that, I will send that separately.

> 
>> - *
>> - *	@dev: port device
>> - *	@attr: attribute to get
>> - */
>> -int switchdev_port_attr_get(struct net_device *dev, struct switchdev_attr *attr)
>> +static int switchdev_port_attr_notify(enum switchdev_notifier_type nt,
>> +				      struct net_device *dev,
>> +				      const struct switchdev_attr *attr,
>> +				      struct switchdev_trans *trans)
>>  {
>> -	const struct switchdev_ops *ops = dev->switchdev_ops;
>> -	struct net_device *lower_dev;
>> -	struct list_head *iter;
>> -	struct switchdev_attr first = {
>> -		.id = SWITCHDEV_ATTR_ID_UNDEFINED
>> -	};
>> -	int err = -EOPNOTSUPP;
>> +	int err;
>> +	int rc;
>>  
>> -	if (ops && ops->switchdev_port_attr_get)
>> -		return ops->switchdev_port_attr_get(dev, attr);
>> +	struct switchdev_notifier_port_attr_info attr_info = {
>> +		.attr = attr,
>> +		.trans = trans,
>> +		.handled = false,
>> +	};
>>  
>> -	if (attr->flags & SWITCHDEV_F_NO_RECURSE)
>> +	if (attr & SWITCHDEV_F_DEFER)
>> +		rc = call_switchdev_blocking_notifiers(nt, dev,
>> +						       &attr_info.info, NULL);
>> +	else
>> +		rc = call_switchdev_notifiers(nt, dev, &attr_info.info, NULL);
> 
> I don't believe this is needed. You're calling this function from
> switchdev_port_attr_set_now() which is always called from process
> context. switchdev_port_attr_set() takes care of that. Similar to
> switchdev_port_obj_add().

Except for net/bridge/br_switchdev.c when we check the bridge port's
flags support with PRE_BRIDGE_FLAGS. In that case we are executing from
the caller (atomic) context and we can't defer otherwise that trumps the
whole idea of being able to do a quick check and return that to the
caller that we cannot support specific flags. How would you recommend
approaching that?
-- 
Florian
