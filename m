Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1645557324;
 bh=U9jeNgWTnREJMOGMhNcgz9fVNyZ6v4l6J7nfG6DOUbE=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=kWXWCyLxNVANdV5eeEktWoPfKTJphflfJSUcU4jZVaHQnJS0AraA+Bh2WccNDGPND
 Pti8QeNuH9VF2E7xzHou4j9QEiodZABeC+pcnhnsuoPclcK0Ldy1wmzGaFsdMbkLWT
 gIYz/w3E5EcBBxUBy6ui1nhgwVxRpq4WfiyNESnOHNnsu0dTIPVY+NQvUFhlEzu/ss
 wMrfr3tH9sJyyadZck4iJJdBRodB93wuyZd05mJUmaoZtOZiQnpa4THmg4kF4nTD80
 fmGqUM2ffmFxPPSk3TiZlvFEFWzaIxeUwSYKjK1lJCYYntMBNODSm3spMFLl9rWQUy
 a4FMqFCBPLjpQ==
Date: Tue, 22 Feb 2022 11:15:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20220222111523.030ab13d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20220222132818.1180786-1-schultz.hans+netdev@gmail.com>
References: <20220222132818.1180786-1-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH net-next v4 0/5] Add support for locked bridge
 ports (for 802.1X)
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Baowen Zheng <baowen.zheng@corigine.com>, Florian Fainelli <f.fainelli@gmail.com>, Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Stephen Suryaputra <ssuryaextr@gmail.com>, Po-Hsu Lin <po-hsu.lin@canonical.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Tue, 22 Feb 2022 14:28:13 +0100 Hans Schultz wrote:
> This series starts by adding support for SA filtering to the bridge,
> which is then allowed to be offloaded to switchdev devices. Furthermore
> an offloading implementation is supplied for the mv88e6xxx driver.
> 
> Public Local Area Networks are often deployed such that there is a
> risk of unauthorized or unattended clients getting access to the LAN.
> To prevent such access we introduce SA filtering, such that ports
> designated as secure ports are set in locked mode, so that only
> authorized source MAC addresses are given access by adding them to
> the bridges forwarding database. Incoming packets with source MAC
> addresses that are not in the forwarding database of the bridge are
> discarded. It is then the task of user space daemons to populate the
> bridge's forwarding database with static entries of authorized entities.
> 
> The most common approach is to use the IEEE 802.1X protocol to take
> care of the authorization of allowed users to gain access by opening
> for the source address of the authorized host.
> 
> With the current use of the bridge parameter in hostapd, there is
> a limitation in using this for IEEE 802.1X port authentication. It
> depends on hostapd attaching the port on which it has a successful
> authentication to the bridge, but that only allows for a single
> authentication per port. This patch set allows for the use of
> IEEE 802.1X port authentication in a more general network context with
> multiple 802.1X aware hosts behind a single port as depicted, which is
> a commonly used commercial use-case, as it is only the number of
> available entries in the forwarding database that limits the number of
> authenticated clients.
> 
>       +--------------------------------+
>       |                                |
>       |      Bridge/Authenticator      |
>       |                                |
>       +-------------+------------------+
>        802.1X port  |
>                     |
>                     |
>              +------+-------+
>              |              |
>              |  Hub/Switch  |
>              |              |
>              +-+----------+-+
>                |          |
>             +--+--+    +--+--+
>             |     |    |     |
>     Hosts   |  a  |    |  b  |   . . .
>             |     |    |     |
>             +-----+    +-----+
> 
> The 802.1X standard involves three different components, a Supplicant
> (Host), an Authenticator (Network Access Point) and an Authentication
> Server which is typically a Radius server. This patch set thus enables
> the bridge module together with an authenticator application to serve
> as an Authenticator on designated ports.
> 
> 
> For the bridge to become an IEEE 802.1X Authenticator, a solution using
> hostapd with the bridge driver can be found at
> https://github.com/westermo/hostapd/tree/bridge_driver .
> 
> 
> The relevant components work transparently in relation to if it is the
> bridge module or the offloaded switchcore case that is in use.

You still haven't answer my question. Is the data plane clear text in
the deployment you describe?
