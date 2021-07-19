Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EsGNcxhUNDjpw3jd2PBLWZrFBrLemsllXRQ5T8XmNN4=;
 b=i/+5sh9nbghabMKPFon1cWSeCuZG+3hzirZxIEbeq1aVY1aSNB5SD/64V/P2ljBLGj
 0TH9h9ViC9rx7AtbR6Qm6zLtvezcyoObd3p78GjXf9qjNBEhGhQUXPPccJhqqQhfmMF0
 Jwn9N0TciYjAkDCYLaUcqZBplJ2qImSZw/AAzASnYHSf0/J6PgO83rWzKlK6YsRP+w6t
 cpXI0KrJ9WGHHSDfelz0EEaQ27mPxsBBE7T/HDHHwiUrBN1QacUTEBrH8YbGEmYJCREw
 C12qyBEEbRl6jPth9ZX2gFrxRXqgSonPBxkFsfaI9fbQx4ePhtX6GjTqQpayA9JC7uP/
 g2AA==
References: <20210718214434.3938850-1-vladimir.oltean@nxp.com>
 <20210718214434.3938850-6-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <df6e4013-31e4-39f6-3c40-52a897b3b723@gmail.com>
Date: Sun, 18 Jul 2021 19:20:34 -0700
MIME-Version: 1.0
In-Reply-To: <20210718214434.3938850-6-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 05/15] net: marvell: prestera:
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
Cc: Andrew Lunn <andrew@lunn.ch>, Grygorii Strashko <grygorii.strashko@ti.com>, Jiri Pirko <jiri@resnulli.us>, DENG Qingfang <dqfext@gmail.com>, Vadym Kochan <vkochan@marvell.com>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@idosch.org>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, Marek Behun <kabel@blackhole.sk>, Taras Chornyi <tchornyi@marvell.com>, Vivien Didelot <vivien.didelot@gmail.com>, Tobias Waldekranz <tobias@waldekranz.com>



On 7/18/2021 2:44 PM, Vladimir Oltean wrote:
> In preparation of adding more code to the NETDEV_PRECHANGEUPPER handler,
> move the existing sanity checks into a dedicated function.
> 
> Cc: Vadym Kochan <vkochan@marvell.com>
> Cc: Taras Chornyi <tchornyi@marvell.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
