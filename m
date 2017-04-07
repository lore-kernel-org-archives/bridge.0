Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-me-sender
	:x-me-sender:x-sasl-enc:x-sasl-enc; s=fm1; bh=8rnZ7KpLN9rym/go0w
	KgnJ3FeFENgVTwJECSfMf0+w0=; b=n78oZlGopEzW2/lQaku1w7evbv3SnuiJPt
	LVjJj8UPp46IPSdx4GbztTurVo23+hcXlTATU247349HEbKo3+ol0vOzuj3MUnPY
	Ohd9u+o+7ya7kwLYTsLs/hFeNPrzLfqEQW3quuhdSzaVYl9hABkaO2mQhCqLtd1Z
	7eWU4IViIJnL7dY3EyvU/ItTJEVszcgP41+zc+Gw5J/OyKQrLHLfhQzX39Z04pgy
	cqOHHauqlQKyeo6cZxyjm7C5Wz0xB93ZMjFlYEDT0QiATLIPdWon18bHL9GSus8n
	Uku5mOcfilBAs6+Vxa8HI2ncepWB2vSi4xTPQ0I1BAr4My60PdUg==
Date: Fri, 7 Apr 2017 21:16:49 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <20170407181649.GA21938@splinter>
References: <20170407124915.15508-1-idosch@mellanox.com>
	<20170407101055.745d95d0@plumbers-lap.home.lan>
	<3d567660-7fa5-979e-3097-89427270e554@cumulusnetworks.com>
	<20170407112206.77b515cd@plumbers-lap.home.lan>
	<23249e09-a712-920f-9a9f-850055aaf3af@cumulusnetworks.com>
	<20170407113615.15891fde@plumbers-lap.home.lan>
	<c3769204-4803-6c5f-1286-c8f1f5e045be@cumulusnetworks.com>
	<20170407133753.1602f3cd@plumbers-lap.home.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170407133753.1602f3cd@plumbers-lap.home.lan>
Subject: Re: [Bridge] [PATCH net] bridge: netlink: register netdevice before
 executing changelink
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: cera@cera.cz, mlxsw@mellanox.com, Nikolay Aleksandrov <nikolay@cumulusnetworks.com>, netdev@vger.kernel.org, peter@svinota.eu, bridge@lists.linux-foundation.org, idosch@mellanox.com, davem@davemloft.net

On Fri, Apr 07, 2017 at 01:37:53PM -0400, Stephen Hemminger wrote:
> Fix it right now. The patch you propose is too half baked.

Given this patch needs to be back ported to three different stable
kernels I tried to keep the amount of changes to a minimum while fixing
the bug.

I'll work on the ndo_uninit() patch and submit it. Then people can
decide which course of action they're more comfortable with.
