Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=HtMS2+9V7qd6zUhJqmshIHceW7JGRRmz5hCKeup/FwU=;
 b=v1E7SzBfSt8587wvWB/smgDMZ9JEHt+ZoQNwOn2uA49pYqLeUsEf7felGz0ynrFCTS
 Ti6vYpZHB2JzO6+pYzVwPVQffy63WI+ZOLfXgGKBUkBeAALAOVtAOpDhKmoZYipOcbIU
 CtPpPvHUhDP81OKvzPH7kVJQ+uhR6M92XhPfqT/vIM5IrWl+QFCfYZ0v8TDfx/gMLTUj
 1tV8l9+DZRyAmp1s+HCBoTXinca+zvnDhe+4NiXFOUpx4Py90gI8tXCgFeF+DpVeyfqC
 /KqwuVs7uVIc9JUwSDFpYEYaCUTh3L1YqKugIfg0TiAlYaPH9MIMh076qLIpRJVjyXQ4
 w1qw==
Message-ID: <0005fbf1-0c14-2ffe-617b-a770dcc1240c@blackwall.org>
Date: Thu, 17 Mar 2022 11:01:43 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220316150857.2442916-1-tobias@waldekranz.com>
 <20220316150857.2442916-10-tobias@waldekranz.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220316150857.2442916-10-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 09/15] net: bridge: mst: Add helper
 to query a port's MST state
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Petr Machata <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, bridge@lists.linux-foundation.org, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

On 16/03/2022 17:08, Tobias Waldekranz wrote:
> This is useful for switchdev drivers who are offloading MST states
> into hardware. As an example, a driver may wish to flush the FDB for a
> port when it transitions from forwarding to blocking - which means
> that the previous state must be discoverable.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  include/linux/if_bridge.h |  6 ++++++
>  net/bridge/br_mst.c       | 25 +++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

