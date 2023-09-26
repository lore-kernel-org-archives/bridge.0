Return-Path: <idosch@idosch.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE4DD8230F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4BF6F82309
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm2; t=1695728583; x=1695814983; bh=rAbItrXU3DjBe
 WT6zjvCvCs+hZImWYb77PlbQjt+Gtk=; b=GoXutLAlWTYBq2WBbmt9rkR/5Ww66
 o8C17Gcf06+SBEzqQfA3ajzVDLeipwbokWndu6Rwg4GPzMr+nMG28FAOHL/JKpoV
 yjuh6TrHDn7OWEsItqBYSQU3ZzjfmB+aifDxy9Sfw3aBGB+ye58hIYuKlIkZILFi
 BFI0Hb+AJhowyZB8peVw5pmsu9tsR63yr3xQEpkbighP+KIVuhASXp/VyL6B+FH/
 PYe54U/Dyyt0dZu6NsOo3sZ4SXmsQ/NRgUzFprRosDDbEW5HSPmMIRZi/uaBJYdP
 Wrv2MhvhYAhWz3xDevbdmi9glU07EUJ1J66cLZYYkh0ritk8PZCqV9+vQ==
Date: Tue, 26 Sep 2023 14:42:59 +0300
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <ZRLDw45mpeU6tBaK@shredder>
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-5-39f0293807b8@avm.de>
 <cc14cd4a-f3bb-3d6f-5b38-ec73cad32570@blackwall.org>
 <ZQv5aNbgqxCuOKyr@u-jnixdorf.ads.avm.de>
 <50814314-55a3-6cff-2e9e-2abf93fa5f1b@blackwall.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50814314-55a3-6cff-2e9e-2abf93fa5f1b@blackwall.org>
Subject: Re: [Bridge] [PATCH net-next v4 5/6] net: bridge: Add a
 configurable default FDB learning limit
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Johannes Nixdorf <jnixdorf-oss@avm.de>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-kernel@vger.kernel.org, Oleksij Rempel <linux@rempel-privat.de>, Vladimir Oltean <vladimir.oltean@nxp.com>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, David Ahern <dsahern@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>

On Thu, Sep 21, 2023 at 01:19:44PM +0300, Nikolay Aleksandrov wrote:
> I'm not strongly against, just IMO it is unnecessary. I won't block the set
> because of this, but it would be nice to get input from others as
> well. If you can recompile your kernel to set a limit, it should be easier
> to change your app to set the same limit via netlink, but I'm not familiar
> with your use case.

I agree with keeping it out. We don't have it for similar knobs (e.g.,
MDB limits) and it would create a precedence for other bridge options
instead of simply using netlink and improving user space applications.
