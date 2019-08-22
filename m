Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Ouh1hyA4cnUUtU66BbaszA14lgEbgI+hW7TPxZskfjA=;
	b=2YBLfaiSJjF9YvxwEJ63tFNfLf
	NgaAM1cajy0G+MKXV0ek0VyWAA2A2jdYFKagzeAznZj+f1uhGOamR9xPHUmjNRKRI4NEn774Y6oog
	pQlCVkQA/uY9HkHC7rtBXUbBi13ZDESxVdM4S/9OOKhAMjzpFLWZeDaaKqoJ3UxH5oH4=; 
Date: Thu, 22 Aug 2019 22:08:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20190822200817.GD21295@lunn.ch>
References: <1566500850-6247-1-git-send-email-horatiu.vultur@microchip.com>
	<1566500850-6247-2-git-send-email-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566500850-6247-2-git-send-email-horatiu.vultur@microchip.com>
Subject: Re: [Bridge] [PATCH 1/3] net: Add HW_BRIDGE offload feature
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: alexandre.belloni@bootlin.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, allan.nielsen@microchip.com, davem@davemloft.net

> +/* Determin if the SW bridge can be offloaded to HW. Return true if all
> + * the interfaces of the bridge have the feature NETIF_F_HW_SWITCHDEV set
> + * and have the same netdev_ops.
> + */

Hi Horatiu

Why do you need these restrictions. The HW bridge should be able to
learn that a destination MAC address can be reached via the SW
bridge. The software bridge can then forward it out the correct
interface.

Or are you saying your hardware cannot learn from frames which come
from the CPU?

	Andrew
