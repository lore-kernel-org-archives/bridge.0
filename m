Return-Path: <liuhangbin@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TusiGY9Id/oD51908hOFhgKlKHw5g+jeF6Iv+dmRSBk=;
 b=lH9JGXfqRpprxbxWiOgi7OJko8JZ8+8+6XeISMXirHJVIR1lKakRAJjNZHlW+Ib8Qg
 R06emWD2DUsOGIITYlNDoWmJBlsSUAW3pSxbFkRWd5Ja8GLQLy3s485DZdGV8tZdaSGl
 SzT8Lo137Pgaft698OjxGWfqcTP5eYLS6kXOLUsyOy/wZydy28IyYoUBapOX627T8FDO
 75420c5x7tEC7mcO93KdjdGD2emIMQhILzb1DbhNX59cwHU9+vMMQsVHANGoa4Bl/EPa
 8kigD20bdOqXz7zPbaLzzVmFGNJSXRpOY8myukx8UDna1MFZZFf8gt6dcM4Mo2yBJ8Rj
 4Uvw==
Date: Fri, 15 Oct 2021 14:36:59 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
Message-ID: <YWkhi7iABEKygKaL@Laptop-X1>
References: <20200907095619.11216-1-nikolay@cumulusnetworks.com>
 <20200907095619.11216-11-nikolay@cumulusnetworks.com>
 <YWjsyk/Dzg2/zVbw@Laptop-X1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWjsyk/Dzg2/zVbw@Laptop-X1>
Subject: Re: [Bridge] [PATCH net-next v4 10/15] net: bridge: mcast: support
 for IGMPv3/MLDv2 ALLOW_NEW_SOURCES report
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com

On Fri, Oct 15, 2021 at 10:52:00AM +0800, Hangbin Liu wrote:
> > -	mod_timer(&p->timer, now + br->multicast_membership_interval);
> > +	if (igmpv2_mldv1)
> > +		mod_timer(&p->timer, now + br->multicast_membership_interval);
> 
> Hi Nikolay,
> 
> Our engineer found that the multicast_membership_interval will not work with
> IGMPv3. Is it intend as you said "IGMPv3/MLDv2 handling is not yet
> implemented" ?

Ah, I saw in br_multicast_group_expired() it wait for mp->ports be freed
before delete the mdb entry.

And in br_multicast_port_group_expired() it wait for src entry freed first.

But when mod group src timer, we use
__grp_src_mod_timer(ent, now + br_multicast_gmi(brmctx));

instead of user configured multicast_membership_interval. I think we should
fix it. WDYT?

Thanks
Hangbin
