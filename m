Return-Path: <jakub.kicinski@netronome.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=netronome-com.20150623.gappssmtp.com; s=20150623;
	h=date:from:to:cc:subject:message-id:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=O6Ge4yGJKWS95FYndIP08xQ5nvzJWpBTo6RIqEdMKBM=;
	b=XNMQsEJBpeKArcFOZADv3b8Y7UqxEk6s5OHPU2aO5XdX3ZGfV36Twe9Y5CePLMkWmF
	bOh5UtwsAPce12MIWPEKJTaQTmbupIw83qRblN9YPA4XttSDOgTUe7m8brtmIaSwyxZM
	pV+TcTBouxjLXGuT4bv8GjBoW5w2NC0RZS917qE0XBntpSZbLUBcQWs94qeorhPjBNXO
	yCPhfgZzljdQaFXVNygzg4pdGCFt1By6lwBwc9aaVlY5ySf1kJXi+7tYE+egjhQ7E74g
	zEVUcdacPfhRsex7iut6Yxno4FC81iBRzWOWCd1IMaH2mT39CoOWZ8gXCtOfeLfmvzMN
	ma9w==
Date: Wed, 17 Oct 2018 09:58:17 -0700
From: Jakub Kicinski <jakub.kicinski@netronome.com>
Message-ID: <20181017095817.6465d543@cakuba.netronome.com>
In-Reply-To: <20181017085215.26607-12-idosch@mellanox.com>
References: <20181017085215.26607-1-idosch@mellanox.com>
	<20181017085215.26607-12-idosch@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v2 11/18] net: Add netif_is_vxlan()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ido Schimmel <idosch@mellanox.com>
Cc: "ivecera@redhat.com" <ivecera@redhat.com>, "andrew@lunn.ch" <andrew@lunn.ch>, "f.fainelli@gmail.com" <f.fainelli@gmail.com>, mlxsw <mlxsw@mellanox.com>, "vivien.didelot@savoirfairelinux.com" <vivien.didelot@savoirfairelinux.com>, "nikolay@cumulusnetworks.com" <nikolay@cumulusnetworks.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "roopa@cumulusnetworks.com" <roopa@cumulusnetworks.com>, "bridge@lists.linux-foundation.org" <bridge@lists.linux-foundation.org>, Jiri Pirko <jiri@mellanox.com>, Petr Machata <petrm@mellanox.com>, "davem@davemloft.net" <davem@davemloft.net>

On Wed, 17 Oct 2018 08:53:20 +0000, Ido Schimmel wrote:
> Add the ability to determine whether a netdev is a VxLAN netdev by
> calling the above mentioned function that checks the netdev's
> rtnl_link_ops.
> 
> This will allow modules to identify netdev events involving a VxLAN
> netdev and act accordingly. For example, drivers capable of VxLAN
> offload will need to configure the underlying device when a VxLAN netdev
> is being enslaved to an offloaded bridge.
> 
> Convert nfp to use the newly introduced helper.
> 
> Signed-off-by: Ido Schimmel <idosch@mellanox.com>
> Reviewed-by: Petr Machata <petrm@mellanox.com>

Acked-by: Jakub Kicinski <jakub.kicinski@netronome.com>

Thanks!
