Return-Path: <jakub.kicinski@netronome.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=netronome-com.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=n18Van/C+xI47tr2ufZ4mpN0BuMAfLrv6tFYdcGIZPE=;
	b=OXKxI6zgAudmkk8efRbgcQ76ZJR1QzId9RAmO7OIes/AwKo4dQOiqZWlJK+iHpjPFG
	VPGQXyO24o7+gWZ9JsMJRVG77yGLoEzbpmnNJH1QSekaA/UsUsfijagQFGNScOqHTJhL
	cKgpZTgvOitNf+KRUHQnbItsV4ZtlCb4hQCZfQ+yHGyZ22VbUirP5T43rUz5liyBCrke
	y0rZSWqOyPywnlfJgKVzdr7/jlb/DyirMFnKJMphNSBLM9S/TArxW3FVwYHFJYarUm0Q
	CeURik9E6dFN08cXYQjaVU6uanlOxgEVqP+b70lv1ERttPRgIIiF6eEzcW4+/R2WzlLk
	2EDw==
Date: Mon, 15 Oct 2018 11:57:56 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
Message-ID: <20181015115756.13b6c0da@cakuba.netronome.com>
In-Reply-To: <20181013171725.3261-12-idosch@mellanox.com>
References: <20181013171725.3261-1-idosch@mellanox.com>
	<20181013171725.3261-12-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 11/18] vxlan: Add netif_is_vxlan()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "vivien.didelot@savoirfairelinux.com" <vivien.didelot@savoirfairelinux.com>, "f.fainelli@gmail.com, 
	<bridge@lists.linux-foundation.org>, mlxsw <mlxsw@mellanox.com>,
	Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, " <stephen@networkplumber.org>, "bridge@lists.linux-foundation.org,
	"davem@davemloft.net, " <davem@davemloft.net>, " <f.fainelli@gmail.com>, stephen@networkplumber.org

On Sat, 13 Oct 2018 17:18:38 +0000, Ido Schimmel wrote:
> Add the ability to determine whether a netdev is a VxLAN netdev by
> calling the above mentioned function that checks the netdev's private
> flags.
> 
> This will allow modules to identify netdev events involving a VxLAN
> netdev and act accordingly. For example, drivers capable of VxLAN
> offload will need to configure the underlying device when a VxLAN netdev
> is being enslaved to an offloaded bridge.
> 
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> Reviewed-by: Petr Machata <petrm@mellanox.com>

Is this preferable over

!strcmp(netdev->rtnl_link_ops->kind, "vxlan")

which is what TC offloads do?
