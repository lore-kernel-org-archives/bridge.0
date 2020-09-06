Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599428007;
 bh=cJ708UL/ADiomAUjAbKxBhMf6n+GHXQJnHzoImsfcg8=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=ePw+NbIWcoBts+yC81GpKZVCQ3kfkzNGSW2jFkiFOG5h1RLBSVzvxtYR6e/qqyN7X
 0TXYmsScyLa/9eNnEe2ESPBe0wdn+vbgcKFyw8G1gtM/+LLGfeQqkWvHlE1zV7avsD
 Z3LQmvZQ27m4va7r31agv4+StmqRxpuFpTx2d3cg=
Date: Sun, 6 Sep 2020 14:33:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20200906143326.0a09348b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <89eb1120-5776-081e-52ce-1ef92f41ecbe@cumulusnetworks.com>
References: <20200905082410.2230253-1-nikolay@cumulusnetworks.com>
 <20200905082410.2230253-6-nikolay@cumulusnetworks.com>
 <20200906135604.4d47b7a8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <89eb1120-5776-081e-52ce-1ef92f41ecbe@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v3 05/15] net: bridge: mcast: factor
 out port group del
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, roopa@nvidia.com

On Mon, 7 Sep 2020 00:29:10 +0300 Nikolay Aleksandrov wrote:
> >> @@ -1641,16 +1647,7 @@ br_multicast_leave_group(struct net_bridge *br,
> >>   			if (p->flags & MDB_PG_FLAGS_PERMANENT)
> >>   				break;
> >>   
> >> -			rcu_assign_pointer(*pp, p->next);
> >> -			hlist_del_init(&p->mglist);
> >> -			del_timer(&p->timer);
> >> -			kfree_rcu(p, rcu);
> >> -			br_mdb_notify(br->dev, port, group, RTM_DELMDB,
> >> -				      p->flags | MDB_PG_FLAGS_FAST_LEAVE);  
> > 
> > And here we'll loose MDB_PG_FLAGS_FAST_LEAVE potentially?
> 
> Good catch, we will lose the fast leave indeed.
> This is a 1 line change to set the flag before notifying. Would you prefer
> me to send a v4 or a follow up for it?

I think it's cleaner if you send a v4. But not rush, I was planning to
apply this tomorrow morning PST, anyway.
