Return-Path: <kuba@kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610684050;
 bh=2pbAemQNRup2me0OaNGafy1g5R/x8+eGuOc+MB36rVo=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=T7byPPZfiIKDKCFJEexDVf055Pp47eELH51bVEQ2e0/npgyzbODUVCbiC6nN5KKp1
 a2dCmcII0G24vxWk7d1khxfHImGQJuQ35x0tQuHru0uDrARuSkjbHFr/kEV5CzPQO0
 Qg5N+5A7F6dzJKju2qxvACLffu9w5VVlRXcVHXsKm9s7uHJzdY31VqtV+G7csUp/G6
 meHjl4MS6vN9Oi8tmAZPiJBr+Ximfn44tCy1XHnqXtD8T1pzjZBk9fDW66QJ5qjDOD
 0pNKzUgzyo2wlLPdYLPg4hE+cSu8rhKDBJEv2QL8fuZFcnA/KhYyZEEcHLtl+9cdst
 lAuyv/2u1Ot1g==
Date: Thu, 14 Jan 2021 20:14:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
Message-ID: <20210114201409.41778f77@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210115022344.4407-1-dong.menglong@zte.com.cn>
References: <20210115022344.4407-1-dong.menglong@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [PATCH v2 net-next] net: bridge: check vlan with
 eth_type_vlan() method
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: menglong8.dong@gmail.com
Cc: Menglong Dong <dong.menglong@zte.com.cn>, netdev@vger.kernel.org, bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org, nikolay@nvidia.com, roopa@nvidia.com, davem@davemloft.net

On Thu, 14 Jan 2021 18:23:44 -0800 menglong8.dong@gmail.com wrote:
> From: Menglong Dong <dong.menglong@zte.com.cn>
> 
> Replace some checks for ETH_P_8021Q and ETH_P_8021AD with
> eth_type_vlan().
> 
> Signed-off-by: Menglong Dong <dong.menglong@zte.com.cn>

This adds a new warning when built with W=1 C=1:

net/bridge/br_vlan.c:920:28: warning: incorrect type in argument 1 (different base types)
net/bridge/br_vlan.c:920:28:    expected restricted __be16 [usertype] ethertype
net/bridge/br_vlan.c:920:28:    got unsigned long val
