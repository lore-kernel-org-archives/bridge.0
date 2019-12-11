Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+ux6ujPcuk8gllcblqRwaT5K70h+n2xn7FgUloO8zRg=;
 b=gDhUbvI4tRCdMgxYRZoJoUQ50czCguEOJYrNi3ulo0zMxdIK5VpmGQQZPIkTZNl5DW
 mmOxIpssuK00hFsAtsNdNPhYN492tPi62Dui0dz0VGFmwcoYYSUoHzy0HXr1rXc7e/Q/
 x6DxIck3CSij8wTZH5/EgIwLuxqOr7mI3rcAk=
References: <20191210212050.1470909-1-vivien.didelot@gmail.com>
 <0e45fd22-c31b-a9c2-bf87-22c16a60aeb4@gmail.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <9f978ee1-08ee-aa57-6e3d-9b68657eeb14@cumulusnetworks.com>
Date: Wed, 11 Dec 2019 17:42:33 +0200
MIME-Version: 1.0
In-Reply-To: <0e45fd22-c31b-a9c2-bf87-22c16a60aeb4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2] net: bridge: add STP xstats
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Ahern <dsahern@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org

On 11/12/2019 17:38, David Ahern wrote:
> On 12/10/19 2:20 PM, Vivien Didelot wrote:
>> diff --git a/include/uapi/linux/if_bridge.h b/include/uapi/linux/if_bridge.h
>> index 1b3c2b643a02..e7f2bb782006 100644
>> --- a/include/uapi/linux/if_bridge.h
>> +++ b/include/uapi/linux/if_bridge.h
>> @@ -156,6 +156,15 @@ struct bridge_vlan_xstats {
>>  	__u32 pad2;
>>  };
>>  
>> +struct bridge_stp_xstats {
>> +	__u64 transition_blk;
>> +	__u64 transition_fwd;
>> +	__u64 rx_bpdu;
>> +	__u64 tx_bpdu;
>> +	__u64 rx_tcn;
>> +	__u64 tx_tcn;
>> +};
>> +
>>  /* Bridge multicast database attributes
>>   * [MDBA_MDB] = {
>>   *     [MDBA_MDB_ENTRY] = {
>> @@ -261,6 +270,7 @@ enum {
>>  	BRIDGE_XSTATS_UNSPEC,
>>  	BRIDGE_XSTATS_VLAN,
>>  	BRIDGE_XSTATS_MCAST,
>> +	BRIDGE_XSTATS_STP,
>>  	BRIDGE_XSTATS_PAD,
>>  	__BRIDGE_XSTATS_MAX
>>  };
> 
> Shouldn't the new entry be appended to the end - after BRIDGE_XSTATS_PAD
> 

Oh yes, good catch. That has to be fixed, too.

