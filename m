Return-Path: <idosch@idosch.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Yvnr3v2tgrcuFJVW9
 1DwvZDH1eh06TJONAa+U9Dt9oM=; b=jYUR6Uwyn9IQKJVxk8c8PSCCe5ycjH2gF
 4BDpzfBCYkD0yJLcPaUPP1nq7ovA1nhkCehFsPz9EhUrqsDf5EqMTlW1VfxmR7H9
 OHG/6bG1RZdgxiKDz9o++kPAEySVeKDu+W9ZWVsQqiaLhG6utgiL8OuRrnFUX4H3
 MA7fRHcK2GMSRxQ2Kqkire8ff2/r3Ra14zK4NR7pfejyQmQv5L1g3p7Jwdrz5tCU
 wRc8zd3to8GQ1NRWEIyYVT2+8HNSYxnDG6SL8lFOt5bVTpr/Mxn3N0y+Rf3OXSym
 k8Pyg12rEK6wwMq32kNIMiRNkHuTQ2nEz1FqD2Nmqj85X9ZMzmkFg==
Date: Sun, 20 Feb 2022 11:19:10 +0200
From: Ido Schimmel <idosch@idosch.org>
Message-ID: <YhIHjprGjuRLsSRE@shredder>
References: <20220218155148.2329797-1-schultz.hans+netdev@gmail.com>
 <20220218155148.2329797-3-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218155148.2329797-3-schultz.hans+netdev@gmail.com>
Subject: Re: [Bridge] [PATCH net-next v3 2/5] net: bridge: Add support for
 offloading of locked port flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Baowen Zheng <baowen.zheng@corigine.com>, Florian Fainelli <f.fainelli@gmail.com>, Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Stephen Suryaputra <ssuryaextr@gmail.com>, Po-Hsu Lin <po-hsu.lin@canonical.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Vladimir Oltean <olteanv@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Fri, Feb 18, 2022 at 04:51:45PM +0100, Hans Schultz wrote:
> Various switchcores support setting ports in locked mode, so that
> clients behind locked ports cannot send traffic through the port
> unless a fdb entry is added with the clients MAC address.
> 
> Signed-off-by: Hans Schultz <schultz.hans+netdev@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
