Return-Path: <Horatiu.Vultur@microchip.com>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1593542712; x=1625078712;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=gVXFKwkoilJ+WRsAX2ilDSQvX1wsECjHxbakjfFTTiA=;
 b=tGZFtzXvjzO9lbqNel/0gcYL4b4H+zhgg3c4Dnt4UZCgiT2VgKFm448F
 RGSERHcKSG9aisUbyRWvhi6+ZI468HnjmvF3E1JgyUnRKbnINzecotvNV
 EOBBooR4ItH4rowB2QvtgbYMkz1bcCy7xLMV0rO9Dwx6bqajdQKMh+b2L
 XGqHl395ojo/leeoyk+9XOuQBtD9lSMsnJ6YUvx5asBl4v5OEnytjF3Ly
 /K1wxhHF5Nwuo718zhvP0Sd9NUDSUzlw8FgyRuXM6Yzu76Txs66COEgHO
 VOiE17X4BZkO/zmJrQmigt+KPJi1tfg+JJ9Rnk76+rs/yeSjqd6Ey8mcd Q==;
Date: Tue, 30 Jun 2020 20:45:09 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20200630184509.oliwf3ui4gxno756@soft-dev3.localdomain>
References: <20200630134424.4114086-1-horatiu.vultur@microchip.com>
 <20200630134424.4114086-3-horatiu.vultur@microchip.com>
 <20200630091243.124869e2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20200630091243.124869e2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Subject: Re: [Bridge] [PATCH net-next 2/3] bridge: mrp: Add br_mrp_fill_info
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, jiri@mellanox.com, davem@davemloft.net

The 06/30/2020 09:12, Jakub Kicinski wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> 
> On Tue, 30 Jun 2020 15:44:23 +0200 Horatiu Vultur wrote:
> > Add the function br_mrp_fill_info which populates the MRP attributes
> > regarding the status of each MRP instance.
> >
> > Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> 
> This adds warnings when built with W=1 C=1:

The warnings at line 316 will be fixed once net will be merged into
net-next. But I need to fix the others.

> 
> net/bridge/br_mrp_netlink.c:316:9: warning: dereference of noderef expression
> net/bridge/br_mrp_netlink.c:325:36: warning: dereference of noderef expression
> net/bridge/br_mrp_netlink.c:328:36: warning: dereference of noderef expression
> net/bridge/br_mrp_netlink.c:316:9: warning: dereference of noderef expression

-- 
/Horatiu
