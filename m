Message-ID: <4BD806E7.7010806@redhat.com>
Date: Wed, 28 Apr 2010 17:59:03 +0800
From: Cong Wang <amwang@redhat.com>
MIME-Version: 1.0
References: <20100427075937.4908.18468.sendpatchset@localhost.localdomain>
	<j2mce2c83091004272102ye46e65fbod138e63dc58bccd5@mail.gmail.com>
In-Reply-To: <j2mce2c83091004272102ye46e65fbod138e63dc58bccd5@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [v4 Patch 1/3] netpoll: add generic support for bridge
 and bonding devices
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Dongdong Deng <libfetion@gmail.com>
Cc: Jay Vosburgh <fubar@us.ibm.com>, Neil Horman <nhorman@tuxdriver.com>, netdev@vger.kernel.org, Matt Mackall <mpm@selenic.com>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, Jeff Moyer <jmoyer@redhat.com>, Andy Gospodarek <gospo@redhat.com>, bonding-devel@lists.sourceforge.net

Dongdong Deng wrote:
> 
> 
> +             if (ops->ndo_netpoll_cleanup)
> +                                       ops->ndo_netpoll_cleanup(np->dev);
> +             np->dev->npinfo = NULL;
> 
> I think it is good to set np->dev->npinfo to NULL  even though we have
> the netpoll_cleanup opt.
> 

This is redundant, since ->ndo_netpoll_cleanup will set it.

Thanks.
