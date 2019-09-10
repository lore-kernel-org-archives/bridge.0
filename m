Return-Path: <davem@davemloft.net>
Date: Tue, 10 Sep 2019 10:13:28 +0200 (CEST)
Message-Id: <20190910.101328.1956638594556147157.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20190906094703.21300-1-nicolas.dichtel@6wind.com>
References: <20190906094703.21300-1-nicolas.dichtel@6wind.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net v2] bridge/mdb: remove wrong use of
	NLM_F_MULTI
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: nicolas.dichtel@6wind.com
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Date: Fri,  6 Sep 2019 11:47:02 +0200

> NLM_F_MULTI must be used only when a NLMSG_DONE message is sent at the end.
> In fact, NLMSG_DONE is sent only at the end of a dump.
> 
> Libraries like libnl will wait forever for NLMSG_DONE.
> 
> Fixes: 949f1e39a617 ("bridge: mdb: notify on router port add and del")
> CC: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Applied and queued up for -stable.
