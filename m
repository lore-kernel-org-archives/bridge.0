Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=r3SbgvMuwSpWyo+T3+2fkvrANVSSGA2KeBMI0vAa/Mc=;
 b=2j+iM3bcJEKwZ9uQ0GbufP5c4a0aJdPJFZH7++cftGYb4uc9hqczdgnotS2iTFwHJb
 40s1RKE4GJ0yvZDGQ1F8skW+18wz1+Ddjs60vDfIK0lMQjWjzeIfz+aW7mMPT12CsZVK
 dImyN46Ms8XYA2nqjzP5RRzJLNLGlPTPBHfDTKEjTQVzaj/euYTuaHuMJTxKZascYJVr
 fcjEE3Q4QdmpnV+2dEbexMR7hOLp5FC55xHDwRr566gUc5ZNZCGIFJTvnUOyUDLn1SSv
 PmRMThfNlvodXhLEHQVmRQzaEH798W6+DZ2QYQbzp6CuWoagDEwehLxAUvFa/x8TLK2r
 RMlw==
Message-ID: <0a95bd84-9f1a-da44-0e70-a53e3b7402db@blackwall.org>
Date: Mon, 14 Mar 2022 12:45:02 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220314095231.3486931-1-tobias@waldekranz.com>
 <20220314095231.3486931-3-tobias@waldekranz.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220314095231.3486931-3-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v3 net-next 02/14] net: bridge: mst: Allow
 changing a VLAN's MSTI
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net, kuba@kernel.org
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, bridge@lists.linux-foundation.org, Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Cooper Lees <me@cooperlees.com>, Roopa Prabhu <roopa@nvidia.com>, Matt Johnston <matt@codeconstruct.com.au>, Vladimir Oltean <olteanv@gmail.com>, Vivien Didelot <vivien.didelot@gmail.com>

On 14/03/2022 11:52, Tobias Waldekranz wrote:
> Allow a VLAN to move out of the CST (MSTI 0), to an independent tree.
> 
> The user manages the VID to MSTI mappings via a global VLAN
> setting. The proposed iproute2 interface would be:
> 
>     bridge vlan global set dev br0 vid <VID> msti <MSTI>
> 
> Changing the state in non-zero MSTIs is still not supported, but will
> be addressed in upcoming changes.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  include/uapi/linux/if_bridge.h |  1 +
>  net/bridge/br_mst.c            | 42 ++++++++++++++++++++++++++++++++++
>  net/bridge/br_private.h        |  1 +
>  net/bridge/br_vlan_options.c   | 15 ++++++++++++
>  4 files changed, 59 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

