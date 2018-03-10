Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=SiYprA06IMHpHx3OZqmrJ8bmMZ09KE7SoTCNnPflmNM=; 
	b=Oys4iprBpxAfv24Fbj/1l5bWbLoT60EtcFHnxhamhQZrW6u3SHz2qbJroFZwuNxCYp83BXriFGtdz8pX3MpUqoMC/Pj6MtbusCkF2tftHKgIHrxVaG/bzHx8DgXACzcn07N5QpPjnW1rY8rq7OeOUPTWNjxnWQwYdzlUOzjSr8I=;
Date: Sat, 10 Mar 2018 17:30:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20180310163050.GF29174@lunn.ch>
References: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
	<20180310030308.12947-2-igor.mitsyanko.os@quantenna.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310030308.12947-2-igor.mitsyanko.os@quantenna.com>
Subject: Re: [Bridge] [PATCH net-next 1/5] bridge: initialize port flags
 with switchdev defaults
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, sergey.matyukevich.os@quantenna.com, ashevchenko@quantenna.com, smaksimenko@quantenna.com, dlebed@quantenna.com

On Fri, Mar 09, 2018 at 07:03:04PM -0800, Igor Mitsyanko wrote:
> Default bridge port flags for switchdev devices can be different from
> what is used in bridging core. Get default value from switchdev itself
> on port initialization.
> 
> Signed-off-by: Igor Mitsyanko <igor.mitsyanko.os@quantenna.com>
> ---
>  net/bridge/br_if.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
> index 9ba4ed6..d658b55 100644
> --- a/net/bridge/br_if.c
> +++ b/net/bridge/br_if.c
> @@ -342,6 +342,21 @@ static int find_portno(struct net_bridge *br)
>  	return (index >= BR_MAX_PORTS) ? -EXFULL : index;
>  }
>  
> +static unsigned long nbp_flags_get_default(struct net_device *dev)
> +{
> +	struct switchdev_attr attr = {
> +		.orig_dev = dev,
> +		.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
> +	};
> +	int ret;
> +
> +	ret = switchdev_port_attr_get(dev, &attr);
> +	if (ret)
> +		return BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD | BR_BCAST_FLOOD;


Hi Igor

Please check if ret == -EOPNOTSUPP and only then use the defaults. A
real error should be propagated, causing new_nbp to fail. You might
also consider what to do when ENODATA is returned.

     Andrew
