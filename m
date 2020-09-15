Return-Path: <Henrik.Bjoernlund@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1600160074; x=1631696074;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=Q1K3ZnDAfToNz/8n8qN43CbiTyRRyydMCMCOaNUYtDM=;
 b=U0u4thy7JRsmb3F0y0S3PgUMBVcE0vs+eF8MDqPW3RQanUBvYl8com8/
 Imw/uKoOyYe8M/6SCC7LE3YjSqNAse06xFmEYUr03SiFoyxoIsxOKUuRY
 DSgl8cDN+1tSpXzMpUgeE/QtVA+GQxFTcM0Q/2VWsJhs2z7D/3xxGhaFV
 CzpcCPZGNgTQGj3JUq9oBbuqOjRTzkoy0BQyLk3Je7J3YyCjM0Jm99f3c
 sJOY28hYshVXUjyi/3Xir10qgabopEx+2OF/cVbHMgh9niOrR5GPOed/u
 xGvYYAYWFwU6TVkgvbUPr4UXlrGBX5cTRUfYjcITYYfc0s/lUPyjV7a0v A==;
Date: Tue, 15 Sep 2020 08:51:37 +0000
From: Henrik Bjoernlund <henrik.bjoernlund@microchip.com>
Message-ID: <20200915085137.c7xfmk5bpjzniclp@soft-test08>
References: <20200904091527.669109-1-henrik.bjoernlund@microchip.com>
 <20200904091527.669109-5-henrik.bjoernlund@microchip.com>
 <20200904080257.6b2a643f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200904080257.6b2a643f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Subject: Re: [Bridge] [PATCH RFC 4/7] bridge: cfm: Kernel space
	implementation of CFM.
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, idosch@mellanox.com, jiri@mellanox.com, nikolay@nvidia.com, roopa@nvidia.com, Horatiu Vultur <horatiu.vultur@microchip.com>, davem@davemloft.net

Thanks for the review. Comments below.

The 09/04/2020 08:02, Jakub Kicinski wrote:
> 
> On Fri, 4 Sep 2020 09:15:24 +0000 Henrik Bjoernlund wrote:
> > +     rcu_read_lock();
> > +     b_port = rcu_dereference(mep->b_port);
> > +     if (!b_port)
> > +             return NULL;
> > +     skb = dev_alloc_skb(CFM_CCM_MAX_FRAME_LENGTH);
> > +     if (!skb)
> > +             return NULL;
> 
> net/bridge/br_cfm.c:171:23: warning: context imbalance in 'ccm_frame_build' - different lock contexts for basic block

I will assure that rcu_read_unlock() is called before any return.

-- 
/Henrik
