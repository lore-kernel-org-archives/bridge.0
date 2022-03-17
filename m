Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=4ZlWGxIpVMVSY4V9SoW9sLygWbw7lhRyEfpNfhcyNy0=;
 b=WZo0NpgYpZQKUgwmEdn2MTli/3WmlFymvJyM+baA8S8m5W0189q68tTkoAVejAc4ah
 OBa4dH/8SCDYAgZj5ldxQN8dJOFsr/d/PJHDDJcehCod9DI920z16UHkDFV+dXdZa0+N
 uJjGZpAsvxLZwXFZ4LxUHEKM7Z9x9R1kMXSnhC5t9WCL89OfPbwNTxAW79YOXnRS8xLt
 oha28QETzSbjcQ1HcSpPF2X4YHbs7vVg/KDYh2nnMSKfz65hmNfaq22eF0pKPilRccaE
 CexkcWcZ6Q3B11iTQxj4Cbips/qWNoSDGwCl3wzuAoitX6JULlgPxsCW5l8t3Qzs/L60
 vmNA==
Message-ID: <b515e6de-fd84-8ed2-70f1-7c4eae851d94@blackwall.org>
Date: Thu, 17 Mar 2022 10:56:17 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220316150857.2442916-1-tobias@waldekranz.com>
 <20220316150857.2442916-5-tobias@waldekranz.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220316150857.2442916-5-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 04/15] net: bridge: mst: Notify
 switchdev drivers of MST mode changes
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
> Trigger a switchdev event whenever the bridge's MST mode is
> enabled/disabled. This allows constituent ports to either perform any
> required hardware config, or refuse the change if it not supported.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  include/net/switchdev.h |  2 ++
>  net/bridge/br_mst.c     | 11 +++++++++++
>  2 files changed, 13 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

