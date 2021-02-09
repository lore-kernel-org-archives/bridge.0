Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=3IKSUC2PbMBLcmAxJNHDlsNxrnoGLUkLdRWIm40sEpc=;
 b=LGw97nE1cdPwc3VbbdI7b3jcHyQ5rDSJXCpydItAPA5Duy7SnDry4v7J4PxhT0geS6
 Q4VfKF0h844R3hVgCo54tdyExYyz5Mey9SqemYKef05Yhwl4eX8VZhJCjjGd2Xa90O01
 PnHKbpH7BtHXyaPZdZzcY8cS02pRNsKUyPv6GdpdSnLDmd10xlE6NysARS0+T9Q2KY8d
 x+HvCxriBjgv2a78wFPePpW0sqjFfX106VbA50dcMre5AA483PPmKFWlhW2zJyqeYOF0
 C+PC6bAZ12wwNYmvAyxSoUAZXPDe8phSMQd5gPunsSFUMFjEqG1rYCstOM4qG53nb86p
 roMg==
Date: Tue, 9 Feb 2021 19:36:31 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20210209173631.c75cdjxphwzipeg5@skbuf>
References: <20210209151936.97382-1-olteanv@gmail.com>
 <20210209151936.97382-4-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210209151936.97382-4-olteanv@gmail.com>
Subject: Re: [Bridge] [PATCH v2 net-next 03/11] net: bridge: don't print in
 br_switchdev_set_port_flag
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Ivan Vecera <ivecera@redhat.com>, Andrew Lunn <andrew@lunn.ch>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Florian Fainelli <f.fainelli@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Vadym Kochan <vkochan@marvell.com>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, Ioana Ciornei <ioana.ciornei@nxp.com>, linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com, Taras Chornyi <tchornyi@marvell.com>, Ido Schimmel <idosch@idosch.org>, Claudiu Manoil <claudiu.manoil@nxp.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, linux-omap@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>

On Tue, Feb 09, 2021 at 05:19:28PM +0200, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
>
> Currently br_switchdev_set_port_flag has two options for error handling
> and neither is good:
> - The driver returns -EOPNOTSUPP in PRE_BRIDGE_FLAGS if it doesn't
>   support offloading that flag, and this gets silently ignored and
>   converted to an errno of 0. Nobody does this.
> - The driver returns some other error code, like -EINVAL, in
>   PRE_BRIDGE_FLAGS, and br_switchdev_set_port_flag shouts loudly.
>
> The problem is that we'd like to offload some port flags during bridge
> join and leave, but also not have the bridge shout at us if those fail.
> But on the other hand we'd like the user to know that we can't offload
> something when they set that through netlink. And since we can't have
> the driver return -EOPNOTSUPP or -EINVAL depending on whether it's
> called by the user or internally by the bridge, let's just add an extack
> argument to br_switchdev_set_port_flag and propagate it to its callers.
> Then, when we need offloading to really fail silently, this can simply
> be passed a NULL argument.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---

The build fails because since I started working on v2 and until I sent
it, Jakub merged net into net-next which contained this fix:
https://patchwork.kernel.org/project/netdevbpf/patch/20210207194733.1811529-1-olteanv@gmail.com/
for which I couldn't change prototype due to it missing in net-next.
I think I would like to rather wait to gather some feedback first before
respinning v3, if possible.
