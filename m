Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 01A6640198
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A900B4011F
MIME-Version: 1.0
Date: Tue, 25 Oct 2022 16:09:07 +0200
From: netdev@kapio-technology.com
In-Reply-To: <20221025100024.1287157-1-idosch@nvidia.com>
References: <20221025100024.1287157-1-idosch@nvidia.com>
Message-ID: <274f1bb19fbf00ee053b042abca0107d@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
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
To: Ido Schimmel <idosch@nvidia.com>
Cc: petrm@nvidia.com, ivecera@redhat.com, netdev@vger.kernel.org, razor@blackwall.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, vladimir.oltean@nxp.com, edumazet@google.com, mlxsw@nvidia.com, jiri@nvidia.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 2022-10-25 12:00, Ido Schimmel wrote:
> 
> Future work
> ===========
> 
> The hostapd fork by Westermo is using dynamic FDB entries to authorize
> hosts [3]. Changes are required in switchdev to allow such entries to 
> be
> offloaded. Hans already indicated he is working on that [4]. It should
> not necessitate any uAPI changes so I do not view it as a blocker 
> (Hans,
> please confirm).

The dynamic ATU patchset will do changes in the switchdev and DSA layers
and in the driver of course, so I suppose that confirms what you think
(e.g. no changes in include/uapi), but it requires the fdb_flags towards
drivers patches of course and MAB driver changes, that are part of my
v8 patchset.
