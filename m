Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=8ZZlmqC5VFB+TpGNzx3hi7Wlj0HQtNbpALYNMUhypww=;
 b=nIgBjOLQD1J7QK6kKh4kQuZuvR0bB1+otQ7TZDdrnqTfUYfWIMdVfMIcC+ia9FYnEl
 fUD5UAEae9GmQjkitTfcBXsqeF8XkckgfF+k6esCH2FqSv1QhiY94QJLTI/ajXmcVzbN
 9s2oGAgYu5IJ7CkD265nYF8+WiusP4qqMH9zZYLg0v+kbIYPKHtaGXuZsO9BImtR16CZ
 HZn3hc6vsGf0z8GuqmhW/7UAE/bxoN5KGlod0MLxnIcXQhp/0wdJMn0S9loIjGUuZTqF
 l06zo9FUxvqHhLSN3Suk3R58+sRQL1zxvKN4VIZlPQ/HM4zrIiSaR8tuk+4/f6P8ORej
 YvZA==
Date: Wed, 16 Mar 2022 15:02:56 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220316130256.3hgbllxioz4igxen@skbuf>
References: <20220315002543.190587-1-tobias@waldekranz.com>
 <20220315002543.190587-13-tobias@waldekranz.com>
 <20220315164249.sjgi6wbdpgehc6m6@skbuf>
 <87zglqjkmk.fsf@waldekranz.com> <87wngujkdm.fsf@waldekranz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wngujkdm.fsf@waldekranz.com>
Subject: Re: [Bridge] [PATCH v4 net-next 12/15] net: dsa: Handle MST state
	changes
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, Vivien Didelot <vivien.didelot@gmail.com>, Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Matt Johnston <matt@codeconstruct.com.au>, davem@davemloft.net, linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 10:51:17AM +0100, Tobias Waldekranz wrote:
> > Question though:
> >
> >>> +			err = dsa_port_msti_fast_age(dp, state->msti);
> >
> > If _msti_fast_age returns an error here, do we want that to bubble up to
> > the bridge? It seems more important to keep the bridge in sync with the
> > hardware. I.e. the hardware state has already been successfully synced,
> > we just weren't able to flush all VLANs for some reason. We could revert
> > the state I guess, but what if that fails?
> >
> > Should we settle for a log message?
> 
> Or should we set the extack message? Similar to how we report software
> fallback of bridging/LAGs?

A warning extack and chug along sounds great. The worst that can happen
if flushing a VLAN's FDB fails is that the topology will reconverge slower.
