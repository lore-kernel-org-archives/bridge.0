Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 98AFD60D67
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 27FB360D66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I/2XrmdghbmaaNa8DlOtVmiZ6wnxuyN0Gwxqhrv9NWE=;
 b=Lob1t9kBBiWI2SJB+VBPSsmDx3w9cLYoa/XYK5DPyPLjn2NW1BilVWMW4gVJOLeLpB
 3NwRl39PRdmdpR/aimOMTtw1u8xfCs3WMXLc5F+aPdHEgJHNgcKZN/S4LLdTNReEt5P6
 hJ+z0NUcQ/UfvZ1YWSEGQv0qG4TfLF57zEDfViihTEH1JbqXcvMpvrSeiiBC+uq4PcFA
 Zk9WwtvmRC8X3RKcXYDqJNxVcuic2vLmjSR2RXyH5fWvJp++Mhm/WaSKSxn0JB7QzA1j
 UkTQ1F5C3hC1Q7GW6rxT7s8dWug1PbB4v1X87r849cazqyMaNg62KWhIfEaB1Cos4WRj
 UpQg==
Date: Tue, 8 Nov 2022 16:22:44 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221108142244.r5polveqve3ckr7j@skbuf>
References: <cover.1667902754.git.petrm@nvidia.com>
 <2db3f3f1eff65e42c92a8e3a5626d64f46e68edc.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db3f3f1eff65e42c92a8e3a5626d64f46e68edc.1667902754.git.petrm@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next 03/15] bridge: switchdev: Reflect MAB
 bridge port flag to device drivers
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Petr Machata <petrm@nvidia.com>
Cc: Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Jiri Pirko <jiri@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>, Eric Dumazet <edumazet@google.com>, mlxsw@nvidia.com, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Tue, Nov 08, 2022 at 11:47:09AM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Reflect the 'BR_PORT_MAB' flag to device drivers so that:
> 
> * Drivers that support MAB could act upon the flag being toggled.
> * Drivers that do not support MAB will prevent MAB from being enabled.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
