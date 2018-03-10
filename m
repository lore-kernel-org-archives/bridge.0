Return-Path: <andrew@lunn.ch>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; 
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date;
	bh=55NhEKjnVsHYmsxj7hLEzrgIiD+Y5E8MoR5gkY8KNzk=; 
	b=yCEpbMn2rM0WAlpShBUBKer4H54qFmGPtjrdsKJuVhwYCSjmjen28S7o/KTcDYM8TTWaJSIx2HjU3/0DhvRMwbcoZi9Y4oLnkhIUmxPyJkrCtlLx+pxi4ikoKGKm7jw81bbDA+BpbJecUrHJBereBDM+xl7plIxs+/iMjCacDtw=;
Date: Sat, 10 Mar 2018 23:08:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20180310220850.GI29174@lunn.ch>
References: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310030308.12947-1-igor.mitsyanko.os@quantenna.com>
Subject: Re: [Bridge] [PATCH net-next 0/5] Switchdev: flooding offload option
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

On Fri, Mar 09, 2018 at 07:03:03PM -0800, Igor Mitsyanko wrote:
> Main goal of the patchset is to allow for flooding offload to switchdev
> in scenarios when HW switchdev ports and SW ports are operating in a
> single bridge.
> 
> In case a data frame that needs to be flooded is ingressed on a SW port,
>     it needs to be flooded to a single HW port of any given
>     switchdev-capable hardware only. Switchdev hardware will than take care
>     about flooding to the rest of the ports that it manages.

Hi Igor

You don't appear to be adding any user of this. Please also make one
of the switchdev drivers actually use this new functionality.

   Andrew
