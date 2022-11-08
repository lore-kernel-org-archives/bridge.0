Return-Path: <olteanv@gmail.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1E2FC4025D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 37807401A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5+moI56BVGSpSI7NRhPLKmv5unmEMYSjuvcZ0Mb6yFY=;
 b=n3e/n0SREsvjcgxpduufQ2rlt6toRTNhJcM8JrQeukA4/U+lHZXB9kDA1SzJCqKoT0
 uzMvbfUa4yBKehzvw6CpQ0/+RGtr98Q+GlVJCLx7kMTL0j/ch+07wVR8eDcezjZh5Pu3
 mu9Gv5XMXYG476C5JuGodX3JWHum1X4GtHuB/Wg1pTUINexkXK3cTo3XxG9Q+wFobBm4
 C1F1DY0WLuplv+d+DUK/C9xZay8xesM+HxCckaUeaF4KNzMkLOGtg9QILXHcmmRTjbdk
 EhsEldZIGzvL90+ifSyKLnLUn58oegecqiu/pPXG8zkAv6DAG6WT530qcPmhcgujw9Td
 VQ3g==
From: Vladimir Oltean <olteanv@gmail.com>
Date: Tue, 8 Nov 2022 16:16:26 +0200
Message-ID: <20221108141626.eymqr6lomtppeaek@skbuf>
References: <cover.1667902754.git.petrm@nvidia.com>
 <b266dcf6d647684a10984d12f98549f93fd378ab.1667902754.git.petrm@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b266dcf6d647684a10984d12f98549f93fd378ab.1667902754.git.petrm@nvidia.com>
Subject: Re: [Bridge] [PATCH net-next 01/15] bridge: switchdev: Let device
 drivers determine FDB offload indication
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

On Tue, Nov 08, 2022 at 11:47:07AM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> Currently, FDB entries that are notified to the bridge via
> 'SWITCHDEV_FDB_ADD_TO_BRIDGE' are always marked as offloaded. With MAB
> enabled, this will no longer be universally true. Device drivers will
> report locked FDB entries to the bridge to let it know that the
> corresponding hosts required authorization, but it does not mean that
> these entries are necessarily programmed in the underlying hardware.
> 
> Solve this by determining the offload indication based of the
> 'offloaded' bit in the FDB notification.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
