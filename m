Message-ID: <49E5C378.9020209@trash.net>
Date: Wed, 15 Apr 2009 13:22:32 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <20090313183303.GF3436@psychotron.englab.brq.redhat.com>
	<20090415081720.GA21342@psychotron.englab.brq.redhat.com>
	<20090415081819.GB21342@psychotron.englab.brq.redhat.com>
	<49E59A1C.9030108@cn.fujitsu.com>
	<20090415083223.GF21342@psychotron.englab.brq.redhat.com>
	<49E5A896.90408@cosmosbay.com>
	<20090415111724.GG21342@psychotron.englab.brq.redhat.com>
In-Reply-To: <20090415111724.GG21342@psychotron.englab.brq.redhat.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/3] net: introduce a list of device
	addresses	dev_addr_list
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jiri Pirko <jpirko@redhat.com>
Cc: ivecera@redhat.com, fubar@us.ibm.com, bonding-devel@lists.sourceforge.net, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Li Zefan <lizf@cn.fujitsu.com>, linux-kernel@vger.kernel.org, mschmidt@redhat.com, Eric Dumazet <dada1@cosmosbay.com>, jgarzik@pobox.com, davem@davemloft.net

Jiri Pirko wrote:

>> Since you obviously need a write lock here to be sure following
>> can be done by one cpu only.
>>
>> You have same problem all over this patch.
> 
> Yes, as Dave wrote, this is guarded by RTNL mutex.

This was incorrect. IPv6 adds multicast addresses in softirq context.

>>> +
>>> +	ha = kzalloc(sizeof(*ha), GFP_ATOMIC);
>> kzalloc(max(sizeof(*ha), L1_CACHE_SIZE), GFP_...) is thus higly recommended here.
>>
>> Also, why GFP_ATOMIC is needed here ?
> 
> Yes, it is not needed here. I've copied it here from the original unicast and
> multicast add funtion to stay close but as I can see, there is no need for it
> there either.
> Noted.

Also needed for IPv6 in softirq context.

