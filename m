Return-Path: <razor@blackwall.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=blackwall-org.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=ToAuSw9noF4PMelZcjz5Ho1d/K/t8qdLlfiN+Gz3OL8=;
 b=x0Cy2WjKJUWqxiiIHewCcWsmwWtT91gESaE6raQXk0ObQUNUgGnl0H5BmNYfRCSGEP
 FlM3MY5srYU1AhhYONSQmQtEFRCb+GS/o0ctE1/4aiYnh6Zb4k0ZdC00KVw2lPquQ2in
 YEQwenvqU2eCpO2N1+B6wvVxDJ2F12Z5S5G5dS9w8i2pOzH6giS3GVzaiM9cMH/5LwrT
 AoaPjM00dt/yGzCK01Fmo8QhKRvL9MFL9AvnYTerZvCBZFjh9VqvT4WhAnpOKDXgS29C
 +v+jSffdrztf19PA6TLAhFnriMdlZU6zMMJ4p5z0vtmRuVh3yvjuewscorTSK1J3zgiC
 V1mA==
Message-ID: <9c821989-cbba-f2ea-c5fc-6fc6bbd34e7e@blackwall.org>
Date: Thu, 17 Mar 2022 10:57:54 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220316150857.2442916-1-tobias@waldekranz.com>
 <20220316150857.2442916-7-tobias@waldekranz.com>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20220316150857.2442916-7-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v5 net-next 06/15] net: bridge: mst: Notify
 switchdev drivers of MST state changes
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
> Generate a switchdev notification whenever an MST state changes. This
> notification is keyed by the VLANs MSTI rather than the VID, since
> multiple VLANs may share the same MST instance.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  include/net/switchdev.h |  7 +++++++
>  net/bridge/br_mst.c     | 18 ++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

