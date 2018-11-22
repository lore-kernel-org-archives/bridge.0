Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=h/dOSvaQ6RwztE43v/vSCsD1f4+Wi3TT5sa2MBym+QM=;
	b=anD5+RyLnGQdpyYnUAz0uz7Fus+0uVg8X/+fRezquPYo1L6meAqaPHu5/wqhhBmnXu
	Anni9hoAwsWxnhdZ5jJf0atsf190dVlKPPowm40noXDVNGbey7eT6RbBf9mPkceFsfCZ
	dj7BG4KUflOwP+PMInp2wzpCZpFYQ5qj8XIns=
References: <20181122042925.8878-1-nikolay@cumulusnetworks.com>
	<20181122042925.8878-3-nikolay@cumulusnetworks.com>
	<20181122160435.GI15403@lunn.ch>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <713ecdab-b221-417d-2536-3fd659c3dbf8@cumulusnetworks.com>
Date: Thu, 22 Nov 2018 18:06:24 +0200
MIME-Version: 1.0
In-Reply-To: <20181122160435.GI15403@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/2] net: bridge: add
 no_linklocal_learn bool option
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

On 22/11/2018 18:04, Andrew Lunn wrote:
>>  int br_boolopt_get(const struct net_bridge *br, enum br_boolopt_id opt)
>>  {
>> -	int optval = 0;
>> -
>>  	switch (opt) {
>> +	case BR_BOOLOPT_NO_LL_LEARN:
>> +		return br_opt_get(br, BROPT_NO_LL_LEARN);
>>  	default:
>>  		break;
>>  	}
>>  
>> -	return optval;
>> +	return 0;
>>  }
> 
> It seems like 1/2 of that change belongs in the previous patch.
> 

Yes, I could squash this into patch 01.

>> --- a/net/bridge/br_sysfs_br.c
>> +++ b/net/bridge/br_sysfs_br.c
>> @@ -328,6 +328,27 @@ static ssize_t flush_store(struct device *d,
>>  }
>>  static DEVICE_ATTR_WO(flush);
>>  
>> +static ssize_t no_linklocal_learn_show(struct device *d,
>> +				       struct device_attribute *attr,
>> +				       char *buf)
>> +{
>> +	struct net_bridge *br = to_bridge(d);
>> +	return sprintf(buf, "%d\n", br_boolopt_get(br, BR_BOOLOPT_NO_LL_LEARN));
>> +}
>> +
>> +static int set_no_linklocal_learn(struct net_bridge *br, unsigned long val)
>> +{
>> +	return br_boolopt_toggle(br, BR_BOOLOPT_NO_LL_LEARN, !!val);
>> +}
>> +
>> +static ssize_t no_linklocal_learn_store(struct device *d,
>> +					struct device_attribute *attr,
>> +					const char *buf, size_t len)
>> +{
>> +	return store_bridge_parm(d, buf, len, set_no_linklocal_learn);
>> +}
>> +static DEVICE_ATTR_RW(no_linklocal_learn);
> 
> I thought we where trying to move away from sysfs? Do we need to add
> new options here? It seems like forcing people to use iproute2 for
> newer options is a good way to get people to convert to iproute2.
> 

Being consistent, all of the bridge options are exported via sysfs. If we start
ignoring it now it'll be confusing.

> 	Andrew
> 

