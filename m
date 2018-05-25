Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=/mvnA8WRXpCsxDB3NVMkBd2dbyw5zUxqGhwxNYjwZq8=;
	b=BbXsn/t22nGXnis2F/giEQtyDKSx/zkh60fYyAvQph9EMyO47sBvuDK9vaV57iL+fg
	e9TAH1/iAHOShkNFD9CS6RMEFFdHkluNpvqlQDq1xoJAd1Oo2irvny9p3iMtHOltrM6d
	1fL0u9tZTHsYGuBPobDu07Me2gWzIRPqiwstA=
References: <cover.1527173527.git.petrm@mellanox.com>
	<b0b6b46a239eb330d722cea89137ab6ec5bae6e3.1527173527.git.petrm@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <5ec42d96-cd47-65b3-146c-c301bd35b691@cumulusnetworks.com>
Date: Fri, 25 May 2018 15:08:49 +0300
MIME-Version: 1.0
In-Reply-To: <b0b6b46a239eb330d722cea89137ab6ec5bae6e3.1527173527.git.petrm@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next 6/7] net: bridge: Notify about bridge
	VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: f.fainelli@gmail.com, andrew@lunn.ch, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net

On 24/05/18 18:10, Petr Machata wrote:
> A driver might need to react to changes in settings of brentry VLANs.
> Therefore send switchdev port notifications for these as well. Reuse
> SWITCHDEV_OBJ_ID_PORT_VLAN for this purpose. Listeners should use
> netif_is_bridge_master() on orig_dev to determine whether the
> notification is about a bridge port or a bridge.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> ---
>  net/bridge/br_vlan.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 

Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


