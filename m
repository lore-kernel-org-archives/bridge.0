Date: Mon, 04 May 2009 21:37:30 -0700 (PDT)
Message-Id: <20090504.213730.131875923.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090504111417.GE3402@psychotron.englab.brq.redhat.com>
References: <20090417115723.GE9556@psychotron.englab.brq.redhat.com>
	<20090418085848.GC3370@psychotron.englab.brq.redhat.com>
	<20090504111417.GE3402@psychotron.englab.brq.redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: introduce a list of device addresses
 dev_addr_list (v5)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: jpirko@redhat.com
Cc: ivecera@redhat.com, fubar@us.ibm.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mschmidt@redhat.com, jgarzik@pobox.com, dada1@cosmosbay.com, bonding-devel@lists.sourceforge.net

From: Jiri Pirko <jpirko@redhat.com>
Date: Mon, 4 May 2009 13:14:18 +0200

> +static void __hw_addr_del_multiple(struct list_head *to_list,
> +				   struct list_head *from_list,
> +				   int addr_len, unsigned char addr_type)
> +{
> +	__hw_addr_del_multiple_ii(to_list, from_list, addr_len, addr_type, -1);
> +}

Unused static function, this will create build warnings.

Or, it should :-)

If you plan to use such a function in subsequent patches, add
it in those changes not here.

Otherwise I have no fundamental objection to this patch, nice
work!
