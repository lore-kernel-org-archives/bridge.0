Return-Path: <liuhangbin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=i1gZ2O7Vihvk5IxmWV6VCkw5T9xJGnRMe+izg7VgwK0=;
 b=WHC2EpbrT0nGCHISViDRuUOIZOg4dkY0559ooJRqha1TErSMzv5XZTdEJjzZD/m4QQ
 4BsiI03VbR9h8Q0LqUaEsOQ3fuRruVKUvAyN3C4dA+S2oL1H7Ws4HSRkPsGSQUES+nVV
 pfnBjgSAjW9Dfdrqn6XUte2zjRGpB/jps0ulx4Oo2zRuUHF357dQOqNM4zaGsk5tNHYE
 t91UykFSDZcR5n0e2s+oFvmGgY9OJKhidQT16ajYq4Bm4N8hXyYA1Uo2F0+VDOuKEcVu
 3tghTkPFvt6rfdfYIUGPjXKhblVTe186Yr3w1uSemrhj3POCt7+iLJeSXT221jnDywGB
 HGMQ==
Date: Wed, 20 Oct 2021 18:19:25 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <YW/tLekS17ZF9/w1@Laptop-X1>
References: <20211020023604.695416-1-liuhangbin@gmail.com>
 <20211020024016.695678-1-liuhangbin@gmail.com>
 <c041a184-92cb-0ebd-25e9-13bfc6413fc9@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c041a184-92cb-0ebd-25e9-13bfc6413fc9@nvidia.com>
Subject: Re: [Bridge] [PATCHv2 net] net: bridge: mcast: QRI must be less
	than QI
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@nvidia.com>
Cc: netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, roopa@nvidia.com, kuba@kernel.org, davem@davemloft.net

On Wed, Oct 20, 2021 at 12:49:17PM +0300, Nikolay Aleksandrov wrote:
> Nacked-by: Nikolay Aleksandrov <nikolay@nvidia.com>
> 
> I think we just discussed this a day ago? It is the same problem -
> while we all agree the values should follow the RFC, users have had
> the option to set any values forever (even non-RFC compliant ones).
> This change risks breaking user-space.

OK, I misunderstood your reply in last mail. I thought you only object to
disabling no meaning values(e.g. set timer to 0, which not is forbid by the
RFC). I don't know you also reject to follow a *MUST* rule defined in the RFC.
> 
> Users are free to follow the RFC or not, we can't force them at this
> point. This should've been done when the config option was added long
> time ago.

OK, I will stop working on this path.

Thanks
Hangbin
