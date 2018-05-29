Return-Path: <dan.carpenter@oracle.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
	h=date : from : to : cc
	: subject : message-id : references : mime-version : content-type :
	in-reply-to; s=corp-2017-10-26;
	bh=gEYv6jRziNSn7hKaOCADVHAfdRK+r0p8z7glGhh0lpk=;
	b=gMXJwfT003X6/HirAskao8ePXyESgbzdJeAvUywX2nT2U+aAiyCQ7rGpbY1QO5bJ2nHO
	HJKfqOxg16YsXPn58lYzjvTwQPe9PR4Bc0+4thZD1cSLovHvLGkDc3Outrv9fB9sSDGU
	/RNfGqEYqWDx58TYsqtnO37R1nC2/n768Ly0DbUzj8TtbMSItuHRu1NQh2Cu5WHxFh21
	UZKSgrC+lYqYrRCpLicyywPMn7v6Ws96LyqUKSBSv5LmHTqYYiINbvUMlM4DXL/4rAiU
	WLbrKg06haWO4Xtu+pH/v7iDKbQGDwkyrMGETbYmYCATbnY5K6F7n8bVtd/vNEM2IEnP
	EQ== 
Date: Tue, 29 May 2018 13:35:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Message-ID: <20180529103536.obpsftgvt3s7lle5@mwanda>
References: <cover.1527519997.git.petrm@mellanox.com>
	<85401f20b801fa1bae3025bf1df991a9d475fe85.1527519997.git.petrm@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85401f20b801fa1bae3025bf1df991a9d475fe85.1527519997.git.petrm@mellanox.com>
Subject: Re: [Bridge] [PATCH net-next v3 1/7] net: bridge: Extract
 boilerplate around switchdev_port_obj_*()
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>
Cc: devel@driverdev.osuosl.org, andrew@lunn.ch, f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, gregkh@linuxfoundation.org, davem@davemloft.net

On Mon, May 28, 2018 at 05:10:28PM +0200, Petr Machata wrote:
>  	/* Try switchdev op first. In case it is not supported, fallback to
>  	 * 8021q add.
>  	 */
> -	err = switchdev_port_obj_add(dev, &v.obj);
> +	int err = br_switchdev_port_vlan_add(dev, vid, flags);
>  	if (err == -EOPNOTSUPP)

This will introduce a checkpatch warning if you re-run with the --file
option.  (I haven't tested).  It's sort of ugly to put function logic in
the declaration block.  That's really just for initializing variables
like "int start = 0; struct foo *p = parent_of_bar();"  Do it like this
instead:

	int err;

	err = br_switchdev_port_vlan_add(dev, vid, flags);
	if (err == -EOPNOTSUPP)

regards,
dan carpenter

