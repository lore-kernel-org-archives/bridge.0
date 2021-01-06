Return-Path: <f.fainelli@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=McrtQ8obU5Om5cXyFjqgKkVkgEBA+mbnsrN4F43Q2fs=;
 b=jzK6m5S0ncmUTayTpfPfajH1g/vkb6m6uIM5t+CYi3+GDEJ2E5MSJje4olEJucmKjK
 6MTAAaWiSueQ7f9bQgO/0Y6kJqewl35WcT75d2xq4ay91THc24lEIJWdBJ1/K+Gn4zZu
 kq9UjT92OrKuu22umvEMcXClJqYV16mfe5NkgVa/KNWx5MKi3oumZfhRTOEpx4snyZaj
 lBhg7PhL0BiBIOABeMHdl4IaEfrokt3/72F/hNIkQVpb8oPD6vd2l3Ix1q6vjLito+RX
 Lb6Swc2ViJqzIOD/955ONw19MXOLO8UZXE8O5MmdA/vT+98p0bjgD8/UDvQSJSeEl/8V
 AElg==
References: <20210106095136.224739-1-olteanv@gmail.com>
 <20210106095136.224739-3-olteanv@gmail.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <96cdb139-fdcd-521f-4c19-f24a994afed5@gmail.com>
Date: Wed, 6 Jan 2021 09:44:02 -0800
MIME-Version: 1.0
In-Reply-To: <20210106095136.224739-3-olteanv@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v4 net-next 2/7] net: dsa: be louder when a
 non-legacy FDB operation fails
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, "David S. Miller" <davem@davemloft.net>
Cc: Jiri Pirko <jiri@resnulli.us>, Alexandra Winter <wintera@linux.ibm.com>, Ido Schimmel <idosch@idosch.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>, Marek Behun <marek.behun@nic.cz>, DENG Qingfang <dqfext@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, UNGLinuxDriver@microchip.com, Tobias Waldekranz <tobias@waldekranz.com>

On 1/6/21 1:51 AM, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> The dev_close() call was added in commit c9eb3e0f8701 ("net: dsa: Add
> support for learning FDB through notification") "to indicate inconsistent
> situation" when we could not delete an FDB entry from the port.
> 
> bridge fdb del d8:58:d7:00:ca:6d dev swp0 self master
> 
> It is a bit drastic and at the same time not helpful if the above fails
> to only print with netdev_dbg log level, but on the other hand to bring
> the interface down.
> 
> So increase the verbosity of the error message, and drop dev_close().
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
