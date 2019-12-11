Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cumulusnetworks.com; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VEiTqs3AdcOOADsYpDlYWqADQJ1OE+9BmLTpHWgdwWA=;
 b=GhxoZKc5XN75PQaqV66FqdkPlEFs9NHr8vay7vPpK0Gv0Z4gZO1JVarSAkNVUdqq1y
 QEWyzyKj+hk2Qp2pcqlZrcZyOuFMz/eXRj3m7X+mIpseNgHSFSy/0EBoPEH/xqswnpmR
 2iAtAb1XVFSqUfQqJzTM9ogWBjvBWefgWMkeY=
References: <20191210212050.1470909-1-vivien.didelot@gmail.com>
 <30e93cfb-cc2c-c484-a743-479cce19d8a9@cumulusnetworks.com>
 <20191210210203.GB1480973@t480s.localdomain>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <498b31ea-bafc-1f44-d4bd-354f30a71972@cumulusnetworks.com>
Date: Wed, 11 Dec 2019 11:40:31 +0200
MIME-Version: 1.0
In-Reply-To: <20191210210203.GB1480973@t480s.localdomain>
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
To: Vivien Didelot <vivien.didelot@gmail.com>
Cc: netdev@vger.kernel.org, Roopa Prabhu <roopa@cumulusnetworks.com>, bridge@lists.linux-foundation.org, "David S. Miller" <davem@davemloft.net>

On 11/12/2019 04:02, Vivien Didelot wrote:
> Hi Nikolay,
> 
> On Tue, 10 Dec 2019 23:45:13 +0200, Nikolay Aleksandrov <nikolay@cumulusnetworks.com> wrote:
>>> +	if (p) {
>>> +		nla = nla_reserve_64bit(skb, BRIDGE_XSTATS_STP,
>>> +					sizeof(p->stp_xstats),
>>> +					BRIDGE_XSTATS_PAD);
>>> +		if (!nla)
>>> +			goto nla_put_failure;
>>> +
>>> +		memcpy(nla_data(nla), &p->stp_xstats, sizeof(p->stp_xstats));
>>
>> You need to take the STP lock here to get a proper snapshot of the values.
> 
> Good catch! I see a br->multicast_lock but no br->stp_lock. Is this what
> you expect?
> 
>     spin_lock_bh(&br->lock);
>     memcpy(nla_data(nla), &p->stp_xstats, sizeof(p->stp_xstats));
>     spin_unlock_bh(&br->lock);
> 

Yeah, this is a very old lock (pre-git) which needs some attention. :)
That is the lock and the above looks good to me.

> 
> Thanks,
> 
> 	Vivien
> 

Cheers,
 Nik
