Return-Path: <davem@davemloft.net>
Date: Sat, 21 Jul 2018 23:27:33 -0700 (PDT)
Message-Id: <20180721.232733.468047452825591471.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180720144826.29892-2-nikolay@cumulusnetworks.com>
References: <20180720144826.29892-1-nikolay@cumulusnetworks.com>
	<20180720144826.29892-2-nikolay@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 1/2] net: bridge: add support for raw
 sysfs port options
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, wkok@cumulusnetworks.com, anuradhak@cumulusnetworks.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Fri, 20 Jul 2018 17:48:25 +0300

> +		spin_lock_bh(&p->br->lock);
> +		ret = brport_attr->store_raw(p, (char *)buf);
> +		spin_unlock_bh(&p->br->lock);

Please respect the const here.

Have the methods do a kstrncup(); ... kfree(); sequence if they have
to mangle the contents when there is a newline inside.

I know the caller is passing in what was a non-const char pointer,
I've looked at the implementation, but it might be that way forever.

I looked at all other sysfs writes that need to do this \n --> \0
mangling and they either copy the string first into a static buffer
or they do the kstrncup() thing.

Thank you.
