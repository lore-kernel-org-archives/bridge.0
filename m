Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aLMv7bv//grEdHcZE3Ga0rjuWlHjH5Gf0eUa19zRJrQ=;
 b=sA271PWlMNitfIcgRi1Rvcy+v+0cABEo3Du/WflzKU/dTtae3WDiwSk0qaSwmCPEvb
 qbLHCzQtRY4zP+A34qnL+yyxD6dwK0mT/7EHOOvyCrsvGu2GzMageMe68FA+r7qfkGG3
 FZqX24Gh5FRbda9BOPJpSUExXPURHVEY2PZwy+RUn7na7BgKA+RcKf10S6+FtqnI2inX
 +079tFPY5xaemXlaY89MVgkBaJ1A5ma2afSgCOwH61a2E6CKe1FbYc96GeGWWeIvdofM
 4T8dpVJqXwd6snwzb9L2ScFaljBRicUt6yQRFAPWUIzAlLZ/5gjvr1tH09TyALZAn2yp
 Zrcw==
References: <20201213024018.772586-1-vladimir.oltean@nxp.com>
 <20201213024018.772586-3-vladimir.oltean@nxp.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6ee91a90-9c27-9001-66af-9bf16081f3b5@gmail.com>
Date: Sat, 12 Dec 2020 19:43:10 -0800
MIME-Version: 1.0
In-Reply-To: <20201213024018.772586-3-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next 2/6] net: dsa: don't use
 switchdev_notifier_fdb_info in dsa_switchdev_event_work
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
> Currently DSA doesn't add FDB entries on the CPU port, because it only
> does so through switchdev, which is associated with a net_device, and
> there are none of those for the CPU port.
> 
> But actually FDB addresses on the CPU port have some use cases of their
> own, if the switchdev operations are initiated from within the DSA
> layer. There is just one problem with the existing code: it passes a
> structure in dsa_switchdev_event_work which was retrieved directly from
> switchdev, so it contains a net_device. We need to generalize the
> contents to something that covers the CPU port as well: the "ds, port"
> tuple is fine for that.
> 
> Note that the new procedure for notifying the successful FDB offload is
> inspired from the rocker model.
> 
> Also, nothing was being done if added_by_user was false. Let's check for
> that a lot earlier, and don't actually bother to schedule the worker
> for nothing.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
