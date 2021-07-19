Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jNyhd+T/9d9anCSoGKOeiOQZUa2KbCVT/Y/R829odA0=;
 b=kd/pME7pXs/YdCnqRxrbKWW2Gqhh4kDLHBsOyRE8A6RrQ4YCNnLEY8zQpEReVUMEL6
 32d7JKq2Ik57CpKb5yj4J4ir46O6OlRuw9a6txjY/gXQebtX/JQ2Z/eK/AbTzyixQH46
 9QD+WkAvH6nzjE6vnvHWZly7cMi1PYLIL5Cg7ulFOQ/R1DmyQ7nljIXBOP7c9nz+YJNT
 jtgmuguBRRu1PVkqPcaxNOUFMxrYm2T1yTZfFxQhsCvdrgoriH6lC2XZSuB3mHqSmAu1
 QnzJHTH5fYBIaafDUTK60wUDyyHCWKcE94NDgNHr7mCrA7D3dMTAhbbDIrFeKX+W1AAO
 jLNw==
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-16-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7c2b81e8-db72-4665-fe81-7254cba1e797@gmail.com>
Date: Sun, 18 Jul 2021 19:47:22 -0700
MIME-Version: 1.0
In-Reply-To: <20210718214434.3938850-16-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 15/15] net: dsa: tag_dsa: offload
 the bridge forwarding process
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
> From: Tobias Waldekranz <tobias@waldekranz.com>
> 
> Allow the DSA tagger to generate FORWARD frames for offloaded skbs
> sent from a bridge that we offload, allowing the switch to handle any
> frame replication that may be required. This also means that source
> address learning takes place on packets sent from the CPU, meaning
> that return traffic no longer needs to be flooded as unknown unicast.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

This looks pretty complicated to but if this is how it has to work, it 
has to. For tag_brcm.c we can simply indicate that the frame to be 
transmitted should have a specific bitmask of egress ports.
-- 
Florian
