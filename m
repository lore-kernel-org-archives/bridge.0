Return-Path: <davem@davemloft.net>
Date: Tue, 29 Jun 2021 11:52:13 -0700 (PDT)
Message-Id: <20210629.115213.547056454675149348.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <20210629140658.2510288-1-olteanv@gmail.com>
References: <20210629140658.2510288-1-olteanv@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 00/15] RX filtering in DSA
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: olteanv@gmail.com
Cc: andrew@lunn.ch, f.fainelli@gmail.com, jiri@resnulli.us, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, vladimir.oltean@nxp.com, idosch@idosch.org, nikolay@nvidia.com, roopa@nvidia.com, kuba@kernel.org, vivien.didelot@gmail.com, tobias@waldekranz.com

From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue, 29 Jun 2021 17:06:43 +0300

> Changes in v5:
> - added READ_ONCE and WRITE_ONCE for fdb->dst
> - removed a paranoid WARN_ON in DSA
> - added some documentation regarding how 'bridge fdb' is supposed to be
>   used with DSA

Vlad, I applied v4, could you please send me relative fixups to v5?

Thank you.
