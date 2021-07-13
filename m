Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=b+O/hTBAU4c7+jLOai3Zz6MaQKuBMbZ0EUKpHZHXDNE=;
 b=e7zsc5BS3yHMk+8OPMv0qI6y+OWRBhRSm9i4Z6fPvikbFTRhq40T75sktruWKK4MRv
 02bn5jxlqz/eHoCUNgJRR8QMbBqBNDfFWnLnbkfJVR60XqW33M5Ususy+oa2+ROi7u8U
 ZwE0oXRa5n3+zbTRZh7EfXN6XkPNlYYG1J/xlBN0TA8xOJhocNwHyqJ6xcmnRB+GODFT
 nBxBu5DuIU/87/cx7RrDYtffl6KoYqWVpgXW0BvGBO5fnR2gaUhSSbGpkcvLO0226FKH
 LR/mGBD9VBb6FS9etFtAL6/0Wk3JVnLT++0gvmLP5P0WvTszhHpDXy0g8H9dzVhy36Tb
 3TAQ==
References: <20210712152142.800651-1-vladimir.oltean@nxp.com>
 <20210712152142.800651-3-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <20515ce3-7286-931a-e086-1778dfafa7a1@gmail.com>
Date: Mon, 12 Jul 2021 19:21:10 -0700
MIME-Version: 1.0
In-Reply-To: <20210712152142.800651-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH v3 net-next 02/24] net: dpaa2-switch:
 refactor prechangeupper sanity checks
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>



On 7/12/2021 8:21 AM, Vladimir Oltean wrote:
> Make more room for some extra code in the NETDEV_PRECHANGEUPPER handler
> by moving what already exists into a dedicated function.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
