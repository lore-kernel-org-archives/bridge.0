Return-Path: <ilias.apalodimas@linaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-disposition:in-reply-to:user-agent;
	bh=FfsKS1anQyrWaxz0gKHtVSfRn+O7yyZlv/GApq4l5Qk=;
	b=GXQtPyW1BI1I0RZvdQYAA+0rREJKWms7xTFarXNyDfV4mJ/hN8p02FkfD6mQ7sd1/P
	zVNA/4gnDkN792rTik2GqUi3Ty/IFYUoQF5yOI2I/eaD7CKGc+r3AKFRne7LzDOXF0UE
	KtKSKr4hRuJEenRKVgIsOOX8Fix1fxgKIHnv8=
Date: Tue, 29 May 2018 17:44:58 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Message-ID: <20180529144458.GA27555@apalos>
References: <cover.1527503302.git.petrm@mellanox.com>
	<708f594ac6cef4a63a6f6a28759098c4d7922976.1527503302.git.petrm@mellanox.com>
	<20180529102543.GA1883@apalos>
	<wihvab6eded.fsf@dev-r-vrt-156.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wihvab6eded.fsf@dev-r-vrt-156.mtr.labs.mlnx>
Subject: Re: [Bridge] [PATCH net-next v2 3/7] rocker: rocker_main: Ignore
 bridge VLAN events
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@mellanox.com>
Cc: devel@driverdev.osuosl.org, f.fainelli@gmail.com, andrew@lunn.ch, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, idosch@mellanox.com, jiri@mellanox.com, razvan.stefanescu@nxp.com, gregkh@linuxfoundation.org, vivien.didelot@savoirfairelinux.com, davem@davemloft.net

On Tue, May 29, 2018 at 05:37:30PM +0300, Petr Machata wrote:
> Ilias Apalodimas <ilias.apalodimas@linaro.org> writes:
> 
> >> diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
> >> index e73e4fe..aeafdb9 100644
> >> --- a/drivers/net/ethernet/rocker/rocker_main.c
> >> +++ b/drivers/net/ethernet/rocker/rocker_main.c
> >> @@ -1632,6 +1632,9 @@ rocker_world_port_obj_vlan_add(struct rocker_port *rocker_port,
> >>  {
> >>  	struct rocker_world_ops *wops = rocker_port->rocker->wops;
> >>  
> >> +	if (netif_is_bridge_master(vlan->obj.orig_dev))
> >> +		return -EOPNOTSUPP;
> >> +
> > What will happen to the "bridge vlan add dev br0 vid X pvid untagged self" when
> > the lower level (the driver) returns -EOPNOTSUPP? Will it avoid adding a vlan on
> > the bridge ?
> 
> No, it will still do it. The reasons are:
> 
> - that's what currently happens anyway: none of the drivers has any
>   support, yet the bridge logic is done
> 
> - -EOPNOTSUPP is what switchdev_port_obj_*() return if switchdev is not
>   compiled in
> 
> In order to suppress the setting, return e.g. -EINVAL:
> 
> # bridge vlan add dev br vid 111 self
> RTNETLINK answers: Invalid argument
> # bridge vlan show dev br
> port    vlan ids
> br       1 PVID Egress Untagged
> 
> Thanks,
> Petr
Ok that's perfect then. As i mentioned it's really useful for a use case i am
doing on a switch that needs it's cpu port configured individually.

Thanks,
Ilias
