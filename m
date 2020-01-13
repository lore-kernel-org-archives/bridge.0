Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QwAoXOqjyyg/vJ5GZRN0tl9HB/BzOvUwdKHRpL6PwmI=; b=OvKpla9ORTpemj4RUAFr9Do/Ej
 d5IvnR79Rtu/GSeeBW7wb0+8Te29GyWtZruIrafjHVaz7flLIPYt/Z6Y9Yws0FHohEyeDONTTV/6q
 9DEyMxjGCmEaRFB9inmS+f/SSN+37wW0i66XpBaMOSSqtrIwJVnXEan9IFrMDtzspMsw=;
Date: Tue, 14 Jan 2020 00:30:11 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20200113233011.GF11788@lunn.ch>
References: <20200113124620.18657-1-horatiu.vultur@microchip.com>
 <20200113124620.18657-5-horatiu.vultur@microchip.com>
 <20200113140053.GE11788@lunn.ch>
 <20200113225751.jkkio4rztyuff4xj@soft-dev3.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113225751.jkkio4rztyuff4xj@soft-dev3.microsemi.net>
Subject: Re: [Bridge] [RFC net-next Patch v2 4/4] net: bridge: mrp:
 switchdev: Add HW offload
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: ivecera@redhat.com, jakub.kicinski@netronome.com, nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, vivien.didelot@gmail.com, UNGLinuxDriver@microchip.com, anirudh.venkataramanan@intel.com, dsahern@gmail.com, jiri@resnulli.us, olteanv@gmail.com, davem@davemloft.net

Hi Horatiu

It has been said a few times what the basic state machine should be in
user space. A pure software solution can use raw sockets to send and
receive MRP_Test test frames. When considering hardware acceleration,
the switchdev API you have proposed here seems quite simple. It should
not be too hard to map it to a set of netlink messages from userspace.

Yet your argument for kernel, not user space, is you are worried about
the parameters which need to be passed to the hardware offload engine.
In order to win the argument for a kernel solution, we are going to
need a better idea what you think this problem is. The MRP_Test is TLV
based. Are there other things which could be in this message? Is that
what you are worried about?

Thanks
     Andrew
