Return-Path: <netdev@kapio-technology.com>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 447F060A92
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 224E56074C
MIME-Version: 1.0
Date: Fri, 28 Oct 2022 09:45:52 +0200
From: netdev@kapio-technology.com
In-Reply-To: <20221027225832.2yg4ljivjymuj353@skbuf>
References: <20221025100024.1287157-1-idosch@nvidia.com>
 <20221025100024.1287157-2-idosch@nvidia.com>
 <20221027225832.2yg4ljivjymuj353@skbuf>
Message-ID: <1a66212fdb43fb8d03fc1e4c7612ad1b@kapio-technology.com>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Bridge] [RFC PATCH net-next 01/16] bridge: Add MAC
 Authentication Bypass (MAB) support
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/bridge>, 
 <mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/bridge/>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/bridge>,
 <mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: petrm@nvidia.com, ivecera@redhat.com, Ido Schimmel <idosch@nvidia.com>, razor@blackwall.org, bridge@lists.linux-foundation.org, roopa@nvidia.com, edumazet@google.com, mlxsw@nvidia.com, jiri@nvidia.com, netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net

On 2022-10-28 00:58, Vladimir Oltean wrote:

> I was going to ask if we should bother to add code to prohibit packets
> from being forwarded to an FDB entry that was learned as LOCKED, since
> that FDB entry is more of a "ghost" and not something fully committed?

I think that it is a security flaw if there is any forwarding to 
BR_FDB_LOCKED
entries. I can imagine a host behind a locked port with no credentials,
that gets a BR_FDB_LOCKED entry and has a friend on another non-locked 
port
who can now communicate uni-directional to the host with the 
BR_FDB_LOCKED
entry. It should not be too hard to create a scheme using UDP packets or
other for that.
