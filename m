Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=/Yy3ZB6ynFILGRWvi21dgyg4vK/E8N82vs+X4zYYdPM=;
	b=XCJrvzqOHGH9hg+jWLzrqEVkHUnemKeNW/iUSF9m8s9aOx5xSCCwy9YoFhRNq8Drg+
	BNAADesEFjAea510/ET/s1PTTxheebhtc6K3np2FU3tpMr72RXY053EqBCkH9r8GnbiA
	xKF2N19ti9qWmolmI7PzGyK6HJDDEr2rbsGFY=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <ff84c00d882dc646a7d69dcbdfe8417b4c0bdf91.1527522008.git.petrm@mellanox.com>
	<58a3153f-9393-da8c-7aea-7a68537f6f90@cumulusnetworks.com>
Message-ID: <012aee15-9e57-0267-cc3a-3b091977fa3f@cumulusnetworks.com>
Date: Mon, 28 May 2018 18:53:58 +0300
MIME-Version: 1.0
In-Reply-To: <58a3153f-9393-da8c-7aea-7a68537f6f90@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next] net: bridge: Lock before br_fdb_find()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: davem@davemloft.net

On 28/05/18 18:52, Nikolay Aleksandrov wrote:
> On 28/05/18 18:44, Petr Machata wrote:
>> Callers of br_fdb_find() need to hold the hash lock, which
>> br_fdb_find_port() doesn't do. Add the missing lock/unlock
>> pair.
>>
>> Signed-off-by: Petr Machata <petrm@mellanox.com>
>> ---
>>  net/bridge/br_fdb.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>> index b19e310..3f5691a 100644
>> --- a/net/bridge/br_fdb.c
>> +++ b/net/bridge/br_fdb.c
>> @@ -135,9 +135,11 @@ struct net_device *br_fdb_find_port(const struct net_device *br_dev,
>>  		return NULL;
>>  
>>  	br = netdev_priv(br_dev);
>> +	spin_lock_bh(&br->hash_lock);
>>  	f = br_fdb_find(br, addr, vid);
>>  	if (f && f->dst)
>>  		dev = f->dst->dev;
>> +	spin_unlock_bh(&br->hash_lock);
>>  
>>  	return dev;
>>  }
>>
> 
> There's also a lockdep assert for hash_lock in br_find_fdb().
> 
> Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> 

Fixes: 4d4fd36126d6 ("net: bridge: Publish bridge accessor functions")

