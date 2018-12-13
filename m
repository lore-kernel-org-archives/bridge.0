Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=HeLzfWZPx9BM4oAuoBLgLcdsIdjkgue4mT68Hl/YfnI=; 
	b=NoOrbUnqogY+Y03d+yVBasdc2JnRtvaZkGwqfJ22yjCzZZ+h40fcgrfBbr5rOAlPJMdXDkw9XvI8Dz5/Ci0QjPx0Mlda/0bU9EjIsn6i6nyxWa86qFkaLxUsVmum6+cBZMowoW/OS1mwR627tYwC2VDZ+nCcnOiUHTbsHt0tmVE=;
Date: Thu, 13 Dec 2018 10:26:30 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20181213092630.GD1605@lunn.ch>
References: <20181212230943.757-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212230943.757-1-f.fainelli@gmail.com>
Subject: Re: [Bridge] [PATCH net-next] Documentation: networking: Clarify
 switchdev devices behavior
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, vivien.didelot@gmail.com, idosch@mellanox.com, jiri@mellanox.com, davem@davemloft.net

> +VLAN filtering
> +~~~~~~~~~~~~~~
> +
> +The Linux bridge allows the configuration of a VLAN filtering mode (compile and
> +run time) which must be observed by the underlying switchdev network
> +device/hardware:
> +
> +- with VLAN filtering turned off: frames ingressing the device with a VID that
> +  is not programmed into the bridge/switch's VLAN table must be forwarded.
> +
> +- with VLAN filtering turned on: frames ingressing the device with a VID that is
> +  not programmed into the bridges/switch's VLAN table must be dropped.

Hi Florian

i forget the details, but there are some difference between VLAN
filtering being disabled at compile time, and disabled at runtime. I
think the expected behaviour is the same, but the switchdev API usage
is slightly different.

> +- when IGMP snooping is turned on, multicast traffic must be selectively flowing
> +  to the appropriate network ports and not flood the entire switch, that must
> +  include the CPU/management port.

224.0.0.X/32 should always be flooded, IGMP is optional for those
groups in the local subnet.

	Andrew
