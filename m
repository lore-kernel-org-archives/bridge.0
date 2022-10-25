Return-Path: <idosch@nvidia.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7CA6480FF8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 88C7580BD2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OA5hlBQ8BCBgj/lgFiRnY2YmuqbtG5HTekJ3OpyagY8=;
 b=NoK9dn2/GxH6FMwBWxOwPKYqguPczk5W5LuycTVxHOyycwaTyYY5yt+YetNwp17l8Qvx7iQWjK6qYrf4iuS5MVar3gJZQ7bhNa2Ua4z/LOo72+t7edow8KR2qEE5f2ojgBJv39E6229k27SJTQ5OOr2GHLDzZG44KGY9FgbEuznVJ00WSVI1xcNoMvh41Mzx1DKJE83TRgBrFNhONogC/kX9PnoM0uqO1AQrWrhQxc3/ZBg4xQPhjpV4pBnwASylHrm9nJTo6dQYyg70izv9oUbVrgSdZfTIe2ZCov6E3O0qVYMbs9u7tlr+mH32i8YuqctRCMAtm0Zc52TT07ZPeg==
Date: Tue, 25 Oct 2022 20:43:16 +0300
From: Ido Schimmel <idosch@nvidia.com>
Message-ID: <Y1ggNEXVAMhtmMFR@shredder>
References: <20221025100024.1287157-1-idosch@nvidia.com>
 <274f1bb19fbf00ee053b042abca0107d@kapio-technology.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <274f1bb19fbf00ee053b042abca0107d@kapio-technology.com>
MIME-Version: 1.0
Subject: Re: [Bridge] [RFC PATCH net-next 00/16] bridge: Add MAC
 Authentication Bypass (MAB) support with offload
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: netdev@kapio-technology.com
Cc: petrm@nvidia.com, ivecera@redhat.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, vladimir.oltean@nxp.com, edumazet@google.com, mlxsw@nvidia.com, jiri@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On Tue, Oct 25, 2022 at 04:09:07PM +0200, netdev@kapio-technology.com wrote:
> On 2022-10-25 12:00, Ido Schimmel wrote:
> > 
> > Future work
> > ===========
> > 
> > The hostapd fork by Westermo is using dynamic FDB entries to authorize
> > hosts [3]. Changes are required in switchdev to allow such entries to be
> > offloaded. Hans already indicated he is working on that [4]. It should
> > not necessitate any uAPI changes so I do not view it as a blocker (Hans,
> > please confirm).
> 
> The dynamic ATU patchset will do changes in the switchdev and DSA layers
> and in the driver of course, so I suppose that confirms what you think
> (e.g. no changes in include/uapi), but it requires the fdb_flags towards
> drivers patches of course and MAB driver changes, that are part of my
> v8 patchset.

Any comments on the merge plan and patches #1-#4?
