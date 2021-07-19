Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WxKnE9VVIhW03+cH+9p6iQL7PxKsWgSsEqoZEEkW4H4=;
 b=FyBb6p+QwCom/Q45S/ycAcWLSxcczSHOGV3NQ1SizOB/wz6L44mjjsBfgTe1NIDILv
 Qs1wH0vYjb1g3PRufdBmip9lE9noEHSg95/B5nxgb4jdkH5N4+mudsjGP+SAXvQF6de1
 1RyBWkB5a+Mi/n3xN3Ag+v3xFMtVXyTFyQVgw29UfZNdv44uRtXA3aTRzBRwOnJ/Bb2j
 nd/hyOrKvVfb0iK997TxuLglVS1/Nf1PXLFrZZvvtkrDW9qSwNUxM6IECsipDleqsaOl
 ZLh7k9Nlov1kvpO2yyf1tOeicqrNkF9FD4cdlH/Cz49w/UXmjnwuZGzsnfbYkZxwh5SW
 CD2g==
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-15-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5915e957-8a22-54d4-fb56-aa080f21fce9@gmail.com>
Date: Sun, 18 Jul 2021 19:52:38 -0700
MIME-Version: 1.0
In-Reply-To: <20210718214434.3938850-15-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 14/15] net: dsa: mv88e6xxx: map
 virtual bridges with forwarding offload in the PVT
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Marek Behun <kabel@blackhole.sk>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>



On 7/18/2021 2:44 PM, Vladimir Oltean wrote:
> The mv88e6xxx switches have the ability to receive FORWARD (data plane)
> frames from the CPU port and route them according to the FDB. We can use
> this to offload the forwarding process of packets sent by the software
> bridge.
> 
> Because DSA supports bridge domain isolation between user ports, just
> sending FORWARD frames is not enough, as they might leak the intended
> broadcast domain of the bridge on behalf of which the packets are sent.
> 
> It should be noted that FORWARD frames are also (and typically) used to
> forward data plane packets on DSA links in cross-chip topologies. The
> FORWARD frame header contains the source port and switch ID, and
> switches receiving this frame header forward the packet according to
> their cross-chip port-based VLAN table (PVT).
> 
> To address the bridging domain isolation in the context of offloading
> the forwarding on TX, the idea is that we can reuse the parts of the PVT
> that don't have any physical switch mapped to them, one entry for each
> software bridge. The switches will therefore think that behind their
> upstream port lie many switches, all in fact backed up by software
> bridges through tag_dsa.c, which constructs FORWARD packets with the
> right switch ID corresponding to each bridge.
> 
> The mapping we use is absolutely trivial: DSA gives us a unique bridge
> number, and we add the number of the physical switches in the DSA switch
> tree to that, to obtain a unique virtual bridge device number to use in
> the PVT.
> 
> Co-developed-by: Tobias Waldekranz <tobias@waldekranz.com>
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
