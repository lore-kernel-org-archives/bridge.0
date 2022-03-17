Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=IZV5DOXaMBCK1WqYO4leOyigBVsvYn+ptdXXPyZIhWM=;
 b=LBhEVWCr3VYIX8oZnOnGnf4o4J2WHcaNKXshvqkeyhDkH27yDexv8/kyFq7AxZVR0o
 sF55l/ZYgbybYCaTURyx3KRFpjMBU479zToX5ghT8P45PLVMEPxst1e0wbwWHkXSqotL
 aS0CptGgoLxyZ6cLY7x3vWUUOa0Nxrc1rt7ePaYkoI6YybSwpu0cGNxQdTDngMgySrbb
 1fq8olG+RAkRVMLI5/20f8Kpw5b9YuGvPYZ9J4hocMpG/JwodazOImzZn2MFkKvH4ryP
 EMEjFMURbz5tZy7jKDeJX2m1ZHwbynSmCTQKAnDBvgvT1CMhBPpmW5CNrQ0pzSP5Q0Yc
 tTiQ==
Message-ID: <ed581b85-822b-c7bd-b614-fb87e918d314@blackwall.org>
Date: Thu, 17 Mar 2022 10:57:35 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220316150857.2442916-1-tobias@waldekranz.com>
 <20220316150857.2442916-6-tobias@waldekranz.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220316150857.2442916-6-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 05/15] net: bridge: mst: Notify
 switchdev drivers of VLAN MSTI migrations
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
> Whenever a VLAN moves to a new MSTI, send a switchdev notification so
> that switchdevs can track a bridge's VID to MSTI mappings.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  include/net/switchdev.h   |  7 ++++++
>  net/bridge/br_mst.c       | 13 +++++++++++
>  net/bridge/br_switchdev.c | 46 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 66 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


