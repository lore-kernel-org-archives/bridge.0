Date: Tue, 5 May 2009 08:37:16 +0200
From: Jiri Pirko <jpirko@redhat.com>
Message-ID: <20090505063715.GA3375@psychotron.englab.brq.redhat.com>
References: <20090417115723.GE9556@psychotron.englab.brq.redhat.com>
	<20090418085848.GC3370@psychotron.englab.brq.redhat.com>
	<20090504111417.GE3402@psychotron.englab.brq.redhat.com>
	<20090504.213730.131875923.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20090504.213730.131875923.davem@davemloft.net>
Subject: Re: [Bridge] [PATCH] net: introduce a list of device
	addresses	dev_addr_list (v5)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: David Miller <davem@davemloft.net>
Cc: ivecera@redhat.com, fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, jgarzik@pobox.com, dada1@cosmosbay.com, bonding-devel@lists.sourceforge.net

Tue, May 05, 2009 at 06:37:30AM CEST, davem@davemloft.net wrote:
>From: Jiri Pirko <jpirko@redhat.com>
>Date: Mon, 4 May 2009 13:14:18 +0200
>
>> +static void __hw_addr_del_multiple(struct list_head *to_list,
>> +				   struct list_head *from_list,
>> +				   int addr_len, unsigned char addr_type)
>> +{
>> +	__hw_addr_del_multiple_ii(to_list, from_list, addr_len, addr_type, -1);
>> +}
>
>Unused static function, this will create build warnings.
>
>Or, it should :-)

I'm aware.
>
>If you plan to use such a function in subsequent patches, add
>it in those changes not here.

Yes, Ok, I was not quite sure. Thanks for explanation, I'll resubmit later
today.
>
>Otherwise I have no fundamental objection to this patch, nice
>work!
