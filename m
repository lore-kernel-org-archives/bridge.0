Return-Path: <davem@davemloft.net>
Date: Sat, 24 Nov 2018 18:04:02 -0800 (PST)
Message-Id: <20181124.180402.645583819668180736.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <85963d6a-3411-9461-67aa-42e1fd02e663@cumulusnetworks.com>
References: <20181124121551.6942-1-colin.king@canonical.com>
	<85963d6a-3411-9461-67aa-42e1fd02e663@cumulusnetworks.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH] net: bridge: check for a null p->dev before
 dereferencing it
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nikolay@cumulusnetworks.com
Cc: netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, colin.king@canonical.com

From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Date: Sat, 24 Nov 2018 14:21:07 +0200

> I was contacted recently about this privately and this was my reply:
> "Checking new_nbp() and del_nbp() it should not be possible to reach that code
> with p->dev or p->br as NULL. The cap check code has always been there, I just
> shuffled the rest of the function to obtain rtnl lock and kept it as close to
> the original as possible, thus the checks remained.
> In order to avoid future reports like this I'll send a cleanup once net-next
> opens up.
> 
> My reasoning of why it shouldn't be possible:
> - On port add new_nbp() sets both p->dev and p->br before creating kobj/sysfs
> 
> - On port del (trickier) del_nbp() calls kobject_del() before call_rcu() to destroy
>   the port which in turn calls sysfs_remove_dir() which uses kernfs_remove() which
>   deactivates (shouldn't be able to open new files) and calls kernfs_drain() to drain
>   current open/mmaped files in the respective dir before continuing, thus making it
>   impossible to open a bridge port sysfs file with p->dev and p->br equal to NULL.
> "
> 
> So I think it's safe to remove those checks altogether. It'd be nice to get a second
> look over my reasoning as I might be missing something in sysfs/kernfs call path.

I did a once over your analysis and I agree, the checks should be safe to remove.
