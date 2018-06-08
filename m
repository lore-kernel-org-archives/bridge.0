Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:from:to:cc:references:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=vCDsNcru2fwu6GIBT7in6wZQCO9k2aSm0ssQnHI0umc=;
	b=ayT5rUhVbTif0JUJq11tqAFf6VoFkZHsrFNQTN7NhMJVF15TDnZtTI6+P+wa63X1Fj
	PTNZFW18lKMUvu3GKZWSHohQOM6EZQ3G6zqomcGfRFUq33QSb7HmqpGX7NXSyGLZ2+Ee
	Zp2V8AIp5V3wHom7ynK8mT+Q4c+Yay34cOQCA=
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <c41fffa00abb9a123039e5509886a0de85274291.1528450455.git.petrm@mellanox.com>
	<38d89430-32c4-8842-efd4-88e7d3912506@cumulusnetworks.com>
Message-ID: <3f7a5287-08c7-867d-10c5-e22ff4febfc6@cumulusnetworks.com>
Date: Fri, 8 Jun 2018 16:39:50 +0300
MIME-Version: 1.0
In-Reply-To: <38d89430-32c4-8842-efd4-88e7d3912506@cumulusnetworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v2] net: bridge: Fix locking in
	br_fdb_find_port()
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

On 08/06/18 16:35, Nikolay Aleksandrov wrote:
> On 08/06/18 16:11, Petr Machata wrote:
>> Callers of br_fdb_find() need to hold the hash lock, which
>> br_fdb_find_port() doesn't do. However, since br_fdb_find_port() is not
>> doing any actual FDB manipulation, the hash lock is not really needed at
>> all. So convert to br_fdb_find_rcu(), surrounded by rcu_read_lock() /
>> _unlock() pair.
>>
>> The device pointer copied from inside the FDB entry is then kept alive
>> by the RTNL lock, which br_fdb_find_port() asserts.
>>
>> Fixes: 4d4fd36126d6 ("net: bridge: Publish bridge accessor functions")
>> Signed-off-by: Petr Machata <petrm@mellanox.com>
>> ---
>>
>> Notes:
>>     Changes from v1 to v2:
>>     
>>     - Instead of taking hash lock, take RCU lock and call br_fdb_find_rcu().
>>
>>  net/bridge/br_fdb.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>> index b19e310..502f663 100644
>> --- a/net/bridge/br_fdb.c
>> +++ b/net/bridge/br_fdb.c
>> @@ -135,9 +135,11 @@ struct net_device *br_fdb_find_port(const struct net_device *br_dev,
>>  		return NULL;
>>  
>>  	br = netdev_priv(br_dev);
>> -	f = br_fdb_find(br, addr, vid);
>> +	rcu_read_lock();
>> +	f = br_fdb_find_rcu(br, addr, vid);
>>  	if (f && f->dst)
>>  		dev = f->dst->dev;
>> +	rcu_read_unlock();
>>  
>>  	return dev;
>>  }
>>
> 
> Important note: the only reason this will not dereference a NULL pointer
> when getting f->dst is because RTNL is held in all of its current
> callers. I missed the comments on the previous version, but using RCU
> here is dangerous if someone decides to use this without rtnl they will
> get a false sense of security, that is why I acked the previous version.
> I'd suggest to use READ_ONCE() for f->dst to avoid reading it again.
> 

Nevermind the READ_ONCE part, I missed that there's ASSERT_RTNL() in the
beginning of this function, so it'll always be used with RTNL. :-)
It's good as it stands, I need to get some coffee.

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>



