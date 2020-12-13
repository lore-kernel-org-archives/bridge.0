Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+BjOxXb7d/HLHo33woNIMHOuryX58MLy5NrBZNm8XrM=;
 b=i04BhdscTr016PH0OMI+WWHAM/R2dj9iJUnwPbU3rPrn6HdYipyJQbR5wMokIuUwLA
 pxlOmDLFP71D8YWI6bPenb79Tz/UYM1UlMgdLO+sKXB8mhi7GV9vTz2V7npiAM8OqVXd
 b3QX/U4zo9bHWvD+04ErPAWgPbzIQZt+uhZATWEraY1T2QzgGmULeUaC1Z+nzg3O6VZ1
 Um7d52uQLL1f0UkJdle4QXc7R9IJ5GTnF8rUKZ8mXSs/TPCdAjT8UIsEvSanZBAWN2TX
 VZkG4JYBZZN4mlJKZZf+I9yvf6xDlCsEFnjwO9iYvCN/AL8MosEKX0jANf+oPjEngq2Q
 XIQQ==
References: <20201213024018.772586-1-vladimir.oltean@nxp.com>
 <20201213024018.772586-4-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <27e7d73b-1200-a9f1-94e3-5e494f54e49e@gmail.com>
Date: Sat, 12 Dec 2020 19:31:01 -0800
MIME-Version: 1.0
In-Reply-To: <20201213024018.772586-4-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next 3/6] net: dsa: move switchdev event
 implementation under the same switch/case statement
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
> We'll need to start listening to SWITCHDEV_FDB_{ADD,DEL}_TO_DEVICE
> events even for interfaces where dsa_slave_dev_check returns false, so
> we need that check inside the switch-case statement for SWITCHDEV_FDB_*.
> 
> This movement also avoids a useless allocation / free of switchdev_work
> on the untreated "default event" case.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
