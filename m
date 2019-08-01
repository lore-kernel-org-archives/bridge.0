Return-Path: <vivien.didelot@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=date:message-id:from:to:cc:subject:in-reply-to:references
	:mime-version:content-disposition:content-transfer-encoding;
	bh=B+yDfdKT+RmatLe61Ax4/UEmkLt8JT8gE8mDRLs1ASo=;
	b=F2DtJQPVW600MwUqAoGNDBJim0olwalXuP0oaVzNa0fuigELEEjv1TPS9O2t4zW1XQ
	pXpruzdZOB/VBi3a/Ru2xZqOapjbUY0dPt4Dayk+xHSRgZZVajTvGk70Z2HIA5Y5cMwl
	ambxZXgnsb/qDkp7nYq3cJFgRehXf/PvlySs2VBmdpH+M5ZDNJxP9VCfgdVNdKV17ZGT
	ES8W4E3m+l2EhVQavzX1ZQ+2ImO1izjQsAj5HIa8nYb0s2XUwvrhRfs4a+oxfu/a5Z1X
	VDRc8KtlnltBx/XBJhhIbBM1tf19KqXDgLfg7P/EJ+wO60b9kMWEw1/tLyFLRY/BaNsl
	MQaw==
Date: Thu, 1 Aug 2019 16:08:17 -0400
Message-ID: <20190801160817.GB9619@t480s.localdomain>
From: Vivien Didelot <vivien.didelot@gmail.com>
In-Reply-To: <20190801194801.rqv5jvb5vxjo2dor@soft-dev3.microsemi.net>
References: <1564055044-27593-1-git-send-email-horatiu.vultur@microchip.com>
	<20190801151739.GB32290@t480s.localdomain>
	<20190801194801.rqv5jvb5vxjo2dor@soft-dev3.microsemi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: nikolay@cumulusnetworks.com, netdev@vger.kernel.org, roopa@cumulusnetworks.com, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, allan.nielsen@microchip.com, davem@davemloft.net

Hi Horatiu,

On Thu, 1 Aug 2019 21:48:02 +0200, Horatiu Vultur <horatiu.vultur@microchip.com> wrote:
> > I'm a bit late in the conversation. Isn't this what you want?
> > 
> >     ip address add <multicast IPv4 address> dev br0 autojoin
> > 
> 
> Not really, I was looking in a way to register the ports to link layer
> multicast address. Sorry for the confusion, my description of the patch
> was totally missleaning.
> 
> If you follow this thread you will get a better idea what we wanted to
> achive. We got some really good comments and based on these we send a
> RFC[1]. 

OK great! Keep me in the loop, I enjoy bridge and multicast very much ;-)


Thanks,

	Vivien
