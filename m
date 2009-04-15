Message-ID: <49E5BB4F.2060607@trash.net>
Date: Wed, 15 Apr 2009 12:47:43 +0200
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
References: <49E5B365.2010008@trash.net>	<20090415.031510.162624644.davem@davemloft.net>	<49E5B9BD.5070204@trash.net>
	<20090415.034507.208815568.davem@davemloft.net>
In-Reply-To: <20090415.034507.208815568.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH 1/3] net: introduce a list of device addresses
	dev_addr_list
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: ivecera@redhat.com, fubar@us.ibm.com, jpirko@redhat.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, mschmidt@redhat.com, dada1@cosmosbay.com, jgarzik@pobox.com, bonding-devel@lists.sourceforge.net

David Miller wrote:
> From: Patrick McHardy <kaber@trash.net>
> Date: Wed, 15 Apr 2009 12:41:01 +0200
> 
>> Herbert (I think) suggested to make address list updates in softirq
>> context a two-step process, where addresses would first be added to
>> a temporary list and the final change would be done in process context
>> while holding the RTNL.
>>
>> Given the complicated mess we currently have, this would be a very
>> worthwhile change IMO.
> 
> This would break the IPV6 TAHI tests if you think we could use
> such an idea for that.
> 
> When IPV6 packets arrive that influence multicast and unicast
> address lists, the effect must be essentially immediate.  Such
> that a subsequent packet will cause the kernel the behave
> with the necessary side effects, no matter how quickly that
> next packet arrives.

I see, thanks for the explanation.

