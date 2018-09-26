Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=a3FdD2wxK/e5mMZKofEBU/T7T7Qxh7FjJ2h8dwWVGKM=; 
	b=i3k8OP83AVYT/SNV8/KIGhJZ97DSLa8Lmh32nRTen01HW35TrMrMOttfPgX6ee4VtU3v4VTRZEG05S8aOf5QC+OegD289uwUK81/g40+JuvzVEeJUnl93YW9KihT8hx3Igopi+V1JAILbWgBKhZ746xkttFQNZhOGaZJvfIzAaM=;
Date: Wed, 26 Sep 2018 16:48:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20180926144808.GM1676@lunn.ch>
References: <20180926121802.27851-1-nikolay@cumulusnetworks.com>
	<20180926121802.27851-3-nikolay@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926121802.27851-3-nikolay@cumulusnetworks.com>
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
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, davem@davemloft.net

Hi Nikolay

>  struct net_bridge {
>  	spinlock_t			lock;
>  	spinlock_t			hash_lock;
>  	struct list_head		port_list;
>  	struct net_device		*dev;
>  	struct pcpu_sw_netstats		__percpu *stats;
> +	unsigned long			options;

Maybe a u32 would be better, so we run out of bits at the same time on
32 and 64 bit systems?

   Andrew
