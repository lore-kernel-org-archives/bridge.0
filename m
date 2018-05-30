Return-Path: <nikolay@cumulusnetworks.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cumulusnetworks.com; s=google;
	h=subject:to:cc:references:from:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=MIpFjC692AZoWcboMUIsmtB2DTT4BSgZi7qwdyAIZ4s=;
	b=AnhVsAK5yUxfHr1G/yNj1gvcMjmSRL7KkWOUNj9Qaxq7ecNfvc8oABUQNNFDBY974u
	X4Q0TAPVAV2MeJKlMiDtmlxHARqqwJo1Js54qioB3pYgXPkgV64CvM6XP6MaY6Qh0j77
	ipMVTzLwXPbLS6voDDWGRRMoOSYfDiHWaILhc=
References: <cover.1527641426.git.petrm@mellanox.com>
	<583d583ad158363411fde87dbf6709024714e498.1527641426.git.petrm@mellanox.com>
From: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <e87b67e1-fdaf-a748-d424-578a599b5441@cumulusnetworks.com>
Date: Wed, 30 May 2018 18:58:13 +0300
MIME-Version: 1.0
In-Reply-To: <583d583ad158363411fde87dbf6709024714e498.1527641426.git.petrm@mellanox.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 7/8] net: bridge: Notify about
	bridge VLANs
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>, netdev@vger.kernel.org, devel@driverdev.osuosl.org, bridge@lists.linux-foundation.org
Cc: f.fainelli@gmail.com, andrew@lunn.ch, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, davem@davemloft.net, dan.carpenter@oracle.com

On 30/05/18 04:00, Petr Machata wrote:
> A driver might need to react to changes in settings of brentry VLANs.
> Therefore send switchdev port notifications for these as well. Reuse
> SWITCHDEV_OBJ_ID_PORT_VLAN for this purpose. Listeners should use
> netif_is_bridge_master() on orig_dev to determine whether the
> notification is about a bridge port or a bridge.
> 
> Signed-off-by: Petr Machata <petrm@mellanox.com>
> ---
>  net/bridge/br_vlan.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 

LGTM,
Reviewed-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

