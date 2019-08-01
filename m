Return-Path: <Horatiu.Vultur@microchip.com>
Date: Thu, 1 Aug 2019 21:48:02 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
Message-ID: <20190801194801.rqv5jvb5vxjo2dor@soft-dev3.microsemi.net>
References: <1564055044-27593-1-git-send-email-horatiu.vultur@microchip.com>
	<20190801151739.GB32290@t480s.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20190801151739.GB32290@t480s.localdomain>
Subject: Re: [Bridge] [PATCH] net: bridge: Allow bridge to joing multicast
	groups
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vivien Didelot <vivien.didelot@gmail.com>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, allan.nielsen@microchip.com, davem@davemloft.net

Hi Vivien,

The 08/01/2019 15:17, Vivien Didelot wrote:
> External E-Mail
> 
> I'm a bit late in the conversation. Isn't this what you want?
> 
>     ip address add <multicast IPv4 address> dev br0 autojoin
> 

Not really, I was looking in a way to register the ports to link layer
multicast address. Sorry for the confusion, my description of the patch
was totally missleaning.

If you follow this thread you will get a better idea what we wanted to
achive. We got some really good comments and based on these we send a
RFC[1]. 

> 
> Thanks,
> Vivien

[1] https://patchwork.ozlabs.org/patch/1140468/

-- 
/Horatiu
