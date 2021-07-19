Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cTgRVDtghkxyZQfyDmHBQUQJXuRVf+/7cKDTFF5F3gU=;
 b=WApIw/si/Yd74Gfm/puLIoV+MV73/wft6KVqOYzzRSPaigvY6OpdaVlC/cS5RQ8q5B
 /+Pjjkuhd+hHdwGQp57T3/vu+DvRQhT8Nb90oqM+FgYkXYJgnRvqhNm39bD2J2Y26LJI
 jezveRuR3nPFvRjOfotkB8rp1Da62ymknwU+6Z6X15PO/0Yj6Xaqs0aCp0hLp82ruqPg
 7UhyqUxAPvqgAdZH5xligAUF/n2Y/W3/UhVCLtj2WBoYETEy590Pb4pggKXgCf3gxVLQ
 9Mgxd32atma7EiA2sROLHNjmmawK40+NYfjeqkQegss+sIZyjrBzPMox0h8di2X3DQh/
 ePmw==
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-7-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <d4ee8b6c-d171-9b7d-130b-d244de756cfe@gmail.com>
Date: Sun, 18 Jul 2021 19:17:52 -0700
MIME-Version: 1.0
In-Reply-To: <20210718214434.3938850-7-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 06/15] net: switchdev: guard
 drivers against multiple obj replays on same bridge port
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, Vadym Kochan <vkochan@marvell.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Marek Behun <kabel@blackhole.sk>, Taras Chornyi <tchornyi@marvell.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>



On 7/18/2021 2:44 PM, Vladimir Oltean wrote:
> Prepare the drivers which support LAG offload but don't have support for
> switchdev object replay yet, i.e. the mlxsw and prestera drivers, to
> deal with bridge switchdev objects being replayed on the LAG bridge port
> multiple times, once for each time a physical port beneath the LAG calls
> switchdev_bridge_port_offload().
> 
> Cc: Vadym Kochan <vkochan@marvell.com>
> Cc: Taras Chornyi <tchornyi@marvell.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
