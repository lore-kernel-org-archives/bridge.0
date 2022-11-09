Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A14A6607F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 43F80606CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJYNp6B4RIkw2Wy5U9y/S7bx/F45jNEyySKuYSJBQiE=;
 b=ZE2w6FvxcA1h8W2BLsvX3XfnvB5z21Mwgi55K0PFztVTACMfDy/AX5Dae5zIW4bXmzBcL7sBrEfblfmTF9lqtn+OJwTq7GYfcc+wCGwAPHDP3zYEqXzEAgDyz38HFUnyLCTQIdHBGBbPejLfKTr4iF1RmvQ63AbBmWxOUs71WzNwYwJzdH71/bHGQLpsKhH2k7LaBeJtC/9/884oHPDBU4joC2xRdv+qC92ozm3yomXl+2XRj2NgBmTnU4XlE0I1eNz2ViQE/QCyjMwdq1dYtSS8W/vOuFAdJJKBIwdn0wp/OxkfCpmDUaRThkM0Ck0xLycRZvdPbNhLiadQHLmIKw==
Date: Wed, 9 Nov 2022 10:26:29 +0200
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y2tkNa7nnAdeD5Nc@shredder>
References: <cover.1667902754.git.petrm@nvidia.com>
 <f433543efdb610ef5a6aba9ac52b4783ff137a13.1667902754.git.petrm@nvidia.com>
 <20221108145929.qmu2gvd5vvgvasyy@skbuf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108145929.qmu2gvd5vvgvasyy@skbuf>
MIME-Version: 1.0
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
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Petr Machata <petrm@nvidia.com>, Ivan Vecera <ivecera@redhat.com>, bridge@lists.linux-foundation.org, netdev@vger.kernel.org, Nikolay Aleksandrov <razor@blackwall.org>, Jiri Pirko <jiri@nvidia.com>, "Hans J . Schultz" <netdev@kapio-technology.com>, Eric Dumazet <edumazet@google.com>, mlxsw@nvidia.com, Roopa Prabhu <roopa@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>

On Tue, Nov 08, 2022 at 04:59:29PM +0200, Vladimir Oltean wrote:
> Can't really figure out from the patch, sorry. Port security works with
> LAG offload?

Yes. It's just that port security needs to be enabled on each of the
member ports. FDB entries that point to a LAG are programmed with a
lag_id. When a packet is received from a LAG the hardware will compare
source_lag_id == lag_id instead of rx_local_port == tx_local_port.
