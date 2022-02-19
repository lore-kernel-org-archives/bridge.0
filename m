Return-Path: <olteanv@gmail.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=eyoLzh3GoCjEcko6E6TRX3Q0MN5P8KHlKdLhPGSzjas=;
 b=nnddJEcHqLBBgfgW6X8nP2hJ+jbcGZujjBROoEt9DQKra/B8N1F3VqRROEaOdXzS1G
 TnmFhHNUyN5sK64vsVyWIaI5/IWYIRSDlRlHN9lO44vm9/RH205qjm0HVp0WDQBkojHS
 SxK7lXv9qPuxBw0h8IcrUN22V3RAYtX9gwDEXgiSTbwCKm6Cv+emuMeHX4pjOUOxLO1r
 SBJvros1knM0ArBLcFpYEDQBMbDEOjZyNBZZLUKg0Dh+l34NitpBj33SGW8TgzKLy4aU
 BUdMEoxEsM4NVFdyaStDhqIhtOms7cKP4Ae+XytJsnPBGISv5erc6kLo/q/y+6+jwYSL
 tJVg==
Date: Sat, 19 Feb 2022 12:00:34 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20220219100034.lh343dkmc4fbiad3@skbuf>
References: <20220218155148.2329797-1-schultz.hans+netdev@gmail.com>
 <20220218155148.2329797-5-schultz.hans+netdev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220218155148.2329797-5-schultz.hans+netdev@gmail.com>
Subject: Re: [Bridge] [PATCH net-next v3 4/5] net: dsa: mv88e6xxx: Add
 support for bridge port locked mode
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Hans Schultz <schultz.hans@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew@lunn.ch>, Baowen Zheng <baowen.zheng@corigine.com>, Florian Fainelli <f.fainelli@gmail.com>, Amit Cohen <amcohen@nvidia.com>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Vivien Didelot <vivien.didelot@gmail.com>, Hans Schultz <schultz.hans+netdev@gmail.com>, Po-Hsu Lin <po-hsu.lin@canonical.com>, Nikolay Aleksandrov <nikolay@nvidia.com>, linux-kselftest@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, kuba@kernel.org, Stephen Suryaputra <ssuryaextr@gmail.com>, Shuah Khan <shuah@kernel.org>, davem@davemloft.net

On Fri, Feb 18, 2022 at 04:51:47PM +0100, Hans Schultz wrote:
> diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
> index ab41619a809b..46b7381899a0 100644
> --- a/drivers/net/dsa/mv88e6xxx/port.c
> +++ b/drivers/net/dsa/mv88e6xxx/port.c
> @@ -1234,6 +1234,39 @@ int mv88e6xxx_port_set_mirror(struct mv88e6xxx_chip *chip, int port,
>  	return err;
>  }
>  
> +int mv88e6xxx_port_set_lock(struct mv88e6xxx_chip *chip, int port,
> +			    bool locked)
> +{
> +	u16 reg;
> +	int err;
> +
> +	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_CTL0, &reg);
> +	if (err)
> +		return err;
> +
> +	reg &= ~MV88E6XXX_PORT_CTL0_SA_FILT_MASK;
> +	if (locked)
> +		reg |= MV88E6XXX_PORT_CTL0_SA_FILT_DROP_ON_LOCK;
> +
> +	err = mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_CTL0, reg);
> +	if (err)
> +		return err;
> +
> +	err = mv88e6xxx_port_read(chip, port, MV88E6XXX_PORT_ASSOC_VECTOR, &reg);
> +	if (err)
> +		return err;
> +
> +	reg &= ~MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT;
> +	if (locked)
> +		reg |= MV88E6XXX_PORT_ASSOC_VECTOR_LOCKED_PORT;
> +
> +	err = mv88e6xxx_port_write(chip, port, MV88E6XXX_PORT_ASSOC_VECTOR, reg);

	return mv88e6xxx_port_write(...);

> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
