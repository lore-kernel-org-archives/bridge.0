Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QE8kvUfJGF+/tFxP2a7cjpaKSjXf6+aoJtP3goq60E8=;
 b=FxDybe6qZY0cVdUS6zEjz2Kig7c/aw/0vQ9uFAhhVTX5qCeQ4PldrHo6OcbKoMO6/c
 wgmGI0A+ypYSkoiG2bZp9LM0wXCzGbldKot7nZ0Ohx7xLenhLUAmoEXG0Zp0hthrKOye
 6ehYmXkOpC6r7CdexxjIPU9/PCFn59uKuMo+ps1vLzMf7MczFknbxs0pgoh4MlLg/Crt
 4MEr764TbawspH662uTEU/w2p+9165jNTSRCmNgLdHVsFQBsI42uTktL3edf/bzm90Ho
 xBxXniDsxjOqy1X9M1JWaYroo2tsf2o5ou8HJJzPd2cB/xm3yHmtvVWHJ67BImvJeiDC
 BYxw==
References: <20201213024018.772586-1-vladimir.oltean@nxp.com>
 <20201213024018.772586-7-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <77d952ad-0aed-8e79-df03-ee6a7f42ef55@gmail.com>
Date: Sat, 12 Dec 2020 19:49:34 -0800
MIME-Version: 1.0
In-Reply-To: <20201213024018.772586-7-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next 6/6] net: dsa: ocelot: request DSA
 to fix up lack of address learning on CPU port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>
Cc: Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Ido Schimmel <idosch@idosch.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Marek Behun <marek.behun@nic.cz>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Tobias Waldekranz <tobias@waldekranz.com>



On 12/12/2020 6:40 PM, Vladimir Oltean wrote:
> Given the following setup:
> 
> ip link add br0 type bridge
> ip link set eno0 master br0
> ip link set swp0 master br0
> ip link set swp1 master br0
> ip link set swp2 master br0
> ip link set swp3 master br0
> 
> Currently, packets received on a DSA slave interface (such as swp0)
> which should be routed by the software bridge towards a non-switch port
> (such as eno0) are also flooded towards the other switch ports (swp1,
> swp2, swp3) because the destination is unknown to the hardware switch.
> 
> This patch addresses the issue by monitoring the addresses learnt by the
> software bridge on eno0, and adding/deleting them as static FDB entries
> on the CPU port accordingly.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
