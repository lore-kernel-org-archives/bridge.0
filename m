Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/uAT0LRlvL6fbNuydQ0A53uGpAnx3j1J3+NiJXl3x7U=; b=OqEfS3UcXkdg9h4WbKKcVQgC/t
 5/PuS0PCXTBINgJePmxDpcTK5KQztSXpJgIYQQkWChc0lhdBoDTsYQgPRevDqsYXcqwM+JSzNKOHo
 g0Xi+Pk3qhWC76LuLhaSOXhleHrje3xPU7KBOF9I/lYZ4M+dWDX2MhaBwotRxdgl0ChU=;
Date: Sat, 25 Jan 2020 17:35:04 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20200125163504.GF18311@lunn.ch>
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200124161828.12206-7-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124161828.12206-7-horatiu.vultur@microchip.com>
Subject: Re: [Bridge] [RFC net-next v3 06/10] net: bridge: mrp: switchdev:
 Extend switchdev API to offload MRP
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: ivecera@redhat.com, jiri@resnulli.us, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, jeffrey.t.kirsher@intel.com, olteanv@gmail.com, davem@davemloft.net

> SWITCHDEV_OBJ_ID_RING_TEST_MRP: This is used when to start/stop sending
>   MRP_Test frames on the mrp ring ports. This is called only on nodes that have
>   the role Media Redundancy Manager.

How do you handle the 'headless chicken' scenario? User space tells
the port to start sending MRP_Test frames. It then dies. The hardware
continues sending these messages, and the neighbours thinks everything
is O.K, but in reality the state machine is dead, and when the ring
breaks, the daemon is not there to fix it?

And it is not just the daemon that could die. The kernel could opps or
deadlock, etc.

For a robust design, it seems like SWITCHDEV_OBJ_ID_RING_TEST_MRP
should mean: start sending MRP_Test frames for the next X seconds, and
then stop. And the request is repeated every X-1 seconds.

     Andrew
