Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=UCMMI6s4HWsCsBG91lDWKoBIpGtLVI0wywKKvaelNzQ=;
	b=AGsvBixpQ+tRQkZ/ELZVRmFYfCr5pLdFrzq9/P/cnaxIjbuqdl8t9NmZlm6KbOH/Jj
	Q75zy+Zgimw3iin0sZ1JJENam0iROyr4cu5hOugdnFDha5E3WOEyrV/XE4qbsPSvtYq6
	esE7caIl6X9mxTEThDU0wcfWbu/DADKJWGtAc=
References: <20180926121802.27851-1-nikolay@cumulusnetworks.com>
	<20180926121802.27851-3-nikolay@cumulusnetworks.com>
	<20180926144808.GM1676@lunn.ch>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <e5b4f87d-c665-9476-c9d3-a7254394c13f@cumulusnetworks.com>
Date: Wed, 26 Sep 2018 17:55:47 +0300
MIME-Version: 1.0
In-Reply-To: <20180926144808.GM1676@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 2/9] net: bridge: add bitfield for
 options and convert vlan opts
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

On 26/09/18 17:48, Andrew Lunn wrote:
> Hi Nikolay
> 
>>  struct net_bridge {
>>  	spinlock_t			lock;
>>  	spinlock_t			hash_lock;
>>  	struct list_head		port_list;
>>  	struct net_device		*dev;
>>  	struct pcpu_sw_netstats		__percpu *stats;
>> +	unsigned long			options;
> 
> Maybe a u32 would be better, so we run out of bits at the same time on
> 32 and 64 bit systems?
> 
>    Andrew
> 

Bitops operate on an unsigned long, I actually had a BUILD_BUG_ON() for
32 bits initially, but checked other places and they seem to be using it
as-is without any checks so I decided to leave it as well (e.g.
sock_flags).
