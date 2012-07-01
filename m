Return-Path: <davem@davemloft.net>
Date: Sat, 30 Jun 2012 17:27:08 -0700 (PDT)
Message-Id: <20120630.172708.1209859499944103648.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20120630114853.GA22767@elgon.mountain>
References: <20120630114853.GA22767@elgon.mountain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [patch -next] netfilter: use kfree_skb() not kfree()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: dan.carpenter@oracle.com
Cc: netfilter@vger.kernel.org, coreteam@netfilter.org, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, kernel-janitors@vger.kernel.org, bart.de.schuymer@pandora.be, netfilter-devel@vger.kernel.org, shemminger@vyatta.com, pablo@netfilter.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Sat, 30 Jun 2012 14:48:53 +0300

> This was should be a kfree_skb() here to free the sk_buff pointer.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

My bad, applied, thanks Dan.
