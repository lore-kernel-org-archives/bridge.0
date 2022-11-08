Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 585B6415AB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3E65E410D4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J1AA1jk+noLUWn3EI/QqWPmqga5tVeAmuKcLyOASUC4=;
 b=IEWU2L7UG31b+6vQvoFxaCyrT42BgWijq9qxlw0Uf/9Ba6xAlk4Bxgxca1Xcm8Ccuo
 7F2ubojIxKLT/0z31+7rEioqCjL2UD9+Azteadg8f1HjRQszJBAlfPRNF/VxTvrN968B
 8vxl69gCu+f5oUJixPF3rpKhITtTFXqZwNMrAEfwFyB/ytzWO4PWvIrOmRxjvOwWnjYY
 h8Q+OBg2avLxlA/HgFl/re7DwIg27wrbAK8tPaR8IidURoG0tL4XgJApZjlB1wM+hetX
 bys9z9qYflR+sGikSVfflk4z4VeNvof2IvEc1wU7JbruXt0fpmk4hHpk/3HHTCmdPVNY
 kYXA==
Date: Tue, 8 Nov 2022 16:59:29 +0200
From: Vladimir Oltean <olteanv@gmail.com>
Message-ID: <20221108145929.qmu2gvd5vvgvasyy@skbuf>
References: <cover.1667902754.git.petrm@nvidia.com>
 <f433543efdb610ef5a6aba9ac52b4783ff137a13.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f433543efdb610ef5a6aba9ac52b4783ff137a13.1667902754.git.petrm@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next 11/15] mlxsw: spectrum_switchdev: Add
 locked bridge port support
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

On Tue, Nov 08, 2022 at 11:47:17AM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Add locked bridge port support by reacting to changes in the
> 'BR_PORT_LOCKED' flag. When set, enable security checks on the local
> port via the previously added SPFSR register.
> 
> When security checks are enabled, an incoming packet will trigger an FDB
> lookup with the packet's source MAC and the FID it was classified to. If
> an FDB entry was not found or was found to be pointing to a different
> port, the packet will be dropped. Such packets increment the
> "discard_ingress_general" ethtool counter. For added visibility, user
> space can trap such packets to the CPU by enabling the "locked_port"
> trap. Example:
> 
>  # devlink trap set pci/0000:06:00.0 trap locked_port action trap

Got the answer I was looking for.

> 
> Unlike other configurations done via bridge port flags (e.g., learning,
> flooding), security checks are enabled in the device on a per-port basis
> and not on a per-{port, VLAN} basis. As such, scenarios where user space
> can configure different locking settings for different VLANs configured
> on a port need to be vetoed. To that end, veto the following scenarios:
> 
> 1. Locking is set on a bridge port that is a VLAN upper
> 
> 2. Locking is set on a bridge port that has VLAN uppers
> 
> 3. VLAN upper is configured on a locked bridge port
> 
> Examples:
> 
>  # bridge link set dev swp1.10 locked on
>  Error: mlxsw_spectrum: Locked flag cannot be set on a VLAN upper.
> 
>  # ip link add link swp1 name swp1.10 type vlan id 10
>  # bridge link set dev swp1 locked on
>  Error: mlxsw_spectrum: Locked flag cannot be set on a bridge port that has VLAN uppers.
> 
>  # bridge link set dev swp1 locked on
>  # ip link add link swp1 name swp1.10 type vlan id 10
>  Error: mlxsw_spectrum: VLAN uppers are not supported on a locked port.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---

Can't really figure out from the patch, sorry. Port security works with
LAG offload?
